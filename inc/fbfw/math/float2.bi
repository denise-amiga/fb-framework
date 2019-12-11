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
        byval as float, _
        byval as float )
      declare constructor( _
        byref as float2 )
      declare operator let( _
        byref as float2 )
      declare operator cast() as string
      
      '' Swizzlings
      declare function yx() as float2
      declare function xx() as float2
      declare function yy() as float2
      
      declare function _
        sideDistance( _
          byref as const float2, _
          byref as const float2 ) _
        as float
      declare function dot( _
        byref as float2 ) as float
      declare function cross( _
        byref as float2 ) as float
      declare function length() as float
      declare function squaredLength() as float
      declare function unit() as float2
      declare sub normalize()
      declare sub turnLeft()
      declare sub turnRight()
      declare sub rotate( _
        byval as Math.Radians )
      declare function rotated( _
        byval as Math.Radians ) as Math.float2
      declare function angle() as Math.Radians
      declare function distance( _
        byref as float2 ) as float
      declare sub setLength( _
        byval as float )
      
      as float _
        x, y
  end type
  
  constructor float2() 
    x = 0.0
    y = 0.0
  end constructor
  
  constructor float2( _
    byval nx as float, _
    byval ny as float ) 
    
    x = nx
    y = ny
  end constructor
  
  constructor float2( _
    byref rhs as float2 ) 
    
    x = rhs.x
    y = rhs.y
  end constructor
  
  operator float2.let( _
    byref rhs as float2 ) 
    
    x = rhs.x
    y = rhs.y
  end operator
  
  operator float2.cast() as string 
    return(	_
      "| " & str( x ) & " |" & chr( 10 ) & chr( 13 ) & _
      "| " & str( y ) & " |" & chr( 10 ) & chr( 13 ) )
  end operator
  
  '' Swizzlings
  function float2.yx() as float2
    return( float2( y, x ) )
  end function
  
  function float2.xx() as float2
    return( float2( x, x ) )
  end function
  
  function float2.yy() as float2
    return( float2( y, y ) )
  end function
  
  '' Basic arithmetic operators
  operator + ( _
    byref lhs as float2, byref rhs as float2 ) as float2 
    
    return( float2( lhs.x + rhs.x, lhs.y + rhs.y ) )
  end operator
  
  operator + ( _
    byref lhs as float2, byref rhs as float ) as float2 
    
    return( float2( lhs.x + rhs, lhs.y + rhs ) )
  end operator
  
  operator + ( _
    byref lhs as float, byref rhs as float2 ) as float2 
    
    return( float2( lhs + rhs.x, lhs + rhs.y ) )
  end operator
  
  operator - ( _
    byref lhs as float2, byref rhs as float2 ) as float2 
    
    return( float2( lhs.x - rhs.x, lhs.y - rhs.y ) )
  end operator
  
  operator - ( _
    byref lhs as float2, byref rhs as float ) as float2 
    
    return( float2( lhs.x - rhs, lhs.y - rhs ) )
  end operator
  
  operator - ( _
    byref lhs as float, byref rhs as float2 ) as float2 
    
    return( float2( lhs - rhs.x, lhs - rhs.y ) )
  end operator
  
  operator - ( byref lhs as float2 ) as float2 
    return( float2( -lhs.x, -lhs.y ) )
  end operator
  
  operator * ( _
    byref lhs as float2, byref rhs as float2 ) as float2 
    
    return( float2( lhs.x * rhs.x, lhs.y * rhs.y ) )
  end operator
  
  operator * ( _
    byref lhs as float2, byref rhs as float ) as float2 
    
    return( float2( lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator * ( _
    byref lhs as float, byref rhs as float2 ) as float2 
    
    return( float2( lhs * rhs.x, lhs * rhs.y ) )
  end operator
  
  operator * ( _
    byref lhs as float2, byref rhs as integer ) as float2 
    
    return( float2( lhs.x * rhs, lhs.y * rhs ) )
  end operator
  
  operator * ( _
    byref lhs as integer, byref rhs as float2 ) as float2 
    
    return( float2( lhs * rhs.x, lhs * rhs.y ) )
  end operator
  
  operator / ( _
    byref lhs as float2, byref rhs as float2 ) as float2 
    
    return( float2( lhs.x / rhs.x, lhs.y / rhs.y ) )
  end operator
  
  operator / ( _
    byref lhs as float2, byref rhs as float ) as float2 
    
    return( float2( lhs.x / rhs, lhs.y / rhs ) )
  end operator
  
  operator > ( _
    byref lhs as float2, byref rhs as float2 ) as integer
    
    return( iif( _
      lhs.x > rhs.x andAlso _
      lhs.y > rhs.y, -1, 0 ) )
  end operator
  
  operator < ( _
    byref lhs as float2, byref rhs as float2 ) as integer
    
    return( iif( _
      lhs.x < rhs.x andAlso _
      lhs.y < rhs.y, -1, 0 ) )
  end operator

  operator <= ( _
    byref lhs as float2, byref rhs as float2 ) as integer
    
    return( _
      iif( _
      lhs.x <= rhs.x andAlso _
      lhs.y <= rhs.y, -1, 0 ) )
  end operator
  
  operator >= ( _
    byref lhs as float2, byref rhs as float2 ) as integer
    
    return( iif( _
      lhs.x >= rhs.x andAlso _
      lhs.y >= rhs.y, -1, 0 ) )
  end operator
  
  operator <> ( _
    byref lhs as float2, byref rhs as float2 ) as integer
    
    return( iif( _
      lhs.x <> rhs.x orElse _
      lhs.y <> rhs.y, -1, 0 ) )
  end operator
  
  operator = ( _
    byref lhs as float2, byref rhs as float2 ) as integer
    
    return( iif( _
      lhs.x = rhs.x andAlso _
      lhs.y = rhs.y, -1, 0 ) )
  end operator
  
  /'
    Returns the dot product of this vector with another
    vector v.
  '/
  function float2.dot( _
    byref v as float2 ) as float 
    
    return( x * v.x + y * v.y ) 
  end function
  
  /'
    The cross product is not defined in 2d, so this 
    function returns the z component of the cross product
    of this vector with vector v, if augmented to 3d
  '/
  function float2.cross( _
    byref v as float2 ) as float 
    
    return( x * v.y - y * v.x )
  end function
  
  '' Returns the length of this vector
  function float2.length() as float 
    return( sqr( x ^ 2 + y ^ 2 ) )
  end function
  
  /'
    Returns the squared length of this vector.
    
    Useful when one just want to compare two vectors to
    see which is longest, as this avoids computing the
    square root.
  '/
  function float2.squaredLength() as float 
    return( x ^ 2 + y ^ 2 )
  end function
  
  '' Returns a normalized copy of this vector
  function float2.unit() as float2 
    dim as float l = sqr( x ^ 2 + y ^ 2 )
    
    if( l > 0.0 ) then
      return( float2( x, y ) / l )
    else
      return( float2( x, y ) )
    end if
  end function
  
  '' Normalizes this vector
  sub float2.normalize() 
    dim as float l = sqr( x ^ 2 + y ^ 2 )
    
    if( l > 0.0 ) then
      x /= l
      y /= l
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
  sub float2.turnLeft() 
    this = float2( y, -x )
  end sub
  
  sub float2.turnRight() 
    this = float2( -y, x )
  end sub
  
  /'
    Rotates this vector by anAngle 
  '/
  sub float2.rotate( _
    byval anAngle as Math.Radians )
    
    dim as float si = sin( anAngle )
    dim as float co = cos( anAngle )
    
    this = float2( _
      x * co - y * si, x * si + y * co )
  end sub
  
  function _
    float2.rotated( _
      byval anAngle as Math.Radians ) _
    as Math.float2
    
    dim as float _
      si => sin( anAngle ), _
      co => cos( anAngle )
    
    return( float2( _
      x * co - y * si, x * si + y * co ) )
  end function
  
  '' Returns the angle that this vector points to
  function float2.angle() as Math.Radians
    return( atan2( y, x ) )
  end function
  
  '' Sets the length of this vector
  sub float2.setLength( _
    byval newLength as float )
    
    dim as float vectorAngle = atan2( y, x )
    
    x = newLength * cos( vectorAngle )
    y = newLength * sin( vectorAngle )
  end sub
  
  '' Returns the distance between this vector and another one
  function float2.distance( _
    byref aVector as float2 ) as float
    
    return( ( this - aVector ).length )
  end function
  
  /'
    Returns the distance of this float2 from the half-space
    defined by p1 -> p2.
  '/
  function float2.sideDistance( _
    byref p1 as const float2, _
    byref p2 as const float2 ) as float
    
    return( _
      ( p1.x - x ) * ( p2.y - y ) - _
      ( p2.x - x ) * ( p1.y - y ) )
  end function
  
  operator _
    abs( _
      byref rhs as Float2 ) _
    as Float2
    
    return( Float2( abs( rhs.x ), abs( rhs.y ) ) )
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
