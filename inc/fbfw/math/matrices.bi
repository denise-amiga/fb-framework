#ifndef __FBFW_MATH_MATRICES__
#define __FBFW_MATH_MATRICES__

namespace Math
  namespace Matrices
    '' Identities
    function _
      identity3() as mat3
      
      return( _
        mat3( _
          1.0, 0.0, 0.0, _
          0.0, 1.0, 0.0, _
          0.0, 0.0, 1.0 _
        ) _
      )
    end function
    
    function _
      identity4() as mat4
      
      return( _
        mat4( _
          1.0, 0.0, 0.0, 0.0, _
          0.0, 1.0, 0.0, 0.0, _
          0.0, 0.0, 1.0, 0.0, _
          0.0, 0.0, 0.0, 1.0 _
        ) _
      )
    end function
    
    '' Translation
    function _
      translation overload( _
        byref t as float2 ) _
      as mat3
      
      return( mat3( _
        1.0, 0.0, t.x, _
        0.0, 1.0, t.y, _
        0.0, 0.0, 1.0 ) )
    end function
    
    function _
      translation overload( _
        byref t as float3 ) _
      as mat4
      
      return( mat4( _
        1.0, 0.0, 0.0, t.x, _
        0.0, 1.0, 0.0, t.y, _
        0.0, 0.0, 1.0, t.z, _
        0.0, 0.0, 0.0, 1.0 ) )
    end function
    
    function _
      translation overload( _
        byref t as float4 ) _
      as mat4
      
      return( mat4( _
        1.0, 0.0, 0.0, t.x, _
        0.0, 1.0, 0.0, t.y, _
        0.0, 0.0, 1.0, t.z, _
        0.0, 0.0, 0.0, 1.0 ) )
    end function
    
    '' Scale transform about an arbitrary origin
    function _ 
      scaling overload( _
        byref s as float2, _
        byref so as float2 => _
          float2( 0.0, 0.0 ) ) _
      as mat3
      
      return( mat3( _
        s.x, 0.0, -so.x * s.x + so.x, _
        0.0, s.y, -so.y * s.y + so.y, _
        0.0, 0.0, 1.0 ) )
    end function
    
    /'
      Rotation transform. Supports rotation about any arbitrary
      origin. Angle is expected in degrees.
    '/
    function _
      rotation overload( _
        byval a as Math.float, _
        byref o as float2 => _
          float2( 0.0, 0.0 ) ) _
      as mat3
      
      dim as Math.float _
        c => cos( Math.toRadians( a ) ), _
        s => sin( Math.toRadians( a ) )
      
      return( mat3( _
        c, -s, -o.x * c + o.y * s + o.x, _
        s,  c, -o.x * s - o.y * c + o.y, _
        0.0, 0.0, 1.0 ) )
    end function
  end namespace
end namespace

#endif
