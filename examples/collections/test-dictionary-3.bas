#include once "collections.bi"

'' The prototype of the function used as a command
type as sub( _
  byref as const string ) _
  cmd

template( Dictionary, _
  of( string ), of( cmd ) )

sub _
  command1( _
    byref aText as const string )
  
  ? "Executing command 1: " & aText
end sub

sub _
  command2( _
    byref aText as const string )
  
  ? "Executing command 2: " & aText
end sub

/'
  Unit test showing how the collections can also be templated to hold
  function pointers.
'/
scope
  var _
    commands => Dictionary( _
      of( string ), of( cmd ) )()
    
  commands _
    .add( "command1", @command1 ) _
    .add( "command2", @command2 )
  
  /'
    Again, the collection doesn't work with the 'with' statement...
    
    Note that this only happens when we use the block with function
    pointers.
  '/
  'with commands
  '  .add( "command1", @command1 ) _
  '  .add( "command2", @command2 )
  'end with
  
  /'
    To call the function pointer contained within the collection, we need
    to dereference the entire expression, like this.
  '/
  *( commands.find( "command1" ) )( "foo" )
  *( commands.find( "command2" ) )( "bar" )
end scope

sleep()
