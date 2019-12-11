#ifndef __FBFW_TASKS_WORKERTHREAD__
#define __FBFW_TASKS_WORKERTHREAD__

namespace Tasks
  /'
    A worker thread of execution. 
    
    Worker threads are under the control of a Task Manager, that assigns tasks
    to them according to their availability and workload. They are not
    designed to be used standalone, and the user does not need to deal with
    it directly.
  '/
  type _
    WorkerThread _
    extends WorkerThreadBase
    
    public:
      declare constructor( _
        byref as const string, _
        byval as TaskManager ptr )
      declare virtual destructor() override
      
      declare sub _
        start() override
      declare sub _
        stop() override
      declare sub _
        attachTask( _
          byval as ITask ptr ) override
      declare sub _
        resumeTask( _
          byval as ITask ptr ) override
      declare function _
        detachTask() as ITask ptr override
      declare function _
        getMonitor() as WorkerThreadMonitor ptr override
      
    protected:
      declare constructor()
    
    private:
      declare static sub _
        run( byval as WorkerThread ptr )
      
      as double _
        _totalIdleTime, _
        _totalWorkTime
      as integer _
        _completedTasks
      as any ptr _
        _threadID
      as TaskManager ptr _
        _taskManager
      as ITask ptr _
        _task
  end type
  
  constructor _
    WorkerThread()
  end constructor
  
  /'
    This is the constructor that the TaskManager uses to create
    its WorkerThreads.
  '/
  constructor _
    WorkerThread( _
      byref anID as const string, _
      byval aTaskManager as TaskManager ptr )  
    
    base( anID )
    
    _taskManager => aTaskManager
    _running => true
    
    _mutex => mutexCreate()
    _idleCond => condCreate()
    _threadID => threadCreate( _
      cptr( _
        sub( byval as any ptr ), _
        @run ), _
      @this )
  end constructor
  
  destructor _
    WorkerThread()
    
    stop()
    
    threadWait( _threadID )
    mutexDestroy( _mutex )
    condDestroy( _idleCond )
  end destructor
  
  function _
    WorkerThread.getMonitor() _
    as WorkerThreadMonitor ptr
    
    return( new WorkerThreadMonitor( _
      id, _
      @_totalWorkTime, _
      @_totalIdleTime, _
      @_completedTasks ) )
  end function
  
  /'
    The main loop of a WorkingThread. The main loop works like this:
    
    Upon entering the loop, the thread is flagged as 'idle' and becomes
    spinlocked, waiting for a conditional signal.
    The conditional signal comes from a TaskManager, which assigns the
    thread the next Task in its internal queue and signals the conditional.
    This causes the thread to exit from the spinlock and execute the Task
    assigned, and upon finishing it tells its TaskManager that it has
    finished the Task assigned. The TaskManager then signals the conditional
    for the thread again, which in turn causes the WorkerThread to be
    spinlocked again, waiting for another task assignment.
  '/
  sub _
    WorkerThread.run( _
      byval instance as WorkerThread ptr )
    
    do
      instance->lock()
      
      '' Assume idle status
      instance->_idle => true
      
      dim as double _
        idleTime => timer()
      
      /'
        Puts the thread to sleep if it's idle. Note that the conditional
        is wrapped up in a loop ('spinlocked'), to prevent spurious wakeups.
        
        While in this sleeping state, the thread doesn't use any CPU cycles.
      '/
      do while( instance->_idle )
        condWait( _
          instance->_idleCond, _
          instance->_mutex )
      loop
      
      idleTime => timer() - idleTime
      instance->_totalIdleTime +=> idleTime
      
      instance->unlock()
      
      /'
        If a Task is assigned to this thread, change its idle status
        and perform the Task that was attached to it.
      '/
      if( instance->_task <> TasksNull ) then
        instance->_idle => false
        
        dim as double _
          workTime => timer()
        
        dim as boolean _
          isFinished => false
        
        do while( _
          cbool( instance->_task->status = TaskStatus.Running ) andAlso _
          not isFinished )
          
          isFinished => instance->_task->finished()
          
          if( not isFinished ) then
            instance->_task->perform()
          end if
          
          sleep( 1, 1 )
        loop
        
        workTime => timer() - workTime
        instance->_totalWorkTime +=> workTime
        
        if( isFinished ) then
          /'
            Signal the TaskManager this thread belongs to that the task
            assigned was successfully completed.
          '/
          if( instance->_taskManager <> TasksNull ) then
            instance->_task->complete__()
            instance->_completedTasks +=> 1
            instance->_taskManager->taskCompleted( instance )
          end if
        else
          /'
            If not, see the reason why the task wasn't completed and act
            accordingly.
          '/
          select case as const( instance->_task->status )
            case( TaskStatus.Aborted )
              instance->_taskManager->abortTask( instance )
            
            case( TaskStatus.Suspended )
              instance->_taskManager->suspendTask( instance ) 
          end select
        end if
      end if
      
      /'
        If the instance isn't running anymore, exit the loop
      '/
      if( not instance->_running ) then
        exit do
      end if
    loop
  end sub
  
  /'
    Starts the thread
  '/
  sub _
    WorkerThread.start()
    
    this.lock()
      _running => true
    this.unlock()
  end sub
  
  /'
    Stops the thread.
    
    Note that the Task this thread was assigned is also aborted,
    and the thread is put to sleep through a conditional.
  '/
  sub _
    WorkerThread.stop()
    
    this.lock()
      _running => false
      _idle => false
      
      if( _task <> TasksNull ) then
        _task->abort()
      end if
      
      condSignal( _idleCond )
    this.unlock()
  end sub
  
  /'
    Attaches a task to this thread. Attaching a Task to a
    thread immediately wakes it up, and the Task is performed
    as soon as it is awakened.
  '/
  sub _
    WorkerThread.attachTask( _
      byval aTask as ITask ptr )
    
    this.lock()
      aTask->start()
      aTask->thread__ => @this
      
      _task => aTask
      _idle => false
      
      condSignal( _idleCond )
    this.unlock()
  end sub
  
  /'
    Attaches a task to this thread but resumes the task instead of
    restarting it.
  '/
  sub _
    WorkerThread.resumeTask( _
      byval aTask as ITask ptr )
    
    this.lock()
      aTask->resume__()
      aTask->thread__ => @this
      
      _task => aTask
      _idle => false
      
      condSignal( _idleCond )
    this.unlock()
  end sub
  
  /'
    Detaches the Task assigned to the thread. Note that the
    thread DOES NOT dispose of the Task.
  '/
  function _
    WorkerThread.detachTask() _
    as ITask ptr
    
    var _
      detached => _task
    
    this.lock()
      detached->thread__ => TasksNull
      
      _task => TasksNull
    this.unlock()
    
    return( detached )
  end function
  
  /'
    The constructor for the TaskManager class is placed here, for
    we can't forward declare the WorkerThread (since we need to
    actually access its constructor here).
  '/
  constructor _
    TaskManager( _
      byval aNumberOfThreads as integer )
    
    /'
      Create the pending and suspended tasks queues
    '/
    _pendingTasks => new LinkedList( of( ITask ) )()
    _suspendedTasks => new LinkedList( of( ITask ) )()
    
    /'
      Then, create the requested number of worker threads
    '/
    _availableThreads => iif( aNumberOfThreads < 2, _
      2, aNumberOfThreads )
    
    redim _
      _threads( 0 to _availableThreads - 1 )
    
    for _
      i as integer => 0 _
      to _availableThreads - 1
      
      _threads( i ) => new WorkerThread( _
        "workerthread" & trim( str( i ) ), @this )
    next
    
    _idleThreadsCount => _availableThreads
    _running => true
    _mutex => mutexCreate()
    _lockMutex => mutexCreate()
    _startTime => now()
    
    '' And create the main thread for the Task Manager itself
    _thread => threadCreate( _
      cptr( _
        sub( byval as any ptr ), _
        @run ), _
      @this )
  end constructor
end namespace

#endif
