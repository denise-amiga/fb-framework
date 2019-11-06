#include once "collections.bi"
#include once "bi/person-type.bi"

/'
  Usage example for Arrays
'/
template( Array, of( Person ) )

/'
  Some example predicates and actions
'/
#include once "bi/person-predicates.bi"
#include once "bi/person-actions.bi"

sub _
  showArray( _
    byref anArray as Array( of( Person ) ) )
  
  for _
    i as integer => 0 _
    to anArray.count - 1
    
    ? anArray.at( i )
  next
end sub

var _
  anArray => Array( of( Person ) )()

with anArray
  .add( Person( "Paul", 37 ) )
  .add( Person( "Jenny", 12 ) )
  .add( Person( "Shaiel", 10 ) )
  .add( Person( "Brisa", 23 ) )
  .add( Person( "Mabel", 40 ) )
end with

var _
  another => anArray.forEach( _
    PersonsBelowAge( 13 ), _
    SetAgeTo( 1 ) )
  
? "Showing elements: "

for _
  item as integer => 0 _
  to another.count - 1
  
  ? another.at( item )
next

?

for _
  item as integer => 0 _
  to anArray.count - 1
  
  ? anArray.at( item )
next

? "Clearing..."
anArray.clear()
? "Done."

? "Element count: "; anArray.count

for _
  item as integer => 0 _
  to anArray.count - 1
  
  ? anArray.at( item )
next

?
? "Showing result array: "
showArray( another )

sleep()
