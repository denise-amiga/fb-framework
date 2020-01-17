#ifndef __FBFW_TASKS_TASK__
#define __FBFW_TASKS_TASK__

namespace Tasks
  /'
    Base class for a Task.
    
    A Task is pretty much like a Process, but executes in a thread and
    needs synchronization if you want to wait for them to finish. Tasks
    are managed by a TaskManager, which is in charge of assigning pending
    tasks to threads and managing their lifetimes.
  '/
  type _
    Task _
    extends ITask
    
    public:
      declare virtual destructor() override
      
      declare property _
        id() as string
      declare property _
        isParentTask() as boolean override
      
      declare sub _
        attachTo( _
          byval as __TaskManager ptr ) override
        
      declare sub _
        start() override
      declare sub _
        abort() override
      declare sub _
        suspend() override
      declare sub _
        resume() override
      
      declare function _
        attach( _
          byval as ITask ptr ) _
        as Task ptr override
      declare function _
        attach( _
          byref as ITask ) _
        byref as Task override
      
      /'
        ATTENTION: these members are public just because FreeBasic doesn't have
        multilevel protected member access control (no 'Friend' members). These
        aren't meant to be used by client code, the TaskManager that the Task
        belongs to is in charge of calling and manipulating these.
      '/
      declare sub _
        complete__() override
      declare sub _
        resume__() override
      
    protected:
      declare constructor()
      declare constructor( _
        byref as const string )
      
      declare virtual sub _
        onStart()
      declare virtual sub _
        onAbort()
      declare virtual sub _
        onSuspend()
      declare virtual sub _
        onResume()
      declare virtual sub _
        onComplete()
      
    private:
      as LinkedList( of( ITask ) ) ptr _
        _childTasks
      
      as string _
        _id
  end type
  
  constructor _
    Task()
  end constructor
  
  constructor _
    Task( _
      byref anId as const string )
    
    _id => anID
    _openWorkItems => 1
    
    _status => TaskStatus.Halted
    parent => TasksNull
    
    _childTasks => new LinkedList( of( ITask ) )
  end constructor
  
  destructor _
    Task()
    
    delete( _childTasks )
  end destructor
  
  property _
    Task.id() _
    as string
    
    return( _id )
  end property
  
  /'
    Returns whether or not this task is a parent task.
    
    This is vitally important, since you can't simply 'pull the rug'
    from beneath child tasks by deleting their parent without them
    knowing it, because they will reference it when they're completed.
    Thus, to allow for correct disposal of chained tasks, the parent
    needs to be in charge of both notifying its children whenever its
    state changes and dispose of them if appropriate.
  '/
  property _
    Task.isParentTask() _
    as boolean
    
    return( cbool( _childTasks->count > 0 ) )
  end property
  
  sub _
    Task.onStart()
  end sub
  
  sub _
    Task.onAbort()
  end sub
  
  sub _
    Task.onSuspend()
  end sub
  
  sub _
    Task.onResume()
  end sub
  
  sub _
    Task.onComplete()
  end sub
  
  /'
    Attaches a child task to this Task. To check for completion of the
    entire chain of Tasks, all you need to do is check for the
    completion of their parent.
  '/
  function _
    Task.attach( _
      byval aTask as ITask ptr ) _
    as Task ptr
    
    aTask->parent => @this
    
    _openWorkItems +=> aTask->openWorkItems
    
    _childTasks->addLast( aTask )
    
    return( @this )
  end function
  
  function _
    Task.attach( _
      byref aTask as ITask ) _
    byref as Task
    
    aTask.parent => @this
    
    _openWorkItems +=> aTask.openWorkItems
    
    _childTasks->addLast( aTask )
    
    return( this )
  end function
  
  /'
    Signals that this Task is completed. This method is called by the
    TaskManager when the Task exits its 'perform()' method. Note that
    this method is recursive if the task is a child of another. The
    way this mechanism works is as follows:
    
    Each time a task is attached to another (and thus becoming a 'child'
    of that task), a counter is incremented ('openWorkItems'). Then,
    upon completion, the child task calls the 'complete()' method of its
    parent. This effectively substracts one from the open work items of
    that task. If the 'openWorkItems' variable is zero, then that means
    the entire task chain is completed.
    
    You can thus check for the status of any task, regardless of their
    relationships. This also allows to create very complex chains of
    tasks that'll all get executed if the parent of the chain is queued
    into a TaskManager.
  '/
  sub _
    Task.complete__()
    
    /'
      If this Task is a child of another task, signal its parent that the
      task has been completed, too.
    '/
    if( parent <> TasksNull ) then
      parent->complete__()
    end if
    
    /'
      Substract one open work item (a 'unit of work') from the count for
      this task. When it reaches 0, it would mean that all tasks (both
      the parent and its child tasks) are completed and the task as a
      whole is, thus, completed.
    '/
    _openWorkItems -=> 1
    
    if( _openWorkItems <= 0 ) then
      _status => TaskStatus.Completed
      
      onComplete()
    end if
  end sub
  
  sub _
    Task.resume__()
    
    onResume()
  end sub
  
  sub _
    Task.start()
    
    _status => TaskStatus.Running
    
    onStart()
  end sub
  
  sub _
    Task.abort()
    
    if( _status <> TaskStatus.Aborted ) then
      _status => TaskStatus.Aborted
      
      onAbort()
      
      /'
        Inform the child tasks that the parent was aborted, too
      '/
      if( _childTasks->count > 0 ) then
        var _
          node => _childTasks->first
        
        for _
          i as integer => 0 _
          to _childTasks->count - 1
          
          node->item->abort()
          
          node => node->forward
        next
      end if
    end if
  end sub
  
  sub _
    Task.suspend()
    
    if( _status <> TaskStatus.Suspended ) then
      _status => TaskStatus.Suspended
      
      onSuspend()
    end if
  end sub
  
  sub _
    Task.resume()
    
    if( _status <> TaskStatus.Running ) then
      _status => TaskStatus.Running
    end if
  end sub
end namespace

#endif
