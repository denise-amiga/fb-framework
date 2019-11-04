#include once "events.bi"

type _
  BaseClass _
  extends Events.WithEvents
  
  public:
    declare virtual destructor() override
    
    declare property _
      OperationCompleted() _
      byref as const Events.Event
    
    declare property _
      id() as string
    
    declare abstract sub _
      operation()
    
  protected:
    declare constructor()
    declare constructor( _
      byref as const string )
    
  private:
    static as Events.Event _
      _EvOperationCompleted
    
    as string _
      _id
end type

dim as Events.Event _
  BaseClass._EvOperationCompleted => _
    Events.Event( "Base:OperationCompleted" )

constructor _
  BaseClass()
end constructor

constructor _
  BaseClass( _
    byref anId as const string )
  
  register( _EvOperationCompleted )
  
  _id => anId
end constructor

destructor _
  BaseClass()
end destructor

property _
  BaseClass.OperationCompleted() _
  byref as const Events.Event
  
  return( _EvOperationCompleted )
end property

property _
  BaseClass.id() _
  as string
  
  return( _id )
end property

type _
  DerivedClass1 _
  extends BaseClass
  
  public:
    declare constructor()
    declare virtual destructor() override
    
    declare property _
      OperationCompleted() _
      byref as const Events.Event
    
    declare sub _
      operation() override
    
  private:
    static as Events.Event _
      _EvOperationCompleted
end type

dim as Events.Event _
  DerivedClass1._EvOperationCompleted => _
    Events.Event( "Derived1:OperationCompleted" )

constructor _
  DerivedClass1()
  
  base( "DerivedClass1" )
  
  register( _EvOperationCompleted )
end constructor

destructor _
  DerivedClass1()
end destructor

property _
  DerivedClass1.OperationCompleted() _
  byref as const Events.Event
  
  return( _EvOperationCompleted )
end property

sub _
  DerivedClass1.operation()
  
  ? "Raising event from DerivedClass1..."
  raiseEvent( _
    OperationCompleted, _
    Events.EventArgs() )
end sub

type _
  DerivedClass2 _
  extends BaseClass
  
  public:
    declare constructor()
    declare virtual destructor() override
    
    declare sub _
      operation() override
end type

constructor _
  DerivedClass2()
  
  base( "DerivedClass2" )
end constructor

destructor _
  DerivedClass2()
end destructor

sub _
  DerivedClass2.operation()
  
  ? "Raising event from DerivedClass2..."
  raiseEvent( _
    OperationCompleted, _
    Events.EventArgs() )
end sub

sub _
  BaseClass_OperationCompleted( _
    byref sender as BaseClass, _
    byref e as Events.EventArgs )
  
  ? "Operation completed. Sender: " & sender.id
end sub

var _
  d1 => DerivedClass1(), _
  d2 => DerivedClass2()

d1.addHandler( _
  d1.OperationCompleted, _
  asHandler( BaseClass_OperationCompleted ) )
d2.addHandler( _
  d2.OperationCompleted, _
  asHandler( BaseClass_OperationCompleted ) )

? "DerivedClass1:operation()"
d1.operation()

?
? "DerivedClass2:operation()"
d2.operation()

sleep()
