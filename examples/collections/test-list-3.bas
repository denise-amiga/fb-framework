#include once "collections.bi"

/'
  A simple use case showing how I may implement initializers for
  collections. Note that only Lists support it for now (and that
  I may decide to opt out of it completely).
'/
template( List, of( integer ) )

var _
  l => List( of( integer ) )()

l.add( new integer, 5 )
l.add( new integer, 9 )
l.add( new integer, 12 )
l.add( new integer, 15 )

for _
  i as integer => 0 _
  to l.count - 1
  
  ? *l.at( i )
next

sleep()
