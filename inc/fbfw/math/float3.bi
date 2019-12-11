#ifndef __FBFW_MATH_FLOAT3__
#define __FBFW_MATH_FLOAT3__

namespace Math
  /'
    3D vector
    
    | x |
    | y |
    | z |
    
    10/29/2019
      Removed swizzlings for RGB color components.
  '/
  type float3
    public:
      declare constructor()
      declare constructor( _
        byval as float = 0.0, _
        byval as float = 0.0, _
        byval as float = 0.0 )
      declare constructor( _
        byref as float2, _
        byval as float = 0.0 )
      declare constructor( _
        byval as float = 0.0, _
        byref as float2 )
      declare constructor( _
        byref rhs as float3 )
      declare operator let( _
        byref rhs as float3 )
      
      declare operator cast() as string
      
      '' Swizzlings
      declare function xx() as float2
      declare function yx() as float2
      declare function zx() as float2
      declare function xy() as float2
      declare function yy() as float2
      declare function zy() as float2
      declare function xz() as float2
      declare function yz() as float2
      declare function zz() as float2
      declare function xxx() as float3
      declare function yxx() as float3
      declare function zxx() as float3
      declare function xyx() as float3
      declare function yyx() as float3
      declare function zyx() as float3
      declare function xzx() as float3
      declare function yzx() as float3
      declare function zzx() as float3
      declare function xxy() as float3
      declare function yxy() as float3
      declare function zxy() as float3
      declare function xyy() as float3
      declare function yyy() as float3
      declare function zyy() as float3
      declare function xzy() as float3
      declare function yzy() as float3
      declare function zzy() as float3
      declare function xxz() as float3
      declare function yxz() as float3
      declare function zxz() as float3
      declare function yyz() as float3
      declare function zyz() as float3
      declare function xzz() as float3
      declare function yzz() as float3
      declare function zzz() as float3
      
      '' Convenience functions
      declare function length() as float
      declare function squaredLength() as float
      declare sub normalize()
      declare function unit() as float3
      declare sub homogeneize()
      declare function homogeneous() as float3
      declare function cross( _
        byref v as float3 ) as float3
      declare function dot( _
        byref v as float3 ) as float
      declare function distance( _
        byref v as float3 ) as float
      
      as float _
        x, y, z
  end type
  
  constructor float3()
  end constructor
  
  constructor float3( _
    byval nx as float = 0.0, _
    byval ny as float = 0.0, _
    byval nz as float = 0.0 )
    
    x => nx
    y => ny
    z => nz
  end constructor
  
  constructor float3( _
    byref aVector as float2, _
    byval nz as float => 0.0 )
    
    x => aVector.x
    y => aVector.y
    z => nz
  end constructor
  
  constructor float3( _
    byval nx as float, _
    byref aVector as float2 )
    
    x => nx
    y => aVector.x
    z => aVector.y
  end constructor
  
  '' Copy constructor
  constructor float3( _
    byref rhs as float3 )
    x => rhs.x
    y => rhs.y
    z => rhs.z
  end constructor
  
  operator float3.let( _
    byref rhs as float3 )
    
    x => rhs.x
    y => rhs.y
    z => rhs.z
  end operator
  
  '' Human readable string representation (useful for debugging)
  operator float3.cast() as string
    return( _
      "| " & trim( str( x ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( y ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( z ) ) & " |" & chr( 13 ) & chr( 10 ) )
  end operator
  
  function float3.xx() as float2
    return( float2( x, x ) )
  end function
  
  function float3.yx() as float2
    return( float2( y, x ) )
  end function
  
  function float3.zx() as float2
    return( float2( z, x ) )
  end function
  
  function float3.xy() as float2
    return( float2( x, y ) )
  end function
  
  function float3.yy() as float2
    return( float2( y, y ) )
  end function
  
  function float3.zy() as float2
    return( float2( z, y ) )
  end function
  
  function float3.xz() as float2
    return( float2( x, z ) )
  end function
  
  function float3.yz() as float2
    return( float2( y, z ) )
  end function
  
  function float3.zz() as float2
    return( float2( z, z ) )
  end function
  
  function float3.xxx() as float3
    return( float3( x, x, x ) )
  end function
  
  function float3.yxx() as float3
    return( float3( y, x, x ) )
  end function
  
  function float3.zxx() as float3
    return( float3( z, x, x ) )
  end function
  
  function float3.xyx() as float3
    return( float3( x, y, x ) )
  end function
  
  function float3.yyx() as float3
    return( float3( y, y, x ) )
  end function
  
  function float3.zyx() as float3
    return( float3( z, y, x ) )
  end function
  
  function float3.xzx() as float3
    return( float3( x, z, x ) )
  end function
  
  function float3.yzx() as float3
    return( float3( y, z, x ) )
  end function
  
  function float3.zzx() as float3
    return( float3( z, z, x ) )
  end function
  
  function float3.xxy() as float3
    return( float3( x, x, y ) )
  end function
  
  function float3.yxy() as float3
    return( float3( y, x, y ) )
  end function
  
  function float3.zxy() as float3
    return( float3( z, x, y ) )
  end function
  
  function float3.xyy() as float3
    return( float3( x, y, y ) )
  end function
  
  function float3.yyy() as float3
    return( float3( y, y, y ) )
  end function
  
  function float3.zyy() as float3
    return( float3( z, y, y ) )
  end function
  
  function float3.xzy() as float3
    return( float3( x, z, y ) )
  end function
  
  function float3.yzy() as float3
    return( float3( y, z, y ) )
  end function
  
  function float3.zzy() as float3
    return( float3( z, z, y ) )
  end function
  
  function float3.xxz() as float3
    return( float3( x, x, z ) )
  end function
  
  function float3.yxz() as float3
    return( float3( y, x, z ) )
  end function
  
  function float3.zxz() as float3
    return( float3( z, x, z ) )
  end function
  
  function float3.yyz() as float3
    return( float3( y, y, z ) )
  end function
  
  function float3.zyz() as float3
    return( float3( z, y, z ) )
  end function
  
  function float3.xzz() as float3
    return( float3( x, z, z ) )
  end function
  
  function float3.yzz() as float3
    return( float3( y, z, z ) )
  end function
  
  function float3.zzz() as float3
    return( float3( z, z, z ) )
  end function
  
  operator _
    = ( _
      byref lhs as float3, _
      byref rhs as float3 ) _
    as integer
    
    return( _
      lhs.x = rhs.x andAlso _
      lhs.y = rhs.y andAlso _
      lhs.z = rhs.z )
  end operator
  
  operator _
    <> ( _
      byref lhs as float3, _
      byref rhs as float3 ) _
    as integer
    
    return( _
      lhs.x <> rhs.x orElse _
      lhs.y <> rhs.y orElse _
      lhs.z <> rhs.z )
  end operator
  
  '' Substraction operator
  operator - ( _
    byref v as float3, byref w as float3 ) as float3
    
    return( float3( v.x - w.x, v.y - w.y, v.z - w.z ) )
  end operator
  
  '' Negation operator
  operator - ( _
    byref v as float3 ) as float3
    
    return( float3( -v.x, -v.y, -v.z ) )
  end operator
  
  operator + ( _
    byref v as float3, byref w as float3 ) as float3
    
    return( float3( v.x + w.x, v.y + w.y, v.z + w.z ) )
  end operator
  
  operator _
    * ( _
      byref v as float3, _
      byref w as float3 ) _
    as float3
    
    return( float3( _
      v.x * w.x, _
      v.y * w.y, _
      v.z * w.z ) )
  end operator
  
  /'
    Multiplication with a scalar.
    
    Note that this is not a 'scalar product', but a
    multiplication with a number vectors do not define
    multiplications per se, they define the dot product
    and the cross product. To avoid confusion (and also
    correctness), the multiplication operator is overloaded
    to a scaling of the vector.
  '/
  operator * ( _
    byref v as float3, byref s as float ) as float3
    
    return( float3( v.x * s, v.y * s, v.z * s ) )
  end operator
  
  '' Same as above but with the parameters inversed
  operator * ( _
    byref s as float, byref v as float3 ) as float3
    return( float3( v.x * s, v.y * s, v.z * s ) )
  end operator
  
  '' Division by a scalar. See note above on multiplying a vector
  operator / ( _
    byref v as float3, byref s as float ) as float3
    return( float3( v.x / s, v.y / s, v.z / s ) )
  end operator
  
  '' Division by another vector
  operator / ( _
    byref v as float3, byref w as float3 ) as float3
    
    return( float3( v.x / w.x, v.y / w.y, v.z / w.z ) )
  end operator

  /'
    Returns the squared length of this vector
    
    Useful when you just want to compare which one is bigger,
    as this avoids having to compute a square root.
  '/
  function float3.squaredLength() as float
    return( x ^ 2 + y ^ 2 + z ^ 2 )
  end function
  
  '' Returns the length of this vector
  function float3.length() as float
    return( sqr( x ^ 2 + y ^ 2 + z ^ 2 ) )
  end function
  
  /'
    Normalizes the vector.
    
    Note that the homogeneous coordinate (w) is not to be touched
    here.
  '/
  sub float3.normalize()
    dim as float l = length()
    
    if( l > 0.0 ) then
      x /= l : y /= l : z /= l
    end if
  end sub
  
  function float3.unit() as float3
    dim as float _
      l = sqr( x ^ 2 + y ^ 2 + z ^ 2 )
    
    if( l > 0.0 ) then
      return( float3( x, y, z ) / l )
    else
      return( float3( x, y, z ) )
    end if 
  end function
  
  sub float3.homogeneize()
    x /= z: y /= z : z /= z
  end sub
  
  function float3.homogeneous() as float3
    return( float3( x / z, y / z, z / z ) )
  end function
  
  /'
    Returns the cross product (aka vectorial product) of this
    vector and another vector v.
  '/
  function float3.cross( _
    byref v as float3 ) as float3
    
    return( float3( _
      v.y * z - v.z * y, _
      v.z * x - v.x * z, _
      v.x * y - v.y * x ) )
  end function
  
  /'
    Returns the dot product (aka scalar product) of this
    vector and vector v.
  '/
  function float3.dot( _
    byref v as float3 ) as float
    
    return( v.x * x + v.y * y + v.z * z )
  end function
  
  /'
    Gets the distance of this vector with vector v
    To calculate the distance, substract them and
    calculate the length of the resultant vector.
  '/
  function float3.distance( _
    byref v as float3 ) as float
    
    return( sqr( ( v.x - x ) ^ 2 + ( v.y - y ) ^ 2 + ( v.z - z ) ^ 2 ) )
  end function
  
  /'
    Rotate vector v around arbitrary axis for angle radians
    
    It can only rotate around an axis through our object, to rotate
    around another axis: first translate the object to the axis, then
    use this function, then translate back in the new direction.
  '/
  function rotateAt( _
    byref v as float3, _
    byref anAxis as float3, _
    byval anAngle as Math.Radians ) as float3
    
    if( ( v.x = 0.0 ) andAlso ( v.y = 0.0 ) andAlso ( v.z = 0.0 ) ) then
      return float3( 0.0, 0.0, 0.0 )
    end if
    
    dim as float3 nAxis = float3( _
      anAxis.x, anAxis.y, anAxis.z )
    nAxis.normalize()
    
    '' Calculate parameters of the rotation matrix
    dim as float _
      c = cos( anAngle ), _
      s = sin( anAngle ), _
      t = 1.0 - c
    
    '' Multiply w with rotation matrix
    dim as float3 w
    
    w.x = ( t * nAxis.x * nAxis.x + c ) * v.x _
        + ( t * nAxis.x * nAxis.y + s * nAxis.z ) * v.y _
        + ( t * nAxis.x * nAxis.z - s * nAxis.y ) * v.z
      
    w.y = ( t * nAxis.x * nAxis.y - s * nAxis.z ) * v.x _
        + ( t * nAxis.y * nAxis.y + c ) * v.y _
        + ( t * nAxis.y * nAxis.z + s * nAxis.x ) * v.z
      
    w.z = ( t * nAxis.x * nAxis.z + s * nAxis.y ) * v.x _
        + ( t * nAxis.y * nAxis.z - s * nAxis.x ) * v.y _
        + ( t * nAxis.z * nAxis.z + c ) * v.z
    
    /'
      The vector has to retain its length, so it's normalized and
      multiplied with the original length.
    '/
    w.normalize()
    w = w * v.length()
    
    return( w )
  end function
  
  function _
    vMax overload( _
      byref p as Float3, _
      byval v as float ) _
    as Float3
    
    return( Float3( _
      fMax( p.x, v ), _
      fMax( p.y, v ), _
      fMax( p.z, v ) ) )
  end function
  
  function _
    vMin overload( _
      byref p as Float3, _
      byval v as float ) _
    as Float3
    
    return( Float3( _
      fMin( p.x, v ), _
      fMin( p.y, v ), _
      fMin( p.z, v ) ) )
  end function
end namespace

#endif
