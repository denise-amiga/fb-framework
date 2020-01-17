#include once "fbfw-collections.bi"

/'
  A more advanced example of List usage: disposing callbacks.
  
  Note that this an advanced option for Lists that isn't implemented
  on other collections yet, and you won't normally need it (you can
  simply add the element to the collection by reference).
'/
type as Something ptr _
  Something_ptr

type _
  Something
  
  public:
    declare constructor()
    declare constructor( _
      byval as integer )
    declare destructor()
    
    declare operator _
      cast() as string
    
    as integer _
      foo
end type

constructor _
  Something()
end constructor

constructor _
  Something( _
    byval aFoo as integer )
  
  foo => aFoo
end constructor

destructor _
  Something()
  
  ? "Something was destroyed."
end destructor

operator _
  Something.cast() _
  as string
  
  return( "Something.foo is: " & foo )
end operator

template( List, of( Something_ptr ) )

sub _
  dispose( _
    byval item as Something_ptr ptr )
  
  delete( *item )
end sub

/'
  Will need to add support for disposing callbacks for this particular
  use case, since elements within the list won't get destroyed properly.
'/
scope
  var _
    aList => List( of( Something_ptr ) ) _
      ( @dispose )
    
  var _
    aSomething => new Something( 4 )
  
  aList.add( @aSomething )
  
  ? ( *aList.at( 0 ) )->foo
  
  '' Or arternatively:
  '? **aList.at( 0 ).foo
end scope

? "Finished."

sleep()
