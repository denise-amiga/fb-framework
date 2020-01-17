#include once "fbfw-debug.bi"
#include once "fbfw-tasks.bi"

using Debug

#include once "bi/task-manager-test-utils.bi"
#include once "bi/concurrent-task.bi"

/'
  Just an event to inform us when a task was completed
'/
sub _
  Task_TaskCompleted( _
    byref sender as Tasks.Task, _
    byref e as Events.EventArgs )
  
  Console().write( "Event: Task completed: " & sender.id )
end sub

/'
  Main
'/
screenRes( 800, 600 )
width 800 \ 8, 600 \ 14

'' A console instance to log messages
var _
  aConsole => Debug.Console()

scope
  var _
    aTaskManager => Tasks.TaskManager( 10 )
  
  var _
    anInfoCenter => InfoCenter( _
      aTaskManager.getMonitor(), _
      500.0 )
    
  dim as string _
    aKey
  dim as integer _
    iCount
  
  anInfoCenter.start()
  
  do
    anInfoCenter.update()
    
    aKey => inkey()
    
    /'
      Concurrent parent/child tasks test
    '/
    if( aKey = "1" ) then
      dim as Tasks.Task ptr _
        parent, _
        suspended
      
      var _
        task1 => new MyTask( _
          "Parent", 5000.0, @anInfoCenter ), _
        child1 => new MyTask( _
          "Child1", 8000.0, @anInfoCenter ), _
        child2 => new MyTask( _
          "Child2", 8000.0, @anInfoCenter ), _
        child3 => new MyTask( _
          "Child3", 12000.0, @anInfoCenter )
      
      task1 _
        ->attach( child1 ) _
        ->attach( child2->attach( child3 ) )
      
      task1->addHandler( _
        task1->TaskCompleted, _
        asHandler( Task_TaskCompleted ) )
      child3->addHandler( _
        child3->TaskCompleted, _
        asHandler( Task_TaskCompleted ) )
      
      parent => task1
      suspended => child3
      
      parent->attachTo( @aTaskManager )
      
      anInfoCenter.message( _
        "Main thread is waiting for task to complete..." )
      
      dim as double _
        startTime => timer()
      dim as integer _
        iElapsedTime
      
      dim as string _
        keyPress
      
      do while( _
        parent->status <> Tasks.TaskStatus.Completed andAlso _
        parent->status <> Tasks.TaskStatus.Aborted )
        
        dim as double _
          elapsedTime => timer() - startTime
        
        if( int( elapsedTime ) <> iElapsedTime ) then
          iElapsedTime => int( elapsedTime )
          
          anInfoCenter.message( _
            "Elapsed time: " & iElapsedTime )
        end if
        
        anInfoCenter.update()
        
        keyPress => inkey()
        
        if( keyPress = chr( 27 ) ) then
          parent->abort()
        end if
        
        if( lcase( keyPress ) = "s" ) then
          '' Suspend one task
          suspended->suspend()
        end if
        
        if( lcase( keyPress ) = "r" ) then
          '' Resume the suspended task
          suspended->resume()
        end if
        
        sleep( 1, 1 )
      loop
      
      dim as string _
        finalStatus
      
      select case as const( parent->status )
        case( Tasks.TaskStatus.Completed )
          finalStatus => "Completed"
        
        case( Tasks.TaskStatus.Aborted )
          finalStatus => "Aborted"
      end select
      
      anInfoCenter.message( _
        "Main thread finished waiting. Parent task status: " & _
        finalStatus )
      
      delete( parent )
    end if
    
    sleep( 1, 1 )
  loop _
    until( aKey = chr( 27 ) )
end scope

cls()
? "Cleanup finished. Press a key to end..."

sleep()
