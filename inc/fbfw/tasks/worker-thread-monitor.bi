#ifndef __FBFW_TASKS_WORKERTHREAD_MONITOR__
#define __FBFW_TASKS_WORKERTHREAD_MONITOR__

namespace Tasks
  /'
    Memento class to store the internal status of a WorkerThread.
    Note that this isn't a 'traditional' Memento, since it stores
    pointers to the internal variables of the WorkerThread class.
    
    It's implementation resembles that of the Memento pattern, but it's
    not quite like it since its primary purpose is not to take a snapshot
    of the internal state but monitor it and extract several useful
    statistics that can be used, for example, for profiling. Also, other
    statistical data can be produced, collected and calculated using the
    raw data that the Monitor encapsulates.
    
    So, 'Monitor' is a more appropriate name than 'Memento'.
    
    ATTENTION: Note that Monitors contains pointers to internal object
      state, so if the object is to be deleted, the Monitor would then be
      full of invalid pointers. ALWAYS tie the lifetime of Monitors to that
      of the object they are monitoring.
  '/
  type _
    WorkerThreadMonitor _
    
    public:
      declare constructor( _
        byref as const string, _
        byval as double ptr, _
        byval as double ptr, _
        byval as integer ptr )
      declare destructor()
    
    declare property _
      threadID() as string
    declare property _
      idleTime() as double
    declare property _
      workTime() as double
    declare property _
      completedTasks() as integer
    
    private:
      declare constructor()
      
      as string _
        _threadID
      as double ptr _
        _idleTime, _
        _workTime
      as integer ptr _
        _completedTasks
  end type
  
  implement_auto_ptr( of( __WorkerThreadMonitor ) )
  
  constructor _
    WorkerThreadMonitor()
  end constructor
  
  constructor _
    WorkerThreadMonitor( _
      byref aThreadID as const string, _
      byval aTotalWorkTime as double ptr, _
      byval aTotalIdleTime as double ptr, _
      byval aCompletedTasks as integer ptr )
    
    _threadID => aThreadID
    _workTime => aTotalWorkTime
    _idleTime => aTotalIdleTime
    _completedTasks => aCompletedTasks
  end constructor
  
  destructor _
    WorkerThreadMonitor()
  end destructor
  
  property _
    WorkerThreadMonitor.threadID() _
    as string
    
    return( _threadID )
  end property
  
  property _
    WorkerThreadMonitor.idleTime() _
    as double
    
    return( *_idleTime )
  end property
  
  property _
    WorkerThreadMonitor.workTime() _
    as double
    
    return( *_workTime )
  end property
  
  property _
    WorkerThreadMonitor.completedTasks() _
    as integer
    
    return( *_completedTasks )
  end property
end namespace

#endif
