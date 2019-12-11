#ifndef __FBFW_MATH_UTILS__
#define __FBFW_MATH_UTILS__

namespace Math
  '' Returns the dot product between two vectors
  function _
    dot overload( _
      byref v as float2, _
      byref w as float2 ) _
    as float
    
    return( v.dot( w ) )
  end function
  
  function _
    dot( _
      byref v as float3, _
      byref w as float3 ) _
    as float
    
    return( v.dot( w ) )
  end function
  
  function _
    dot( _
      byref v as float4, _
      byref w as float4 ) _
    as float
    
    return( v.dot( w ) )
  end function
  
  /'
    The cross product is not defined in 2d, so this 
    function returns the z component of the cross product
    of this vector with vector v, if it were augmented to 3d.
  '/
  function _
    cross overload( _
      byref v as float2, _
      byref w as float2 ) _
    as float 
    
    return( v.cross( w ) )
  end function
  
  function _
    cross( _
      byref v as float3, _
      byref w as float3 ) _
    as float3
    
    return( v.cross( w ) )
  end function
  
  function _
    cross( _
      byref v as float4, _
      byref w as float4 ) _
    as float4
    
    return( v.cross( w ) )
  end function
  
  /'
    Returns the length of a vector.
    
    Note that the length() function for float4 doesn't take into
    account the w component, as they are intended to represent
    homogeneous coordinates in 3D space.
  '/
  function _
    length overload( _
      byref v as float2 ) _
    as float 
    
    return( sqr( v.x ^ 2 + v.y ^ 2 ) )
  end function
  
  function _
    length( _
      byref v as float3 ) _
    as float 
    
    return( sqr( v.x ^ 2 + v.y ^ 2 + v.z ^ 2 ) )
  end function

  function _
    length( _
      byref v as float4 ) _
    as float 
    
    return( sqr( v.x ^ 2 + v.y ^ 2 + v.z ^ 2 ) )
  end function
  
  /'
    Returns the squared length of a vector.
    
    Useful when one just want to compare two vectors to
    see which is longest, as this avoids computing the
    square root.
  '/
  function _
    squaredLength overload( _
      byref v as float2 ) _
    as float 
    
    return( v.x ^ 2 + v.y ^ 2 )
  end function
  
  function _
    squaredLength( _
      byref v as float3 ) _
    as float 
    
    return( v.x ^ 2 + v.y ^ 2 + v.z ^ 2 )
  end function
  
  function _
    squaredLength( _
      byref v as float4 ) _
    as float 
    
    return( v.x ^ 2 + v.y ^ 2 + v.z ^ 2 )
  end function
  
  '' Returns a normalized copy of vector v
  function _
    normalized overload( _
      byval v as float2 ) _
    as float2 
    
    v.normalize()
    return( v )
  end function
  
  function _
    normalized( _
      byval v as float3 ) _
    as float3
    
    v.normalize()
    return( v )
  end function
  
  function _
    normalized( _
      byval v as float4 ) _
    as float4
    
    v.normalize()
    return( v )
  end function
  
  /'
    Turns a 2D vector left or right, respectively. This has the
    same effect than rotating the vector 90 degrees but doesn't
    use trigonometry to do it.
    
    Extremely useful to find normals in 2D.
  '/
  function _
    turnedLeft( _
      byref v as float2 ) _
    as float2 
    
    return( float2( v.y, -v.x ) )
  end function
  
  function _
    turnedRight( _
      byref v as float2 ) _
    as float2 
    
    return( float2( -v.y, v.x ) )
  end function
  
  '' Returns the vector v, rotated by anAngle radians
  function _
    rotated overload( _
      byref v as float2, _
      byval anAngle as Math.radians ) _
    as float2
    
    dim as float _
      si => sin( anAngle ), _
      co => cos( anAngle )
    
    return( float2( _
      v.x * co - v.y * si, _
      v.x * si + v.y * co ) )
  end function
  
  /'
    Rotate vector v around arbitrary axis for angle radians
    
    It can only rotate around an axis through the origin.
    To rotate around another axis: first translate the object
    to the axis, then use this function, then translate back
    in the new direction.
  '/
  function _
    rotated( _
      byref v as float4, _
      byref anAxis as float4, _
      byval anAngle as Math.radians ) _
    as float4
    
    if( _
      ( v.x = 0.0 ) andAlso _
      ( v.y = 0.0 ) andAlso _
      ( v.z = 0.0 ) ) then
      
      return( _
        float4( 0.0, 0.0, 0.0 ) )
    end if
    
    dim as float4 _
      nAxis => float4( _
        anAxis.x, _
        anAxis.y, _
        anAxis.z, _
        1.0 )
      
    nAxis.normalize()
    
    '' Calculate parameters of the rotation matrix
    dim as float _
      c => cos( anAngle ), _
      s => sin( anAngle ), _
      t => 1.0 - c
    
    '' Multiply w with rotation matrix
    dim as float4 _
      w => float4( _
          ( t * nAxis.x * nAxis.x + c ) * v.x _  '' X
        + ( t * nAxis.x * nAxis.y + s * nAxis.z ) * v.y _
        + ( t * nAxis.x * nAxis.z - s * nAxis.y ) * v.z, _
          ( t * nAxis.x * nAxis.y - s * nAxis.z ) * v.x _
        + ( t * nAxis.y * nAxis.y + c ) * v.y _  '' Y
        + ( t * nAxis.y * nAxis.z + s * nAxis.x ) * v.z, _
          ( t * nAxis.x * nAxis.z + s * nAxis.y ) * v.x _
        + ( t * nAxis.y * nAxis.z - s * nAxis.x ) * v.y _
        + ( t * nAxis.z * nAxis.z + c ) * v.z, _ '' Z
        1.0 )
    
    /'
      The vector has to retain its length, so it's normalized and
      multiplied with the original length.
    '/
    w.normalize()
    w => w * v.length()
    
    return( w )
  end function
  
  '' Returns the angle that v vector points to, in radians
  function _
    vectorAngle overload( _
      byref v as float2 ) _
    as Math.radians
    
    return( atan2( v.y, v.x ) )
  end function
  
  /'
    Returns the angle between two vectors using the dot product, in
    radians.
    
    Note that the result of the dot product used here should,
    mathematically speaking, always give a result between -1 and 1.
    Due to imprecisions of numerical calculations it might sometimes
    be a little bit outside this range however (especially if you define
    Scalar to be float instead of float). If that happens, the acos
    function will give an invalid result. So instead a protection was
    added that sets the value back to 1 or -1 (because, if the value
    became 1.0000023 for example, it was probably supposed to be 1
    anyway).
  '/
  function _
    vectorAngle( _
      byval v as float2, _
      byval w as float2 ) _
    as Math.radians
    
    dim as float _
      angleCos => _
        dot( v.unit(), w.unit() )
      
    return( -acos( fClamp( -1.0, 1.0, angleCos ) ) )
  end function
  
  function _
    vectorAngle( _
      byval v as float3, _
      byval w as float3 ) _
    as Math.radians
    
    dim as float _
      angleCos => _
        dot( v.unit(), w.unit() )
      
    return( -acos( fClamp( -1.0, 1.0, angleCos ) ) )
  end function
  
  function _
    vectorAngle( _
      byval v as float4, _
      byval w as float4 ) _
    as Math.radians
    
    dim as float _
      angleCos => _
        dot( v.unit(), w.unit() )
      
    return( -acos( fClamp( -1.0, 1.0, angleCos ) ) )
  end function
  
  '' Returns the squared distance between two vectors
  function _
    squaredDistance overload( _
      byref a as const float2, _
      byref b as const float2 ) _
    as float
    
    return( float2( _
      a.x - b.x, _
      a.y - b.y ).squaredLength() )
  end function
  
  function _
    squaredDistance( _
      byref a as const float3, _
      byref b as const float3 ) _
    as float
    
    return( float3( _
      a.x - b.x, _
      a.y - b.y, _
      a.z - b.z ).squaredLength() )
  end function
  
  /'
    Note that this one doesn't touch the w component of the
    4 tuple vector. This is because these vectors are usually
    used as homogeneous 3D coordinates, and changing that
    coordinate will screw all perspective calculations, for
    example.
  '/
  function _
    squaredDistance( _
      byref a as const float4, _
      byref b as const float4 ) _
    as float
    
    return( float3( _
      a.x - b.x, _
      a.y - b.y, _
      a.z - b.z ).squaredLength() )
  end function
  
  '' Returns the distance between two vectors
  function _
    distance overload( _
      byref v as float2, _
      byref w as float2 ) _
    as float
    
    return( float2( _
      v.x - w.x, _
      v.y - w.y ).length )
  end function
  
  function _
    distance( _
      byref v as float3, _
      byref w as float3 ) _
    as float
    
    return( float3( _
      v.x - w.x, _
      v.y - w.y, _
      v.z - w.z ).length )
  end function
  
  function _
    distance( _
      byref v as float4, _
      byref w as float4 ) _
    as float
    
    return( float4( _
      v.x - w.x, _
      v.y - w.y, _
      v.z - w.z ).length )
  end function
  
  /'
    Returns a vector aligned between position and position + size.
  '/
  function _
    alignment overload( _
      byref aPosition as float2, _
      byref aSize as float2, _
      byref anAlignment as float2 ) _
    as float2
    
    return( _
      aPosition + aSize * normalized( anAlignment ) )
  end function
  
  function _
    alignment( _
      byref aPosition as float3, _
      byref aSize as float3, _
      byref anAlignment as float3 ) _
    as float3
    
    return( _
      aPosition + aSize * normalized( anAlignment ) )
  end function
  
  function _
    alignment( _
      byref aPosition as float4, _
      byref aSize as float4, _
      byref anAlignment as float4 ) _
    as float4
    
    return( _
      aPosition + aSize * normalized( anAlignment ) )
  end function
end namespace

#endif
