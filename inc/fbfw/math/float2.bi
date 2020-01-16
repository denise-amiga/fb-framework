#ifndef __FBFW_MATH_FLOAT2__
#define __FBFW_MATH_FLOAT2__

namespace Math
  /'
    2D vector
    
    | x |
    | y |
  '/
  type _
    Float2
    
    public:
      declare constructor()
      declare constructor( _
        byval as float => 0.0, _
        byval as float => 0.0 )
      declare constructor( _
        byref as Float2 )
      declare operator let( _
        byref as Float2 )
      declare operator cast() as string
      
      '' Swizzlings
      declare function yx() as Float2
      declare function xx() as Float2
      declare function yy() as Float2
      
      declare function _
        sideDistance( _
          byref as const Float2, _
          byref as const Float2 ) _
        as float
      declare function dot( _
        byref as Float2 ) as float
      declare function cross( _
        byref as Float2 ) as float
      declare function length() as float
      declare function squaredLength() as float
      declare function normalized() as Float2
      declare sub normalize()
      declare sub turnLeft()
      declare sub turnRight()
      declare sub rotate( _
        byval as Math.Radians )
      declare function rotated( _
        byval as Math.Radians ) as Math.Float2
      declare function angle() as Math.Radians
      declare function distance( _
        byref as Float2 ) as float
      declare function squaredDistance( _
        byref as Float2 ) as float
      declare sub setLength( _
        byval as float )
      
      as float _
        x, y
  end type
  
  constructor Float2() 
    x => 0.0
    y => 0.0
  end constructor
  
  constructor Float2( _
    byval nx as float => 0.0, _
    byval ny as float => 0.0 ) 
    
    x => nx
    y => ny
  end constructor
  
  constructor Float2( _
    byref rhs as Float2 ) 
    
    x => rhs.x
    y => rhs.y
  end constructor
  
  operator Float2.let( _
    byref rhs as Float2 ) 
    
    x => rhs.x
    y => rhs.y
  end operator
  
  operator Float2.cast() as string 
    return(	_
      "| " & str( x ) & " |" & chr( 10 ) & chr( 13 ) & _
      "| " & str( y ) & " |" & chr( 10 ) & chr( 13 ) )
  end operator
  
  '' Swizzlings
  function Float2.yx() as Float2
    return( Float2( y, x ) )
  end function
  
  function Float2.xx() as Float2
    return( Float2( x, x ) )
  end function
  
  function Float2.yy() as Float2
    return( Float2( y, y ) )
  end function
  
  '' Basic arithmetic operators
  operator + ( _
    byref lhs as Float2, byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs.x + rhs.x, lhs.y + rhs.y ) )
  end operator
  
  operator + ( _
    byref lhs as Float2, byref rhs as float ) as Float2 
    
    return( Float2( lhs.x + rhs, lhs.y + rhs ) )
  end operator
  
  operator + ( _
    byref lhs as float, byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs + rhs.x, lhs + rhs.y ) )
  end operator
  
  operator - ( _
    byref lhs as Float2, byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs.x - rhs.x, lhs.y - rhs.y ) )
  end operator
  
  operator - ( _
    byref lhs as Float2, byref rhs as float ) as Float2 
    
    return( Float2( lhs.x - rhs, lhs.y - rhs ) )
  end operator
  
  operator - ( _
    byref lhs as float, byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs - rhs.x, lhs - rhs.y ) )
  end operator
  
  operator - ( byref lhs as Float2 ) as Float2 
    return( Float2( -lhs.x, -lhs.y ) )
  end operator
  
  operator * ( _
    byref lhs as Float2, byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs.x * rhs.x, lhs.y * rhs.y ) )
  end operator
  
  operator * ( _
    byref lhs as Float2, byref rhs as float ) as Float2 
    
    return( Float2( lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator * ( _
    byref lhs as float, byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs * rhs.x, lhs * rhs.y ) )
  end operator
  
  operator * ( _
    byref lhs as Float2, byref rhs as integer ) as Float2 
    
    return( Float2( lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator * ( _
    byref lhs as integer, byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs * rhs.x, lhs * rhs.y ) )
  end operator
  
  operator / ( _
    byref lhs as Float2, byref rhs as Float2 ) as Float2 
    
    return( Float2( lhs.x / rhs.x, lhs.y / rhs.y ) )
  end operator
  
  operator / ( _
    byref lhs as Float2, byref rhs as float ) as Float2 
    
    return( Float2( lhs.x / rhs, lhs.y / rhs ) )
  end operator
  
  operator > ( _
    byref lhs as Float2, byref rhs as Float2 ) as integer
    
    return( iif( _
      lhs.x > rhs.x andAlso _
      lhs.y > rhs.y, -1, 0 ) )
  end operator
  
  operator < ( _
    byref lhs as Float2, byref rhs as Float2 ) as integer
    
    return( iif( _
      lhs.x < rhs.x andAlso _
      lhs.y < rhs.y, -1, 0 ) )
  end operator

  operator <= ( _
    byref lhs as Float2, byref rhs as Float2 ) as integer
    
    return( _
      iif( _
      lhs.x <= rhs.x andAlso _
      lhs.y <= rhs.y, -1, 0 ) )
  end operator
  
  operator >= ( _
    byref lhs as Float2, byref rhs as Float2 ) as integer
    
    return( iif( _
      lhs.x >= rhs.x andAlso _
      lhs.y >= rhs.y, -1, 0 ) )
  end operator
  
  operator <> ( _
    byref lhs as Float2, byref rhs as Float2 ) as integer
    
    return( iif( _
      lhs.x <> rhs.x orElse _
      lhs.y <> rhs.y, -1, 0 ) )
  end operator
  
  operator = ( _
    byref lhs as Float2, byref rhs as Float2 ) as integer
    
    return( iif( _
      lhs.x = rhs.x andAlso _
      lhs.y = rhs.y, -1, 0 ) )
  end operator
  
  /'
    Returns the dot product of this vector with another
    vector v.
  '/
  function Float2.dot( _
    byref v as Float2 ) as float 
    
    return( x * v.x + y * v.y ) 
  end function
  
  /'
    The cross product is not defined in 2d, so this 
    function returns the z component of the cross product
    of this vector with vector v, if augmented to 3d.
  '/
  function Float2.cross( _
    byref v as Float2 ) as float 
    
    return( x * v.y - y * v.x )
  end function
  
  '' Returns the length of this vector
  function Float2.length() as float 
    return( sqr( x ^ 2 + y ^ 2 ) )
  end function
  
  /'
    Returns the squared length of this vector.
    
    Useful when one just want to compare two vectors to
    see which is longest, as this avoids computing the
    square root.
  '/
  function Float2.squaredLength() as float 
    return( x ^ 2 + y ^ 2 )
  end function
  
  '' Returns a normalized copy of this vector
  function Float2.normalized() as Float2 
    dim as float _
      l => sqr( x ^ 2 + y ^ 2 )
    
    if( l > 0.0 ) then
      return( Float2( x, y ) / l )
    else
      return( Float2( x, y ) )
    end if
  end function
  
  '' Normalizes this vector
  sub Float2.normalize() 
    dim as float _
      l => sqr( x ^ 2 + y ^ 2 )
    
    if( l > 0.0 ) then
      x /=> l
      y /=> l
    end if
  end sub
  
  /'
    turnLeft and turnRight rotate this vector 90 degrees to
    the left and right.
    
    Very useful to quickly find normals in 2D, as the normal
    of any vector is simply the vector rotated 90 degrees.
    So, if you want to find the normal of vector v, you can
    express it like this:
    
    n = normalized( turnLeft( v ) )
  '/
  sub Float2.turnLeft() 
    this => Float2( y, -x )
  end sub
  
  sub Float2.turnRight() 
    this => Float2( -y, x )
  end sub
  
  /'
    Rotates this vector by anAngle 
  '/
  sub Float2.rotate( _
    byval anAngle as Math.Radians )
    
    dim as float _
      si => sin( anAngle ), _
      co => cos( anAngle )
    
    this => Float2( _
      x * co - y * si, _
      x * si + y * co )
  end sub
  
  function _
    Float2.rotated( _
      byval anAngle as Math.Radians ) _
    as Math.Float2
    
    dim as float _
      si => sin( anAngle ), _
      co => cos( anAngle )
    
    return( Float2( _
      x * co - y * si, _
      x * si + y * co ) )
  end function
  
  '' Returns the angle that this vector points to
  function Float2.angle() as Math.Radians
    return( atan2( y, x ) )
  end function
  
  '' Sets the length of this vector
  sub Float2.setLength( _
    byval newLength as float )
    
    dim as float _
      vectorAngle => atan2( y, x )
    
    x => newLength * cos( vectorAngle )
    y => newLength * sin( vectorAngle )
  end sub
  
  '' Returns the distance between this vector and another one
  function _
    Float2.distance( _
      byref v as Float2 ) _
    as float
    
    return( ( this - v ).length )
  end function
  
  /'
    Returns the squared distance to another vector. Useful to
    compare distances.
  '/
  function _
    Float2.squareddistance( _
      byref v as Float2 ) _
    as float
    
    return( _
      ( x - v.x ) ^ 2 + _
      ( y - v.y ) ^ 2 )
  end function
  
  /'
    Returns the distance of this Float2 from the half-space
    defined by p1 -> p2.
  '/
  function Float2.sideDistance( _
    byref p1 as const Float2, _
    byref p2 as const Float2 ) as float
    
    return( _
      ( p1.x - x ) * ( p2.y - y ) - _
      ( p2.x - x ) * ( p1.y - y ) )
  end function
  
  operator _
    abs( _
      byref rhs as Float2 ) _
    as Float2
    
    return( Float2( _
      abs( rhs.x ), _
      abs( rhs.y ) ) )
  end operator
  
  function _
    vMax overload( _
      byref p as Float2, _
      byval v as float ) _
    as Float2
    
    return( Float2( _
      fMax( p.x, v ), _
      fMax( p.y, v ) ) )
  end function
  
  function _
    vMin overload( _
      byref p as Float2, _
      byval v as float ) _
    as Float2
    
    return( Float2( _
      fMin( p.x, v ), _
      fMin( p.y, v ) ) )
  end function
end namespace

#endif
