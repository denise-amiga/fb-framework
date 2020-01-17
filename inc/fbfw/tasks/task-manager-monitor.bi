#ifndef __FBFW_TASKS_TASKMANAGER_MONITOR__
#define __FBFW_TASKS_TASKMANAGER_MONITOR__

namespace Tasks
  /'
    Monitor class for a Task Manager.
    
    This is implemented similar to a Memento, that is, a class that
    represents a snapshot of the internal state of an object. This allows
    the client code that needs it to monitor the internal state of another
    class without breaking encapsulation.
    
    Note that this class is used by the TaskManager class, who fills it
    with the appropriate internal data. The class is useless by itself,
    but there are no other good choices to implement Mementos in FreeBasic
    (since it doesn't support neither private classes nor 'friend:' access
    control).
    
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
    TaskManagerMonitor
    
    public:
      declare constructor( _
        byval as WorkerThreadBase ptr ptr, _
        byval as double ptr, _
        byval as integer ptr, _
        byval as integer ptr, _
        byval as integer ptr )
      declare destructor()
      
      declare property _
        startTime() as double
      declare property _
        runningTime() as double
      declare property _
        completedTasks() as integer
      declare property _
        availableThreads() as integer
      declare property _
        idleThreads() as integer
      declare property _
        thread( _
          byval as integer ) _
        as __WorkerThreadMonitor ptr
      
    private:
      declare constructor()
      
      as __WorkerThreadMonitor ptr _
        _threadMonitor( any )
      as double ptr _
        _startTime
      as integer ptr _
        _completedTasks, _
        _availableThreads, _
        _idleThreads
  end type
  
  constructor _
    TaskManagerMonitor()
  end constructor
  
  constructor _
    TaskManagerMonitor( _
      byval aWorkerThreads as WorkerThreadBase ptr ptr, _
      byval aStartTime as double ptr, _
      byval aCompletedTasks as integer ptr, _
      byval anAvailableThreads as integer ptr, _
      byval anIdleThreads as integer ptr )
    
    _startTime => aStartTime
    _completedTasks => aCompletedTasks
    _availableThreads => anAvailableThreads
    _idleThreads => anIdleThreads
    
    redim _
      _threadMonitor( 0 to *_availableThreads - 1 )
    
    for _
      i as integer => 0 _
      to *_availableThreads - 1
      
      _threadMonitor( i ) => aWorkerThreads[ i ]->getMonitor()
    next
  end constructor
  
  destructor _
    TaskManagerMonitor()
    
    for _
      i as integer => 0 _
      to *_availableThreads - 1
      
      delete( _threadMonitor( i ) )
    next
  end destructor
  
  property _
    TaskManagerMonitor.startTime() _
    as double
    
    return( *_startTime )
  end property
  
  property _
    TaskManagerMonitor.runningTime() _
    as double
    
    dim as long _
      hours => dateDiff( "h", *_startTime, now() ), _
      minutes => dateDiff( "m", *_startTime, now() ), _
      seconds => dateDiff( "s", *_startTime, now() )
    
    return( timeSerial( hours, minutes, seconds ) )
  end property
  
  property _
    TaskManagerMonitor.completedTasks() _
    as integer
    
    return( *_completedTasks )
  end property
  
  property _
    TaskManagerMonitor.idleThreads() _
    as integer
    
    return( *_idleThreads )
  end property
  
  property _
    TaskManagerMonitor.availableThreads() _
    as integer
    
    return( *_availableThreads )
  end property
  
  property _
    TaskManagerMonitor.thread( _
      byval index as integer ) _
    as __WorkerThreadMonitor ptr
    
    return( _threadMonitor( index ) )
  end property
end namespace

#endif