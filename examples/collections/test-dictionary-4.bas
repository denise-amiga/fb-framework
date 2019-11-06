#include once "collections.bi"
#include once "bi/person-type.bi"

/'
  Slightly more complex example showing how you can compose each collection
  with others to create complex data structures. In this case, a dictionary
  of linked lists of Person types is created, and the dictionary itself is
  keyed by a two dimensional point.
'/

/'
  A simple type to use as key on the dictionary. This one
  represents a point in 2-space.
'/
type _
  Point2
  
  public:
    declare constructor()
    declare constructor( _
      byval as integer, _
      byval as integer )
    declare constructor( _
      byref as Point2 )
    declare destructor()
    
    declare operator _
      let( _
        byref as Point2 )
      
    as integer _
      X, Y
end type

constructor _
  Point2()
end constructor

constructor _
  Point2( _
    byval aX as integer, _
    byval aY as integer )
  
  X => aX
  Y => aY
end constructor

constructor _
  Point2( _
    byref rhs as Point2 )
  
  X => rhs.X
  Y => rhs.Y
end constructor

destructor _
  Point2()
end destructor

operator _
  Point2.let( _
    byref rhs as Point2 )
  
  X => rhs.X
  Y => rhs.Y
end operator

/'
  Types and classes that are to be used as keys MUST implement the
  equality operator.
'/
operator _
  =( _
    byref lhs as Point2, _
    byref rhs as Point2 ) _
  as integer
  
  return( _
    lhs.X = rhs.X andAlso _
    lhs.Y = rhs.Y )
end operator

/'
  We can now define the key for Point2
'/
type _
  Key( of( Point2 ) )
  
  public:
    declare constructor()
    declare constructor( _
      byref as const Point2 )
    declare constructor( _
      byref as Key( of( Point2 ) ) )
    declare destructor()
    
    declare operator _
      let( _
        byref as Point2 )
    declare operator _
      let( _
        byref as Key( of( Point2 ) ) )
      
    declare function _
      getHashCode() as ulong
    
    as Point2 _
      value
end type

constructor _
  Key( of( Point2 ) )()
end constructor

constructor _
  Key( of( Point2 ) )( _
    byref aPoint2 as const Point2 )
  
  value => aPoint2
end constructor

constructor _
  Key( of( Point2 ) )( _
    byref rhs as Key( of( Point2 ) ) )
  
  value => rhs.value
end constructor

destructor _
  Key( of( Point2 ) )()
end destructor

operator _
  Key( of( Point2 ) ).let( _
    byref rhs as Point2 )
  
  value => rhs
end operator

operator _
  Key( of( Point2 ) ).let( _
    byref rhs as Key( of( Point2 ) ) )
  
  value => rhs.value
end operator

/'
  Note that keys MUST implement BOTH the getHashCode() function AND the
  equality operator to work as such.
'/
function _
  Key( of( Point2 ) ).getHashCode() _
  as ulong
  
  return( culng( _
    ( ( value.X * &hbf58476d1ce4e5b9ull + value.Y ) * &h94d049bb133111ebull ) ) )
end function

operator _
  =( _
    byref lhs as Key( of( Point2 ) ), _
    byref rhs as Key( of( Point2 ) ) ) _
  as integer
  
  return( lhs.value = rhs.value )
end operator

'' Now we can template the custom collection
template( LinkedList, of( Person ) )
template( Dictionary, _
  of( Point2 ), of( LinkedList( of( Person ) ) ) )

/'
  Little helper function to add a key to the dictionary
'/
sub _
  addTo( _
    byref aDictionary as Dictionary( _
      of( Point2 ), of( LinkedList( of( Person ) ) ) ), _
    byref aKey as Point2, _
    byval aPerson as Person ptr )
  
  var _
    aList => aDictionary.find( aKey )
  
  if( aList = 0 ) then
    aList => new LinkedList( of( Person ) )
    
    aDictionary.add( _
      aKey, aList )
  end if
  
  aList->addLast( aPerson )
end sub

/'
  And this other helper shows all the elements contained in the list
  at the specified key.
'/
sub _
  showAt( _
    byref aDictionary as Dictionary( _
      of( Point2 ), of( LinkedList( of( Person ) ) ) ), _
    byref aKey as Point2 )
  
  var _
    aList => aDictionary.find( aKey )
  
  if( aList <> 0 ) then
    var _
      aNode => aList->first
    
    for _
      items as integer => 0 _
      to aList->count - 1
      
      ? *aNode->item
      
      aNode => aNode->forward
    next
  end if
end sub

/'
  Note that this kind of data structure effectively describes a Spatial Hash.
  
  Spatial Hashes are a very efficient method of space partition, and can be
  used as acceleration structures in place of quadtrees (for the 2D case) and
  octrees (for the 3D case).
'/
var _
  aSpatialHash => Dictionary( _
    of( Point2 ), _
    of( LinkedList( of( Person ) ) ) )()
  
addTo( _
  aSpatialHash, _
  Point2( 2, 3 ), _
  new Person( "Paul Doe", 37 ) )
addTo( _
  aSpatialHash, _
  Point2( 3, 1 ), _
  new Person( "Janet Doe", 31 ) )
addTo( _
  aSpatialHash, _
  Point2( 4, 5 ), _
  new Person( "Shaiel Doe", 10 ) )
addTo( _
  aSpatialHash, _
  Point2( 4, 5 ), _
  new Person( "Foo Bar Baz", 99 ) )

? "At 2, 3"
showAt( aSpatialHash, Point2( 2, 3 ) )

?
? "At 3, 1"
showAt( aSpatialHash, Point2( 3, 1 ) )

?
? "At 4, 5"
showAt( aSpatialHash, Point2( 4, 5 ) )

sleep()
