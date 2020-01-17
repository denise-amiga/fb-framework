#ifndef __FBFW_TASKS_TASKMANAGER__
#define __FBFW_TASKS_TASKMANAGER__

namespace Tasks
  /'
    The Task Manager class.
    
    This class maintains a series of sleeping threads, which are awakened when
    there's a task queued. It's in charge of distributing tasks across available
    threads, and also takes care of their lifetimes.
    
    If there are no more pending tasks on the queue when a thread completes a task,
    it is sent to sleep, awaiting for more tasks to come. Sleeping threads do not
    consume any resources, nor use any CPU cycles.
    
    ATTENTION: Do note that there's a constructor definition missing, which is
    placed after the WorkerThread definition, because we can't forward define
    WorkerThreads as FreeBasic doesn't support that kind of forward references.
  '/
  type _
    TaskManager _
    
    public:
      declare constructor( _
        byval as integer )
      declare destructor()
      
      declare property _
        availableThreads() as integer
      
      declare sub _
        queueTask( _
          byval as ITask ptr )
      declare sub _
        taskCompleted( _
          byval as WorkerThreadBase ptr )
      declare sub _
        suspendTask( _
          byval as WorkerThreadBase ptr )
      declare sub _
        abortTask( _
          byval as WorkerThreadBase ptr )
        
      declare function _
        getMonitor() as TaskManagerMonitor ptr
      
    private:
      declare constructor()
      
      declare static sub _
        run( _
          byval as TaskManager ptr )
        
      declare sub _
        lock()
      declare sub _
        unlock()
      declare sub _
        cleanUp()
      
      as WorkerThreadBase ptr _
        _threads( any )
      as LinkedList( of( ITask ) ) ptr _
        _pendingTasks, _
        _suspendedTasks
      as double _
        _startTime
      as integer _
        _availableThreads, _
        _completedTasksCount, _
        _idleThreadsCount, _
        _lockCount
      as any ptr _
        _thread, _
        _mutex
      as boolean _
        _running, _
        _locked
  end type
  
  constructor _
    TaskManager()
  end constructor
  
  /'
    Destroy all threads currently created
  '/
  destructor _
    TaskManager()
    
    _running => false
    
    threadWait( _thread )
    mutexDestroy( _mutex )
  end destructor
  
  property _
    TaskManager.availableThreads() _
    as integer
    
    return( _availableThreads )
  end property
  
  sub _
    TaskManager.lock()
    
    if( not _locked ) then
      mutexLock( _mutex )
      _locked => true
    end if
  end sub
  
  sub _
    TaskManager.unlock()
    
    if( _locked ) then
      _locked => false
      mutexUnLock( _mutex )
    end if
  end sub
  
  function _
    TaskManager.getMonitor() _
    as TaskManagerMonitor ptr
    
    return( new TaskManagerMonitor( _
      @_threads( 0 ), _
      @_startTime, _
      @_completedTasksCount, _
      @_availableThreads, _
      @_idleThreadsCount ) )
  end function
  
  /'
    Add a task to the tail of the task queue. Working threads
    remove tasks from the fringe of it.
    
    If the task is running, it will get queued immediately to
    the pending tasks queue. On the other hand, if the task is
    suspended, it will get queued into the suspended tasks queue,
    awaiting for its owner to resume it.
  '/
  sub _
    TaskManager.queueTask( _
      byval aTask as ITask ptr )
    
    this.lock()
    
    select case as const( aTask->status )
      case( TaskStatus.Halted )
        _pendingTasks->addLast( *aTask )
      
      case( TaskStatus.Suspended )
        _suspendedTasks->addLast( *aTask )
    end select
    
    this.unlock()
  end sub
  
  /'
    Detach currently completed task from the calling worker thread
  '/
  sub _
    TaskManager.taskCompleted( _
      byval aThread as WorkerThreadBase ptr )
    
    this.lock()
      var _
        aTask => aThread->detachTask()
      
      _idleThreadsCount +=> 1
      _completedTasksCount +=> 1
    this.unlock()
  end sub
  
  sub _
    TaskManager.suspendTask( _
      byval aThread as WorkerThreadBase ptr )
    
    this.lock()
      var _
        aTask => aThread->detachTask()
      
      _idleThreadsCount +=> 1
      
      _suspendedTasks->addLast( aTask )
    this.unlock()
  end sub
  
  sub _
    TaskManager.abortTask( _
      byval aThread as WorkerThreadBase ptr )
    
    this.lock()
      aThread->detachTask()
      _idleThreadsCount +=> 1
    this.unlock()
  end sub
  
  /'
    The TaskManager main loop.
    
    Note that each TaskManager also gets its own thread, so you
    can have multiple unrelated TaskManagers all performing several
    Tasks in parallel.
  '/
  sub _
    TaskManager.run( _
      byval instance as TaskManager ptr )
    
    do
      instance->lock()
      
      /'
        Traverse the list of worker threads this TaskManager maintains
        and look for an idle thread. If there are any, attach the task
        waiting at the fringe of the queue to it.
      '/
      for _
        i as integer => 0 _
        to instance->_availableThreads - 1
        
        if( instance->_threads( i )->idle ) then
          /'
            If there are pending tasks, fetch the first one in the queue
            and start performing it.
          '/
          if( instance->_pendingTasks->count > 0 ) then
            instance->_idleThreadsCount -=> 1
            instance->_threads( i )->attachTask( _
              instance->_pendingTasks->removeFirstItem() )
            
            continue for
          end if
          
          if( instance->_suspendedTasks->count > 0 ) then
            var _
              node => instance->_suspendedTasks->first
            
            for _
              j as integer => 0 _
              to instance->_suspendedTasks->count - 1
              
              /'
                If the task was resumed, start performing it again
              '/
              if( node->item->status = TaskStatus.Running ) then
                instance->_idleThreadsCount -=> 1
                instance->_threads( i )->resumeTask( _
                  instance->_suspendedTasks->removeItem( node ) )
                
                exit for
              end if
              
              node => node->forward
            next
          end if
        end if
      next
      
      if( not instance->_running ) then
        instance->unlock()
        exit do
      end if
      
      instance->unlock()
      
      sleep( 1, 1 )
    loop
    
    instance->cleanUp()
  end sub
  
  /'
    Cleanup the Task Manager upon exiting the loop. This is
    so the destructor can correctly release all other resources.
  '/
  sub _
    TaskManager.cleanUp()
    
    for _
      i as integer => 0 _
      to _availableThreads - 1
      
      delete( _threads( i ) )
    next
    
    delete( _pendingTasks )
    delete( _suspendedTasks )
  end sub
  
  /'
    The 'Task.attachTo()' method is defined here, after the TaskManager
    class has been defined, since we need to access its methods.
  '/
  sub _
    Task.attachTo( _
      byval aTaskManager as TaskManager ptr )
    
    'aTaskManager->lock()
      aTaskManager->queueTask( @this )
      
      var _
        childTaskNode => _childTasks->first
      
      for _
        i as integer => 0 _
        to _childTasks->count - 1
        
        if( childTaskNode->item->isParentTask ) then
          childTaskNode->item->attachTo( aTaskManager )
        else
          aTaskManager->queueTask( cptr( _
            Task ptr, _
            childTaskNode->item ) )
        end if
        
        childTaskNode => childTaskNode->forward
      next
    'aTaskManager->unlock()
  end sub
end namespace

#endif
