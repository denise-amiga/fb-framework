#ifndef __FBFW_DRAWING_POINT__
#define __FBFW_DRAWING_POINT__

namespace Drawing
  /'
    Describes a point in cartesian space, using integer coordinates
  '/
  type _
    Point
    
    declare constructor()
    declare constructor( _
      byval as integer, _
      byval as integer )
    declare destructor()
    
    declare function _
      isInsideOf( _
        byref as _Rectangle ) _
      as boolean
    declare function _
      distanceTo( _
        byref as Point ) _
      as single
    declare function _
      perpendicularDistancesTo( _
        byref as Point ) _
      as Point
    
    declare operator _
      cast() as string
    declare operator _
      +=( _
        byref as Point )
    declare operator _
      +=( _
        byref as integer )
    declare operator _
      +=( _
        byref as single )
    declare operator _
      -=( _
        byref as Point )
    declare operator _
      -=( _
        byref as integer )
    declare operator _
      -=( _
        byref as single )
    declare operator _
      *=( _
        byref as Point )
    declare operator _
      *=( _
        byref as integer )
    declare operator _
      *=( _
        byref as single )
    declare operator _
      /=( _
        byref as Point )
    declare operator _
      /=( _
        byref as integer )
    declare operator _
      /=( _
        byref as single )
    declare operator _
      \=( _
        byref as integer )
      
    as integer _
      x, y
  end type
  
  constructor _
    Point()
  end constructor
  
  constructor _
    Point( _
      byval aX as integer, _
      byval aY as integer )
    
    x => aX
    y => aY
  end constructor
  
  destructor _
    Point()
  end destructor
  
  /'
    Returns the Euclidean distance to another Point
  '/
  function _
    Point.distanceTo( _
      byref another as Point ) _
    as single
    
    return( sqr( ( x - another.x ) ^ 2 + ( y - another.y ) ^ 2 ) )
  end function
  
  /'
    Returns the perpendicular (sometimes referred to as 'Manhattan') distances
    to another Point.
  '/
  function _
    Point.perpendicularDistancesTo( _
      byref another as Point ) _
    as Point
    
    return( Point( _
      x - another.x, _
      y - another.y ) )
  end function
  
  operator _
    Point.cast() as string
    
    return( _
      "{x:" & x & ", y:" & y & "}" )
  end operator
  
  operator _
    Point.+=( _
      byref rhs as Point )
    
    x +=> rhs.x
    y +=> rhs.y
  end operator
  
  operator _
    Point.+=( _
      byref rhs as integer )
      
    x +=> rhs
    y +=> rhs
  end operator
  
  operator _
    Point.+=( _
      byref rhs as single )
      
    x +=> rhs
    y +=> rhs
  end operator
  
  operator _
    Point.-=( _
      byref rhs as Point )
    
    x -=> rhs.x
    y -=> rhs.y
  end operator
  
  operator _
    Point.-=( _
      byref rhs as integer )
      
    x -=> rhs
    y -=> rhs
  end operator
  
  operator _
    Point.-=( _
      byref rhs as single )
      
    x -=> rhs
    y -=> rhs
  end operator
  
  operator _
    Point.*=( _
      byref rhs as Point )
    
    x *=> rhs.x
    y *=> rhs.y
  end operator
  
  operator _
    Point.*=( _
      byref rhs as integer )
      
    x *=> rhs
    y *=> rhs
  end operator
  
  operator _
    Point.*=( _
      byref rhs as single )
      
    x *=> rhs
    y *=> rhs
  end operator
  
  operator _
    Point./=( _
      byref rhs as Point )
    
    x /=> rhs.x
    y /=> rhs.y
  end operator
  
  operator _
    Point./=( _
      byref rhs as integer )
      
    x /=> rhs
    y /=> rhs
  end operator
  
  operator _
    Point./=( _
      byref rhs as single )
      
    x /=> rhs
    y /=> rhs
  end operator
  
  operator _
    Point.\=( _
      byref rhs as integer )
      
    x \=> rhs
    y \=> rhs
  end operator
  
  operator _
    =( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as integer
    
    return( _
      lhs.x = rhs.x andAlso _
      lhs.y = rhs.y )
  end operator
  
  operator _
    <>( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as integer
    
    return( _
      lhs.x <> rhs.x orElse _
      lhs.y <> rhs.y )
  end operator
  
  operator _
    >( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as integer
    
    return( _
      lhs.x > rhs.x andAlso _
      lhs.y > rhs.y )
  end operator
  
  operator _
    >=( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as integer
    
    return( _
      lhs.x >= rhs.x andAlso _
      lhs.y >= rhs.y )
  end operator
  
  operator _
    <( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as integer
    
    return( _
      lhs.x < rhs.x andAlso _
      lhs.y < rhs.y )
  end operator
  
  operator _
    <=( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as integer
    
    return( _
      lhs.x <= rhs.x andAlso _
      lhs.y <= rhs.y )
  end operator
  
  operator _
    abs( _
      byref rhs as Point ) _
    as Point
    
    return( Point( _
      abs( rhs.x ), abs( rhs.y ) ) )
  end operator
  
  operator _
    mod( _
      byref lhs as Point, _
      byref rhs as integer ) _
    as Point
    
    return( Point( _
      lhs.x mod rhs, lhs.y mod rhs ) )
  end operator
  
  operator _
    mod( _
      byref lhs as Point, _
      byref rhs as single ) _
    as Point
    
    return( Point( _
      Math.fMod( lhs.x, rhs ), Math.fMod( lhs.y, rhs ) ) )
  end operator
  
  operator _
    +( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as Point
    
    return( Point( _
      lhs.x + rhs.x, lhs.y + rhs.y ) )
  end operator
  
  operator _
    +( _
      byref lhs as Point, _
      byref rhs as integer ) _
    as Point
    
    return( Point( _
      lhs.x + rhs, lhs.y + rhs ) )
  end operator
  
  operator _
    +( _
      byref lhs as Point, _
      byref rhs as single ) _
    as Point
    
    return( Point( _
      lhs.x + rhs, lhs.y + rhs ) )
  end operator
  
  operator _
    -( _
      byref rhs as Point ) _
    as Point
    
    return( Point( _
      -rhs.x, -rhs.y ) )
  end operator
  
  operator _
    -( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as Point
    
    return( Point( _
      lhs.x - rhs.x, lhs.y - rhs.y ) )
  end operator
  
  operator _
    -( _
      byref lhs as Point, _
      byref rhs as integer ) _
    as Point
    
    return( Point( _
      lhs.x - rhs, lhs.y - rhs ) )
  end operator
  
  operator _
    -( _
      byref lhs as Point, _
      byref rhs as single ) _
    as Point
    
    return( Point( _
      lhs.x - rhs, lhs.y - rhs ) )
  end operator
  
  operator _
    *( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as Point
    
    return( Point( _
      lhs.x * rhs.x, lhs.y * rhs.y ) )
  end operator
  
  operator _
    *( _
      byref lhs as Point, _
      byref rhs as integer ) _
    as Point
    
    return( Point( _
      lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator _
    *( _
      byref lhs as Point, _
      byref rhs as single ) _
    as Point
    
    return( Point( _
      lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator _
    /( _
      byref lhs as Point, _
      byref rhs as Point ) _
    as Point
    
    return( Point( _
      lhs.x / rhs.x, lhs.y / rhs.y ) )
  end operator
  
  operator _
    /( _
      byref lhs as Point, _
      byref rhs as integer ) _
    as Point
    
    return( Point( _
      lhs.x / rhs, lhs.y / rhs ) )
  end operator
  
  operator _
    /( _
      byref lhs as Point, _
      byref rhs as single ) _
    as Point
    
    return( Point( _
      lhs.x / rhs, lhs.y / rhs ) )
  end operator
  
  operator _
    \( _
      byref lhs as Point, _
      byref rhs as integer ) _
    as Point
    
    return( Point( _
      lhs.x \ rhs, lhs.y \ rhs ) )
  end operator
  
  operator _
    \( _
      byref lhs as integer, _
      byref rhs as Point ) _
    as Point
    
    return( Point( _
      lhs \ rhs.x, lhs \ rhs.y ) )
  end operator
end namespace

#endif
