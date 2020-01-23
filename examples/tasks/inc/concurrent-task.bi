/'
  This is a basic example usage of a concurrent task.
  
  Concurrent tasks are executed at the same time along with their
  children (if thread availability permits), and are considered
  completed only if the parent and all its child tasks are.
'/
type _
  MyTask _
  extends Tasks.Task
  
  public:
    declare constructor( _
      byref as const string, _
      byval as double, _
      byval as InfoCenter ptr )
    declare destructor() override
    
    declare property _
      TaskCompleted() _
      byref as const Events.Event
    
    declare sub _
      perform() override
    declare function _
      finished() as boolean override
    
  protected:
    declare sub _
      onStart() override
    declare sub _
      onAbort() override
    declare sub _
      onComplete() override
    declare sub _
      onSuspend() override
    declare sub _
      onResume() override
    
  private:
    static as Events.Event _
      _EvTaskCompleted
    
    declare constructor()
    
    as double _
      _startTime, _
      _elapsedTime, _
      _prevElapsed, _
      _duration
    as InfoCenter ptr _
      _infoCenter
end type

dim as Events.Event _
  MyTask._EvTaskCompleted => _
    Events.Event( "TaskCompleted" )

constructor _
  MyTask()
end constructor

constructor _
  MyTask( _
    byref anId as const string, _
    byval aDuration as double, _
    byval anInfoCenter as InfoCenter ptr )
  
  base( anId )
  
  register( _EvTaskCompleted )
  
  _duration => aDuration
  _infoCenter => anInfoCenter
end constructor

destructor _
  MyTask()
  
  Console().write( id & " task destroyed" )
end destructor

property _
  MyTask.TaskCompleted() _
  byref as const Events.Event
  
  return( _EvTaskCompleted.forInstance( @this ) )
end property

/'
  The 'finished()' method has to return whether or not the task can be
  considered finished. It will be queried by the worker thread that is
  performing the task.
  
  Here, the task is finished when the designated number of milliseconds
  have passed.
'/
function _
  MyTask.finished() _
  as boolean
  
  dim as boolean _
    isFinished => _
      cbool( ( ( _elapsedTime + _prevElapsed ) * 1000.0 ) >= _duration )
  
  if( isFinished ) then
    _infoCenter->message( _
      id & " task finished." )
  end if
  
  return( isFinished )
end function

/'
  The 'perform()' method will be invoked continuously by the worker thread
  that is executing the task. This scheme allows us to implement both tasks
  that are executed in small chunks, and 'hogging' tasks that are executed
  all at once.
  
  This is an example of the first type of task: the only thing it has to do
  is computing the elapsed time since the start of the task, and then it
  returns.
'/
sub _
  MyTask.perform()
  
  _elapsedTime => timer() - _startTime
end sub

/'
  The 'onStart' method will be invoked as soon as the task is attached to
  a worker thread and start being performed.
  
  It is the initialization method for the task: here, we cache when the
  task started.
'/
sub _
  MyTask.onStart()
  
  _infoCenter->message( _
    "Performing " & id & " task..." )
  
  _startTime => timer()
end sub

sub _
  MyTask.onAbort()
  
  _infoCenter->message( _
    "Task " & id & " has been aborted." )
end sub

/'
  The 'onSuspend()' method is to be called from client code: whenever
  you 'suspend()' a task, this method gets executed and the task is
  put on another queue, waiting for you to 'resume()' it.
  
  In this case, we cache the elapsed time so far. It will be used when
  the task is resumed to continue the time counting. 
'/
sub _
  MyTask.onSuspend()
  
  _prevElapsed => _elapsedTime
  
  _infoCenter->message( _
    id & " task was suspended. Elapsed time: " & _
    _prevElapsed * 1000.0 )
end sub

/'
  The 'onResume()' method is the method the client code calls whenever it
  wants the task to be resumed. The task will be pulled out of the suspended
  queue and placed back into the running tasks queue.
'/
sub _
  MyTask.onResume()
  
  _startTime => timer()
  _elapsedTime => timer() - _startTime
  
  _infoCenter->message( _
    id & " task resumed execution. Elapsed time: " & _
    ( _elapsedTime + _prevElapsed ) * 1000.0 )
end sub

/'
  The 'onComplete()' method will be called by the worker thread when
  the task finished performing.
'/
sub _
  MyTask.onComplete()
  
  '' Signal that the task is completed by raising an event
  raiseEvent( _
    TaskCompleted, _
    Events.EventArgs() )
end sub
