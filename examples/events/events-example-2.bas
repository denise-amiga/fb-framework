#include once "fbfw-events.bi"

/'
  Example 2: External event handlers.
  
  This example shows how you can hook an external handler for a class
  event.
'/

type _
  OperationCompletedEventArgs _
  extends Events.EventArgs
  
  declare constructor( _
    byval as integer )
  declare destructor() override
  
  as integer _
    someData
end type

constructor _
  OperationCompletedEventArgs( _
    byval aSomeData as integer )
  
  someData => aSomeData
end constructor

destructor _
  OperationCompletedEventArgs()
end destructor

type _
  SomethingHappenedEventArgs _
  extends Events.EventArgs
  
  declare constructor( _
    byref as string )
  declare destructor() override
  
  as string _
    message
end type

constructor _
  SomethingHappenedEventArgs( _
    byref aMessage as string )
  
  message => aMessage
end constructor

destructor _
  SomethingHappenedEventArgs()
end destructor

type _
  Object1 _
  extends Events.WithEvents
  
  public:
    declare constructor( _
      byref as const string )
    declare destructor() override
    
    declare property _
      OperationCompleted() _
      byref as const Events.Event
    declare property _
      SomethingHappened() _
      byref as const Events.Event
    
    declare property _
      name() as string
    
    declare sub _
      operation1()
    declare sub _
      operation2()
    
  private:
    declare constructor()
    
    /'
      Events are ALWAYS static, like this
    '/
    static as Events.Event _
      _EvOperationCompleted
    static as Events.Event _
      _EvSomethingHappened
    
    as string _
      _name
    
    as integer _
      _someInternalState => -4
end type

dim as Events.Event _
  Object1._EvOperationCompleted => _
    Events.Event()
dim as Events.Event _
  Object1._EvSomethingHappened => _
    Events.Event( "SomethingHappened" )
  
constructor _
  Object1()
end constructor

constructor _
  Object1( _
    byref aName as const string )
  
  register( _EvOperationCompleted )
  register( _EvSomethingHappened )
  
  _name => aName
end constructor

destructor _
  Object1()
end destructor

property _
  Object1.OperationCompleted() _
  byref as const Events.Event
  
  return( _
    _EvOperationCompleted.forInstance( @this ) )
end property

property _
  Object1.SomethingHappened() _
  byref as const Events.Event
  
  return( _
    _EvSomethingHappened.forInstance( @this ) )
end property

property _
  Object1.name() _
  as string
  
  return( _name )
end property

sub _
  Object1.operation1()
  
  ? "Performing " & _name & "::operation1"
  
  raiseEvent( _
    OperationCompleted, _
    OperationCompletedEventArgs( _someInternalState ) )
end sub

sub _
  Object1.operation2()
  
  ? "Performing " & _name & "::operation2"
  
  raiseEvent( _
    SomethingHappened, _
    SomethingHappenedEventArgs( "An error occurred." ) )
end sub

type _
  Object2 _
  extends Events.WithEvents
  
  public:
    declare constructor( _
      byref as Object1 )
    declare destructor() override
  
  private:
    declare constructor()
    
    declare static sub _
      object1_OperationCompleted( _
        byref as Object, _
        byref as OperationCompletedEventArgs )
    declare static sub _
      object1_SomethingHappened( _
        byref as Object, _
        byref as SomethingHappenedEventArgs )
      
    declare sub _
      reportOperation( _
        byref as const string, _
        byval as integer )
    declare sub _
      reportSomethingHappened( _
        byref as const string, _
        byref as const string )
end type

constructor _
  Object2()
end constructor

constructor _
  Object2( _
    byref aSubject as Object1 )
  
  addHandler( _
    aSubject.OperationCompleted, _
    asHandler( object1_operationCompleted ) )
  
  addHandler( _
    aSubject.SomethingHappened, _
    asHandler( object1_somethingHappened ) )
end constructor

destructor _
  Object2()
end destructor

sub _
  Object2.object1_operationCompleted( _
    byref sender as Object, _
    byref e as OperationCompletedEventArgs )
  
  var _
    instance => cptr( Object2 ptr, e.Me )
  
  instance->reportOperation( _
    cptr( Object1 ptr, @sender )->name, _
    e.someData )
end sub

sub _
  Object2.object1_somethingHappened( _
    byref sender as Object, _
    byref e as SomethingHappenedEventArgs )
  
  var _
    instance => cptr( Object2 ptr, e.Me )
  
  instance->reportSomethingHappened( _
    cptr( Object1 ptr, @sender )->name, _
    e.message )
end sub

sub _
  Object2.reportOperation( _
    byref aName as const string, _
    byval aState as integer )
  
  ? "Operation has been completed on " & aName & _
    ". State received: " & aState
end sub

sub _
  Object2.reportSomethingHappened( _
    byref aName as const string, _
    byref aMessage as const string )
  
  ? "Something happened on " & aName & _
    ". Message: " & aMessage
end sub

/'
  This is an external handler.
  
  An important thing to notice from these handlers is that, unlike member
  handlers, you get NO CONTEXT other than that of the event itself. If you
  need more context, then you'll either forward the event data to the
  appropriate function, or implement another mechanism (such as direct
  callbacks). 
'/
sub _
  object_operationCompleted( _
    byref sender as Object, _
    byref e as OperationCompletedEventArgs )
  
  ? "External event handler: operation completed on: " & _
    cptr( Object1 ptr, @sender )->name 
end sub

scope
  /'
    Example code
  '/
  var _
    anObject => Object1( "AnObject" ), _
    anotherObject => Object1( "AnotherObject" )
  
  var _
    anObserver => Object2( anObject )
  
  /'
    And this is how we can add an external (from outside the class) event
    handler.
  '/
  anObject.addHandler( _
    anObject.OperationCompleted, _
    asHandler( object_operationCompleted ) )
  
  /'
    Perform both operations on both instances of 'Object1', so they raise
    their events.
  '/
  anObject.operation1()
  ?
  anotherObject.operation1()
  
  ?
  anObject.operation2()
  ?
  anotherObject.operation2()
end scope

sleep()
