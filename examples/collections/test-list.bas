#include once "collections.bi"

/'
  Classic interface for the Command pattern
'/
type _
  ICommand _
  extends Object
  
  declare virtual destructor()
  
  declare abstract sub _
    execute()
end type

destructor _
  ICommand()
end destructor

operator _
  =( _
    byref lhs as ICommand, _
    byref rhs as ICommand ) _
  as integer
  
  return( @lhs = @rhs )
end operator

/'
  Derives a Command that 'activates' a sensor
'/
type _
  ActivateSensor _
  extends ICommand
  
  declare constructor()
  declare destructor() override
  
  declare sub _
    execute() override
end type

constructor _
  ActivateSensor()
end constructor

destructor _
  ActivateSensor()
end destructor

sub _
  ActivateSensor.execute()
  
  ? "Sensor activated"
end sub

/'
  Derives a Command that 'engages' a clutch
'/
type _
  EngageClutch _
  extends ICommand
  
  declare constructor()
  declare destructor() override
  
  declare sub _
    execute() override
end type

constructor _
  EngageClutch()
end constructor

destructor _
  EngageClutch()
end destructor

sub _
  EngageClutch.execute()
  
  ? "Engaging clutch"
end sub

/'
  List unit test
'/
template( List, of( ICommand ) )

/'
  Note that the derived Action does indeed work transparently with
  interfaces too.
'/
type _
  Execute _
  extends Action( of( ICommand ) )
  
  declare constructor()
  declare destructor() override
  
  declare sub _
    invoke( byval as ICommand ptr ) override
end type

constructor _
  Execute()
end constructor

destructor _
  Execute()
end destructor

sub _
  Execute.invoke( _
    byval aCommand as ICommand ptr )
  
  aCommand->execute()
end sub

/'
  This simple test case shows how the templated collections also work with
  interfaces. Here, we instantiate a List of ICommands and add two derived
  classes to it (ActivateSensor and EngageClutch). Then, we use an Action
  to execute each one in turn using the forEach() method of the List.
'/
scope
  var _
    commands => List( of( ICommand ) )()
  
  commands _
    .add( new ActivateSensor() ) _
    .add( new EngageClutch() ) _
    .forEach( Execute() )
end scope

sleep()
