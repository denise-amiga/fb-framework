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
  type Float3
    public:
      declare constructor()
      declare constructor( _
        byval as float => 0.0, _
        byval as float => 0.0, _
        byval as float => 0.0 )
      declare constructor( _
        byref as Float2, _
        byval as float => 0.0 )
      declare constructor( _
        byval as float => 0.0, _
        byref as Float2 )
      declare constructor( _
        byref rhs as Float3 )
      declare operator let( _
        byref rhs as Float3 )
      
      declare operator cast() as string
      
      '' Swizzlings
      declare function xx() as Float2
      declare function yx() as Float2
      declare function zx() as Float2
      declare function xy() as Float2
      declare function yy() as Float2
      declare function zy() as Float2
      declare function xz() as Float2
      declare function yz() as Float2
      declare function zz() as Float2
      declare function xxx() as Float3
      declare function yxx() as Float3
      declare function zxx() as Float3
      declare function xyx() as Float3
      declare function yyx() as Float3
      declare function zyx() as Float3
      declare function xzx() as Float3
      declare function yzx() as Float3
      declare function zzx() as Float3
      declare function xxy() as Float3
      declare function yxy() as Float3
      declare function zxy() as Float3
      declare function xyy() as Float3
      declare function yyy() as Float3
      declare function zyy() as Float3
      declare function xzy() as Float3
      declare function yzy() as Float3
      declare function zzy() as Float3
      declare function xxz() as Float3
      declare function yxz() as Float3
      declare function zxz() as Float3
      declare function yyz() as Float3
      declare function zyz() as Float3
      declare function xzz() as Float3
      declare function yzz() as Float3
      declare function zzz() as Float3
      
      '' Convenience functions
      declare function length() as float
      declare function squaredLength() as float
      declare sub normalize()
      declare function normalized() as Float3
      declare sub homogeneize()
      declare function homogeneous() as Float3
      declare function cross( _
        byref v as Float3 ) as Float3
      declare function dot( _
        byref v as Float3 ) as float
      declare function distance( _
        byref v as Float3 ) as float
      declare function _
        squaredDistance( _
          byref as Float3 ) as float
        
      as float _
        x, y, z
  end type
  
  constructor Float3()
    x => 0.0
    y => 0.0
    z => 0.0
  end constructor
  
  constructor Float3( _
    byval nx as float => 0.0, _
    byval ny as float => 0.0, _
    byval nz as float => 0.0 )
    
    x => nx
    y => ny
    z => nz
  end constructor
  
  constructor Float3( _
    byref aVector as Float2, _
    byval nz as float => 0.0 )
    
    x => aVector.x
    y => aVector.y
    z => nz
  end constructor
  
  constructor Float3( _
    byval nx as float, _
    byref aVector as Float2 )
    
    x => nx
    y => aVector.x
    z => aVector.y
  end constructor
  
  '' Copy constructor
  constructor Float3( _
    byref rhs as Float3 )
    x => rhs.x
    y => rhs.y
    z => rhs.z
  end constructor
  
  operator Float3.let( _
    byref rhs as Float3 )
    
    x => rhs.x
    y => rhs.y
    z => rhs.z
  end operator
  
  '' Human readable string representation (useful for debugging)
  operator Float3.cast() as string
    return( _
      "| " & trim( str( x ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( y ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( z ) ) & " |" & chr( 13 ) & chr( 10 ) )
  end operator
  
  function Float3.xx() as Float2
    return( Float2( x, x ) )
  end function
  
  function Float3.yx() as Float2
    return( Float2( y, x ) )
  end function
  
  function Float3.zx() as Float2
    return( Float2( z, x ) )
  end function
  
  function Float3.xy() as Float2
    return( Float2( x, y ) )
  end function
  
  function Float3.yy() as Float2
    return( Float2( y, y ) )
  end function
  
  function Float3.zy() as Float2
    return( Float2( z, y ) )
  end function
  
  function Float3.xz() as Float2
    return( Float2( x, z ) )
  end function
  
  function Float3.yz() as Float2
    return( Float2( y, z ) )
  end function
  
  function Float3.zz() as Float2
    return( Float2( z, z ) )
  end function
  
  function Float3.xxx() as Float3
    return( Float3( x, x, x ) )
  end function
  
  function Float3.yxx() as Float3
    return( Float3( y, x, x ) )
  end function
  
  function Float3.zxx() as Float3
    return( Float3( z, x, x ) )
  end function
  
  function Float3.xyx() as Float3
    return( Float3( x, y, x ) )
  end function
  
  function Float3.yyx() as Float3
    return( Float3( y, y, x ) )
  end function
  
  function Float3.zyx() as Float3
    return( Float3( z, y, x ) )
  end function
  
  function Float3.xzx() as Float3
    return( Float3( x, z, x ) )
  end function
  
  function Float3.yzx() as Float3
    return( Float3( y, z, x ) )
  end function
  
  function Float3.zzx() as Float3
    return( Float3( z, z, x ) )
  end function
  
  function Float3.xxy() as Float3
    return( Float3( x, x, y ) )
  end function
  
  function Float3.yxy() as Float3
    return( Float3( y, x, y ) )
  end function
  
  function Float3.zxy() as Float3
    return( Float3( z, x, y ) )
  end function
  
  function Float3.xyy() as Float3
    return( Float3( x, y, y ) )
  end function
  
  function Float3.yyy() as Float3
    return( Float3( y, y, y ) )
  end function
  
  function Float3.zyy() as Float3
    return( Float3( z, y, y ) )
  end function
  
  function Float3.xzy() as Float3
    return( Float3( x, z, y ) )
  end function
  
  function Float3.yzy() as Float3
    return( Float3( y, z, y ) )
  end function
  
  function Float3.zzy() as Float3
    return( Float3( z, z, y ) )
  end function
  
  function Float3.xxz() as Float3
    return( Float3( x, x, z ) )
  end function
  
  function Float3.yxz() as Float3
    return( Float3( y, x, z ) )
  end function
  
  function Float3.zxz() as Float3
    return( Float3( z, x, z ) )
  end function
  
  function Float3.yyz() as Float3
    return( Float3( y, y, z ) )
  end function
  
  function Float3.zyz() as Float3
    return( Float3( z, y, z ) )
  end function
  
  function Float3.xzz() as Float3
    return( Float3( x, z, z ) )
  end function
  
  function Float3.yzz() as Float3
    return( Float3( y, z, z ) )
  end function
  
  function Float3.zzz() as Float3
    return( Float3( z, z, z ) )
  end function
  
  operator _
    = ( _
      byref lhs as Float3, _
      byref rhs as Float3 ) _
    as integer
    
    return( _
      lhs.x = rhs.x andAlso _
      lhs.y = rhs.y andAlso _
      lhs.z = rhs.z )
  end operator
  
  operator _
    <> ( _
      byref lhs as Float3, _
      byref rhs as Float3 ) _
    as integer
    
    return( _
      lhs.x <> rhs.x orElse _
      lhs.y <> rhs.y orElse _
      lhs.z <> rhs.z )
  end operator
  
  '' Substraction operator
  operator - ( _
    byref v as Float3, byref w as Float3 ) as Float3
    
    return( Float3( v.x - w.x, v.y - w.y, v.z - w.z ) )
  end operator
  
  '' Negation operator
  operator - ( _
    byref v as Float3 ) as Float3
    
    return( Float3( -v.x, -v.y, -v.z ) )
  end operator
  
  operator + ( _
    byref v as Float3, byref w as Float3 ) as Float3
    
    return( Float3( v.x + w.x, v.y + w.y, v.z + w.z ) )
  end operator
  
  operator _
    * ( _
      byref v as Float3, _
      byref w as Float3 ) _
    as Float3
    
    return( Float3( _
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
    byref v as Float3, byref s as float ) as Float3
    
    return( Float3( v.x * s, v.y * s, v.z * s ) )
  end operator
  
  '' Same as above but with the parameters inversed
  operator * ( _
    byref s as float, byref v as Float3 ) as Float3
    return( Float3( v.x * s, v.y * s, v.z * s ) )
  end operator
  
  '' Division by a scalar. See note above on multiplying a vector
  operator / ( _
    byref v as Float3, byref s as float ) as Float3
    return( Float3( v.x / s, v.y / s, v.z / s ) )
  end operator
  
  '' Division by another vector
  operator / ( _
    byref v as Float3, byref w as Float3 ) as Float3
    
    return( Float3( v.x / w.x, v.y / w.y, v.z / w.z ) )
  end operator

  /'
    Returns the squared length of this vector
    
    Useful when you just want to compare which one is bigger,
    as this avoids having to compute a square root.
  '/
  function Float3.squaredLength() as float
    return( x ^ 2 + y ^ 2 + z ^ 2 )
  end function
  
  '' Returns the length of this vector
  function Float3.length() as float
    return( sqr( x ^ 2 + y ^ 2 + z ^ 2 ) )
  end function
  
  /'
    Normalizes the vector.
    
    Note that the homogeneous coordinate (w) is not to be touched
    here.
  '/
  sub Float3.normalize()
    dim as float _
      l => length()
    
    if( l > 0.0 ) then
      x /=> l : y /=> l : z /=> l
    end if
  end sub
  
  function Float3.normalized() as Float3
    dim as float _
      l => sqr( x ^ 2 + y ^ 2 + z ^ 2 )
    
    if( l > 0.0 ) then
      return( Float3( x, y, z ) / l )
    else
      return( Float3( x, y, z ) )
    end if 
  end function
  
  sub Float3.homogeneize()
    x /=> z: y /=> z : z /=> z
  end sub
  
  function Float3.homogeneous() as Float3
    return( Float3( x / z, y / z, z / z ) )
  end function
  
  /'
    Returns the cross product (aka vectorial product) of this
    vector and another vector v.
  '/
  function Float3.cross( _
    byref v as Float3 ) as Float3
    
    return( Float3( _
      v.y * z - v.z * y, _
      v.z * x - v.x * z, _
      v.x * y - v.y * x ) )
  end function
  
  /'
    Returns the dot product (aka scalar product) of this
    vector and vector v.
  '/
  function Float3.dot( _
    byref v as Float3 ) as float
    
    return( v.x * x + v.y * y + v.z * z )
  end function
  
  /'
    Gets the distance of this vector with vector v
    To calculate the distance, substract them and
    calculate the length of the resultant vector.
  '/
  function Float3.distance( _
    byref v as Float3 ) as float
    
    return( sqr( _
      ( v.x - x ) ^ 2 + _
      ( v.y - y ) ^ 2 + _
      ( v.z - z ) ^ 2 ) )
  end function
  
  /'
    Gets the squared distance of this vector with
    vector v. Useful when you need to just compare
    distances.
  '/
  function _
    Float3.squaredDistance( _
      byref v as Float3 ) _
    as float
    
    return( _
      ( v.x - x ) ^ 2 + _
      ( v.y - y ) ^ 2 + _
      ( v.z - z ) ^ 2 )
  end function
  
  /'
    Rotate vector v around arbitrary axis for angle radians
    
    It can only rotate around an axis through our object, to rotate
    around another axis: first translate the object to the axis, then
    use this function, then translate back in the new direction.
  '/
  function rotateAt( _
    byref v as Float3, _
    byref anAxis as Float3, _
    byval anAngle as Math.Radians ) as Float3
    
    if( _
      ( v.x = 0.0 ) andAlso _
      ( v.y = 0.0 ) andAlso _
      ( v.z = 0.0 ) ) then
      
      return Float3( 0.0, 0.0, 0.0 )
    end if
    
    dim as Float3 _
      nAxis => anAxis.normalized()
    
    '' Calculate parameters of the rotation matrix
    dim as float _
      c => cos( anAngle ), _
      s => sin( anAngle ), _
      t => 1.0 - c
    
    '' Multiply w with rotation matrix
    dim as Float3 w
    
    w.x => ( t * nAxis.x * nAxis.x + c ) * v.x _
        + ( t * nAxis.x * nAxis.y + s * nAxis.z ) * v.y _
        + ( t * nAxis.x * nAxis.z - s * nAxis.y ) * v.z
      
    w.y => ( t * nAxis.x * nAxis.y - s * nAxis.z ) * v.x _
        + ( t * nAxis.y * nAxis.y + c ) * v.y _
        + ( t * nAxis.y * nAxis.z + s * nAxis.x ) * v.z
      
    w.z => ( t * nAxis.x * nAxis.z + s * nAxis.y ) * v.x _
        + ( t * nAxis.y * nAxis.z - s * nAxis.x ) * v.y _
        + ( t * nAxis.z * nAxis.z + c ) * v.z
    
    /'
      The vector has to retain its length, so it's normalized and
      multiplied with the original length.
    '/
    w.normalize()
    w => w * v.length()
    
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
