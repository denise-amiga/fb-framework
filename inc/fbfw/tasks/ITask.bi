#ifndef __FBFW_TASKS_ITASK__
#define __FBFW_TASKS_ITASK__

namespace Tasks
  /'
    Forward define the WorkerThread class. Tasks will need to interact
    with the thread that's currently executing them (ie to receive
    notifications).
  '/
  type as WorkerThread _
    __WorkerThread
  
  /'
    This enum describes in which status each Task is on:
    
    Aborted: the task has been aborted.
    Completed: the task is completed.
    Halted: the task has been created but is still not executed.
    Running: the task is running. It will keep running until the task
      ends or is aborted.
    Suspended: the task is running but it is now suspended.
  '/
  enum TaskStatus
    Aborted
    Completed
    Halted
    Running
    Suspended
  end enum
  
  type as TaskManager _
    __TaskManager
  
  /'
    Abstract base class for Tasks
  '/
  type _
    ITask _
    extends Events.WithEvents
    
    public:
      declare virtual destructor() override
      
      declare property _
        status() as TaskStatus
      declare property _
        openWorkItems() as integer
      
      declare abstract property _
        isParentTask() as boolean
      
      declare abstract function _
        finished() as boolean
      declare abstract sub _
        start()
      declare abstract sub _
        abort()
      declare abstract sub _
        suspend()
      declare abstract sub _
        resume()
      
      declare abstract function _
        attach( _
          byval as ITask ptr ) _
        as ITask ptr
      declare abstract function _
        attach( _
          byref as ITask ) _
        byref as ITask
      
      declare abstract sub _
        perform()
      declare abstract sub _
        attachTo( _
          byval as __TaskManager ptr )
        
      declare abstract sub _
        complete__()
      declare abstract sub _
        resume__()
      
      /'
        This public member is not meant to be manipulated directly (the
        TaskManager abstraction is in charge of that). Needs to be public
        since FreeBasic doesn't support C++ like 'Friend' access control
        yet.
      '/
      as __WorkerThread ptr _
        thread__
      
    protected:
      as ITask ptr _
        parent
      as integer _
        _openWorkItems
      as TaskStatus _
        _status
  end type
  
  destructor _
    ITask() export
  end destructor
  
  property _
    ITask.status() _
    as TaskStatus
    
    return( _status )
  end property
  
  property _
    ITask.openWorkItems() _
    as integer
    
    return( _openWorkItems )
  end property
  
  template( LinkedList, of( ITask ) )
end namespace

#endif
