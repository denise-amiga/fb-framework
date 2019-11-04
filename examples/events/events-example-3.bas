#include once "events.bi"

/'
  Example 1: Basic event handling.
  
  This example shows how you can use events to establish communication between
  two classes. Events are like an abstract function call: the sender of the
  event doesn't know how many listeners there are for its events, it just
  raises it and all listeners that subscribed for handling the event will
  receive the notification.
  
  Events are akin to 'Messages' (see <link to message-based programming>) but
  they require no polling and no further discrimination of neither which class
  sent the event nor which event it is being notified.
'/

/'
  These two classes represent the arguments forwarded to the event
  handlers upon raising of an event. Note that both derive from
  'EventArgs', as there is some internal data that also needs to
  be forwarded with the event. Concretely, there is a pointer to
  the class that will handle the event, to be able to reference
  its members (event handlers are static so you don't get the
  'this' parameter passed to them).
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

/'
  Here we describe an object that will perform two operations that
  raise events. Both events are exposed to the client code through
  const properties.
'/
type _
  Object1 _
  extends Events.WithEvents
  
  public:
    declare constructor()
    declare destructor() override
    
    declare property _
      OperationCompleted() _
      byref as const Events.Event
    declare property _
      SomethingHappened() _
      byref as const Events.Event
    
    declare sub _
      operation1()
    declare sub _
      operation2()
    
  private:
    /'
      Events are ALWAYS static, like this
    '/
    static as Events.Event _
      _EvOperationCompleted
    static as Events.Event _
      _EvSomethingHappened
    
    /'
      And this is some internal state of the object, that will be
      exposed to listeners of the 'OperationCompleted' event.
    '/
    as integer _
      _someInternalState => -4
end type

/'
  Events are declared like this (they are static vars).
  
  Note that you can also name them if you like. This can help in debugging
  and implementing other schemes. Names are not really needed (events are
  discriminated by their internal ids).
'/
dim as Events.Event _
  Object1._EvOperationCompleted => _
    Events.Event()
dim as Events.Event _
  Object1._EvSomethingHappened => _
    Events.Event( "SomethingHappened" )
  
constructor _
  Object1()
  
  /'
    Registering the events will assign them a unique id, which other classes
    use to hook event handlers to them.
    
    Event registration will happen just once, the very first time a class of
    this type is instantiated.
  '/
  register( _EvOperationCompleted )
  register( _EvSomethingHappened )
end constructor

destructor _
  Object1()
end destructor

/'
  And this is how you can expose events to the client code through
  readonly properties.
'/
property _
  Object1.OperationCompleted() _
  byref as const Events.Event
  
  return( _EvOperationCompleted )
end property

property _
  Object1.SomethingHappened() _
  byref as const Events.Event
  
  return( _EvSomethingHappened )
end property

/'
  The two operations the 'Object1' class implement will raise different
  events, and pass them different event arguments.
'/
sub _
  Object1.operation1()
  
  ? "Performing Object1.operation1"
  raiseEvent( _
    OperationCompleted, _
    OperationCompletedEventArgs( _someInternalState ) )
end sub

sub _
  Object1.operation2()
  
  ? "Performing Object1.operation2"
  raiseEvent( _
    SomethingHappened, _
    SomethingHappenedEventArgs( "An error occurred." ) )
end sub

/'
  And now this class defines another object that will listen to events
  raised from another class.
  
  Note that the class' public interface is completely devoid of any members,
  and that the class does not need to store a reference to the observed class.
  All it really needs to do is adding handlers to its events.
'/
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
        byval as integer )
    declare sub _
      reportSomethingHappened( _
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
    asHandler( object1_operationCompleted ), _
    @this )
  
  addHandler( _
    aSubject.SomethingHappened, _
    asHandler( object1_somethingHappened ), _
    @this )
end constructor

destructor _
  Object2()
end destructor

sub _
  Object2.object1_operationCompleted( _
    byref sender as Object, _
    byref e as OperationCompletedEventArgs )
  
  cptr( Object2 ptr, e.Me ) _
    ->reportOperation( e.someData )
end sub

sub _
  Object2.object1_somethingHappened( _
    byref sender as Object, _
    byref e as SomethingHappenedEventArgs )
  
  cptr( Object2 ptr, e.Me ) _
    ->reportSomethingHappened( e.message )
end sub

sub _
  Object2.reportOperation( _
    byval aState as integer )
  
  ? "Operation has been completed. State received: " & aState
end sub

sub _
  Object2.reportSomethingHappened( _
    byref aMessage as const string )
  
  ? "Something happened. Message: " & aMessage
end sub

/'
  Test code
'/
var _
  anObject => Object1(), _
  anObserver => Object2( anObject )

anObject.operation1()

?
anObject.operation2()

sleep()
