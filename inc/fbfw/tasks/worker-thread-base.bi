#ifndef __FBFW_TASKS_WORKERTHREAD_BASE__
#define __FBFW_TASKS_WORKERTHREAD_BASE__

namespace Tasks
  type as WorkerThreadMonitor _
    __WorkerThreadMonitor
  
  declare_auto_ptr( of( __WorkerThreadMonitor ) )
  
  /'
    Base class for a Worker Thread.
    
    Worker threads are pretty much like normal threads, but they are under
    the management of a Task Manager. The Task Manager will assign Tasks
    to them according to its workload and availability.
  '/
  type _
    WorkerThreadBase _
    extends Object
    
    public:
      declare virtual destructor()
      
      declare property _
        id() as string
      declare property _
        isRunning() as boolean
      declare property _
        idle() as boolean
      
      declare sub _
        lock()
      declare sub _
        unlock()
      
      declare abstract sub _
        start()
      declare abstract sub _
        stop()
      declare abstract sub _
        attachTask( _
          byval as ITask ptr )
      declare abstract sub _
        resumeTask( _
          byval as ITask ptr )
      declare abstract function _
        detachTask() as ITask ptr
      declare abstract function _
        getMonitor() as __WorkerThreadMonitor ptr
      
    protected:
      declare constructor()
      declare constructor( _
        byref as const string )
      
      as string _
        _id
      as any ptr _
        _mutex, _
        _idleCond
      as boolean _
        _idle, _
        _busy, _
        _running
  end type
  
  constructor _
    WorkerThreadBase()
  end constructor
  
  constructor _
    WorkerThreadBase( _
      byref anID as const string )
    
    _id => anID
  end constructor
  
  destructor _
    WorkerThreadBase()
  end destructor
  
  property _
    WorkerThreadBase.id() _
    as string
    
    return( _id )
  end property
  
  property _
    WorkerThreadBase.isRunning() _
    as boolean
    
    return( _running )
  end property
  
  property _
    WorkerThreadBase.idle() _
    as boolean
    
    return( _idle )
  end property
  
  sub _
    WorkerThreadBase.lock()
    
    mutexLock( _mutex )
  end sub
  
  sub _
    WorkerThreadBase.unlock()
    
    mutexUnlock( _mutex )
  end sub
end namespace

#endif
