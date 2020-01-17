#ifndef __FBFW_DRAWING_POINTF__
#define __FBFW_DRAWING_POINTF__

namespace Drawing
  /'
    Describes a point in cartesian space, using float coordinates
  '/
  type _
    PointF
    
    declare constructor()
    declare constructor( _
      byval as single, _
      byval as single )
    declare destructor()
    
    declare function _
      isInsideOf( _
        byref as _RectangleF ) _
      as boolean
    declare function _
      distanceTo( _
        byref as PointF ) _
      as single
    declare function _
      perpendicularDistancesTo( _
        byref as PointF ) _
      as PointF
    
    declare operator _
      cast() as string
    declare operator _
      +=( _
        byref as PointF )
    declare operator _
      +=( _
        byref as integer )
    declare operator _
      +=( _
        byref as single )
    declare operator _
      -=( _
        byref as PointF )
    declare operator _
      -=( _
        byref as integer )
    declare operator _
      -=( _
        byref as single )
    declare operator _
      *=( _
        byref as PointF )
    declare operator _
      *=( _
        byref as integer )
    declare operator _
      *=( _
        byref as single )
    declare operator _
      /=( _
        byref as PointF )
    declare operator _
      /=( _
        byref as integer )
    declare operator _
      /=( _
        byref as single )
    declare operator _
      \=( _
        byref as integer )
      
    as single _
      x, y
  end type
  
  constructor _
    PointF()
  end constructor
  
  constructor _
    PointF( _
      byval aX as single, _
      byval aY as single )
    
    x => aX
    y => aY
  end constructor
  
  destructor _
    PointF()
  end destructor
  
  /'
    Returns the Euclidean distance to another PointF
  '/
  function _
    PointF.distanceTo( _
      byref another as PointF ) _
    as single
    
    return( sqr( ( x - another.x ) ^ 2 + ( y - another.y ) ^ 2 ) )
  end function
  
  /'
    Returns the perpendicular (sometimes referred to as 'Manhattan') distances
    to another PointF.
  '/
  function _
    PointF.perpendicularDistancesTo( _
      byref another as PointF ) _
    as PointF
    
    return( PointF( _
      x - another.x, _
      y - another.y ) )
  end function
  
  operator _
    PointF.cast() as string
    
    return( _
      "{x:" & x & ", y:" & y & "}" )
  end operator
  
  operator _
    PointF.+=( _
      byref rhs as PointF )
    
    x +=> rhs.x
    y +=> rhs.y
  end operator
  
  operator _
    PointF.+=( _
      byref rhs as integer )
      
    x +=> rhs
    y +=> rhs
  end operator
  
  operator _
    PointF.+=( _
      byref rhs as single )
      
    x +=> rhs
    y +=> rhs
  end operator
  
  operator _
    PointF.-=( _
      byref rhs as PointF )
    
    x -=> rhs.x
    y -=> rhs.y
  end operator
  
  operator _
    PointF.-=( _
      byref rhs as integer )
      
    x -=> rhs
    y -=> rhs
  end operator
  
  operator _
    PointF.-=( _
      byref rhs as single )
      
    x -=> rhs
    y -=> rhs
  end operator
  
  operator _
    PointF.*=( _
      byref rhs as PointF )
    
    x *=> rhs.x
    y *=> rhs.y
  end operator
  
  operator _
    PointF.*=( _
      byref rhs as integer )
      
    x *=> rhs
    y *=> rhs
  end operator
  
  operator _
    PointF.*=( _
      byref rhs as single )
      
    x *=> rhs
    y *=> rhs
  end operator
  
  operator _
    PointF./=( _
      byref rhs as PointF )
    
    x /=> rhs.x
    y /=> rhs.y
  end operator
  
  operator _
    PointF./=( _
      byref rhs as integer )
      
    x /=> rhs
    y /=> rhs
  end operator
  
  operator _
    PointF./=( _
      byref rhs as single )
      
    x /=> rhs
    y /=> rhs
  end operator
  
  operator _
    PointF.\=( _
      byref rhs as integer )
      
    x \=> rhs
    y \=> rhs
  end operator
  
  operator _
    =( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as integer
    
    return( _
      lhs.x = rhs.x andAlso _
      lhs.y = rhs.y )
  end operator
  
  operator _
    <>( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as integer
    
    return( _
      lhs.x <> rhs.x orElse _
      lhs.y <> rhs.y )
  end operator
  
  operator _
    >( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as integer
    
    return( _
      lhs.x > rhs.x andAlso _
      lhs.y > rhs.y )
  end operator
  
  operator _
    >=( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as integer
    
    return( _
      lhs.x >= rhs.x andAlso _
      lhs.y >= rhs.y )
  end operator
  
  operator _
    <( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as integer
    
    return( _
      lhs.x < rhs.x andAlso _
      lhs.y < rhs.y )
  end operator
  
  operator _
    <=( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as integer
    
    return( _
      lhs.x <= rhs.x andAlso _
      lhs.y <= rhs.y )
  end operator
  
  operator _
    abs( _
      byref rhs as PointF ) _
    as PointF
    
    return( PointF( _
      abs( rhs.x ), abs( rhs.y ) ) )
  end operator
  
  operator _
    mod( _
      byref lhs as PointF, _
      byref rhs as integer ) _
    as PointF
    
    return( PointF( _
      lhs.x mod rhs, lhs.y mod rhs ) )
  end operator
  
  operator _
    mod( _
      byref lhs as PointF, _
      byref rhs as single ) _
    as PointF
    
    return( PointF( _
      Math.fMod( lhs.x, rhs ), Math.fMod( lhs.y, rhs ) ) )
  end operator
  
  operator _
    +( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as PointF
    
    return( PointF( _
      lhs.x + rhs.x, lhs.y + rhs.y ) )
  end operator
  
  operator _
    +( _
      byref lhs as PointF, _
      byref rhs as integer ) _
    as PointF
    
    return( PointF( _
      lhs.x + rhs, lhs.y + rhs ) )
  end operator
  
  operator _
    +( _
      byref lhs as PointF, _
      byref rhs as single ) _
    as PointF
    
    return( PointF( _
      lhs.x + rhs, lhs.y + rhs ) )
  end operator
  
  operator _
    -( _
      byref rhs as PointF ) _
    as PointF
    
    return( PointF( _
      -rhs.x, -rhs.y ) )
  end operator
  
  operator _
    -( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as PointF
    
    return( PointF( _
      lhs.x - rhs.x, lhs.y - rhs.y ) )
  end operator
  
  operator _
    -( _
      byref lhs as PointF, _
      byref rhs as integer ) _
    as PointF
    
    return( PointF( _
      lhs.x - rhs, lhs.y - rhs ) )
  end operator
  
  operator _
    -( _
      byref lhs as PointF, _
      byref rhs as single ) _
    as PointF
    
    return( PointF( _
      lhs.x - rhs, lhs.y - rhs ) )
  end operator
  
  operator _
    *( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as PointF
    
    return( PointF( _
      lhs.x * rhs.x, lhs.y * rhs.y ) )
  end operator
  
  operator _
    *( _
      byref lhs as PointF, _
      byref rhs as integer ) _
    as PointF
    
    return( PointF( _
      lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator _
    *( _
      byref lhs as PointF, _
      byref rhs as single ) _
    as PointF
    
    return( PointF( _
      lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator _
    /( _
      byref lhs as PointF, _
      byref rhs as PointF ) _
    as PointF
    
    return( PointF( _
      lhs.x / rhs.x, lhs.y / rhs.y ) )
  end operator
  
  operator _
    /( _
      byref lhs as PointF, _
      byref rhs as integer ) _
    as PointF
    
    return( PointF( _
      lhs.x / rhs, lhs.y / rhs ) )
  end operator
  
  operator _
    /( _
      byref lhs as PointF, _
      byref rhs as single ) _
    as PointF
    
    return( PointF( _
      lhs.x / rhs, lhs.y / rhs ) )
  end operator
  
  operator _
    \( _
      byref lhs as PointF, _
      byref rhs as integer ) _
    as PointF
    
    return( PointF( _
      lhs.x \ rhs, lhs.y \ rhs ) )
  end operator
end namespace
#endif
