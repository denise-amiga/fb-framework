#ifndef __FBFW_MATH_FLOAT4__
#define __FBFW_MATH_FLOAT4__

namespace Math
  /'
    4D vector type
    
    It is meant to be used as an homogeneous 3D vector (like the ones
    used by OpenGL or Direct3D).
    
    Conceptually, they are to be interpreted like this:
    
    | x |
    | y |
    | z |
    | w |
    
    where w = 1.0 for an homogeneous column vector.
    
    10/29/2019
      Removed swizzlings for RGBA color components
    
    10/7/2017
      Fixed a typo in the + operator
  '/  
  type float4
    public:
      declare constructor()
      declare constructor( _
        byval as float = 0.0, _
        byval as float = 0.0, _
        byval as float = 0.0, _
        byval as float = 0.0 )
      declare constructor( _
        byref as float3, _
        byval as float = 0.0 )
      declare constructor( _
        byval as float = 0.0, _
        byref as float3 )
      declare constructor( _
        byref as float2, _
        byref as float2 )
      declare constructor( _
        byval as float, _
        byref as float2, _
        byval as float )
      declare constructor( _
        byval as float, _
        byval as float, _
        byref as float2 )
      declare constructor( _
        byref as float2, _
        byval as float, _
        byval as float )
      declare constructor( _
        byref rhs as float4 )
      declare operator let( _
        byref rhs as float4 )
      
      declare operator cast() as string
      
      '' Swizzlings
      declare function xx() as float2
      declare function yx() as float2
      declare function zx() as float2
      declare function wx() as float2
      declare function xy() as float2
      declare function yy() as float2
      declare function zy() as float2
      declare function wy() as float2
      declare function xz() as float2
      declare function yz() as float2
      declare function zz() as float2
      declare function wz() as float2
      declare function xw() as float2
      declare function yw() as float2
      declare function zw() as float2
      declare function ww() as float2
      
      declare function xxx() as float3
      declare function yxx() as float3
      declare function zxx() as float3
      declare function wxx() as float3
      declare function xyx() as float3
      declare function yyx() as float3
      declare function zyx() as float3
      declare function wyx() as float3
      declare function xzx() as float3
      declare function yzx() as float3
      declare function zzx() as float3
      declare function wzx() as float3
      declare function xwx() as float3
      declare function ywx() as float3
      declare function zwx() as float3
      declare function wwx() as float3
      declare function xxy() as float3
      declare function yxy() as float3
      declare function zxy() as float3
      declare function wxy() as float3
      declare function xyy() as float3
      declare function yyy() as float3
      declare function zyy() as float3
      declare function wyy() as float3
      declare function xzy() as float3
      declare function yzy() as float3
      declare function zzy() as float3
      declare function wzy() as float3
      declare function xwy() as float3
      declare function ywy() as float3
      declare function zwy() as float3
      declare function wwy() as float3
      declare function xxz() as float3
      declare function yxz() as float3
      declare function zxz() as float3
      declare function wxz() as float3
      declare function xyz() as float3
      declare function yyz() as float3
      declare function zyz() as float3
      declare function wyz() as float3
      declare function xzz() as float3
      declare function yzz() as float3
      declare function zzz() as float3
      declare function wzz() as float3
      declare function xwz() as float3
      declare function ywz() as float3
      declare function zwz() as float3
      declare function wwz() as float3
      declare function xxw() as float3
      declare function yxw() as float3
      declare function zxw() as float3
      declare function wxw() as float3
      declare function xyw() as float3
      declare function yyw() as float3
      declare function zyw() as float3
      declare function wyw() as float3
      declare function xzw() as float3
      declare function yzw() as float3
      declare function zzw() as float3
      declare function wzw() as float3
      declare function xww() as float3
      declare function yww() as float3
      declare function zww() as float3
      declare function www() as float3
      
      declare function xxxx() as float4
      declare function yxxx() as float4
      declare function zxxx() as float4
      declare function wxxx() as float4
      declare function xyxx() as float4
      declare function yyxx() as float4
      declare function zyxx() as float4
      declare function wyxx() as float4
      declare function xzxx() as float4
      declare function yzxx() as float4
      declare function zzxx() as float4
      declare function wzxx() as float4
      declare function xwxx() as float4
      declare function ywxx() as float4
      declare function zwxx() as float4
      declare function wwxx() as float4
      declare function xxyx() as float4
      declare function yxyx() as float4
      declare function zxyx() as float4
      declare function wxyx() as float4
      declare function xyyx() as float4
      declare function yyyx() as float4
      declare function zyyx() as float4
      declare function wyyx() as float4
      declare function xzyx() as float4
      declare function yzyx() as float4
      declare function zzyx() as float4
      declare function wzyx() as float4
      declare function xwyx() as float4
      declare function ywyx() as float4
      declare function zwyx() as float4
      declare function wwyx() as float4
      declare function xxzx() as float4
      declare function yxzx() as float4
      declare function zxzx() as float4
      declare function wxzx() as float4
      declare function xyzx() as float4
      declare function yyzx() as float4
      declare function zyzx() as float4
      declare function wyzx() as float4
      declare function xzzx() as float4
      declare function yzzx() as float4
      declare function zzzx() as float4
      declare function wzzx() as float4
      declare function xwzx() as float4
      declare function ywzx() as float4
      declare function zwzx() as float4
      declare function wwzx() as float4
      declare function xxwx() as float4
      declare function yxwx() as float4
      declare function zxwx() as float4
      declare function wxwx() as float4
      declare function xywx() as float4
      declare function yywx() as float4
      declare function zywx() as float4
      declare function wywx() as float4
      declare function xzwx() as float4
      declare function yzwx() as float4
      declare function zzwx() as float4
      declare function wzwx() as float4
      declare function xwwx() as float4
      declare function ywwx() as float4
      declare function zwwx() as float4
      declare function wwwx() as float4
      declare function xxxy() as float4
      declare function yxxy() as float4
      declare function zxxy() as float4
      declare function wxxy() as float4
      declare function xyxy() as float4
      declare function yyxy() as float4
      declare function zyxy() as float4
      declare function wyxy() as float4
      declare function xzxy() as float4
      declare function yzxy() as float4
      declare function zzxy() as float4
      declare function wzxy() as float4
      declare function xwxy() as float4
      declare function ywxy() as float4
      declare function zwxy() as float4
      declare function wwxy() as float4
      declare function xxyy() as float4
      declare function yxyy() as float4
      declare function zxyy() as float4
      declare function wxyy() as float4
      declare function xyyy() as float4
      declare function yyyy() as float4
      declare function zyyy() as float4
      declare function wyyy() as float4
      declare function xzyy() as float4
      declare function yzyy() as float4
      declare function zzyy() as float4
      declare function wzyy() as float4
      declare function xwyy() as float4
      declare function ywyy() as float4
      declare function zwyy() as float4
      declare function wwyy() as float4
      declare function xxzy() as float4
      declare function yxzy() as float4
      declare function zxzy() as float4
      declare function wxzy() as float4
      declare function xyzy() as float4
      declare function yyzy() as float4
      declare function zyzy() as float4
      declare function wyzy() as float4
      declare function xzzy() as float4
      declare function yzzy() as float4
      declare function zzzy() as float4
      declare function wzzy() as float4
      declare function xwzy() as float4
      declare function ywzy() as float4
      declare function zwzy() as float4
      declare function wwzy() as float4
      declare function xxwy() as float4
      declare function yxwy() as float4
      declare function zxwy() as float4
      declare function wxwy() as float4
      declare function xywy() as float4
      declare function yywy() as float4
      declare function zywy() as float4
      declare function wywy() as float4
      declare function xzwy() as float4
      declare function yzwy() as float4
      declare function zzwy() as float4
      declare function wzwy() as float4
      declare function xwwy() as float4
      declare function ywwy() as float4
      declare function zwwy() as float4
      declare function wwwy() as float4
      declare function xxxz() as float4
      declare function yxxz() as float4
      declare function zxxz() as float4
      declare function wxxz() as float4
      declare function xyxz() as float4
      declare function yyxz() as float4
      declare function zyxz() as float4
      declare function wyxz() as float4
      declare function xzxz() as float4
      declare function yzxz() as float4
      declare function zzxz() as float4
      declare function wzxz() as float4
      declare function xwxz() as float4
      declare function ywxz() as float4
      declare function zwxz() as float4
      declare function wwxz() as float4
      declare function xxyz() as float4
      declare function yxyz() as float4
      declare function zxyz() as float4
      declare function wxyz() as float4
      declare function xyyz() as float4
      declare function yyyz() as float4
      declare function zyyz() as float4
      declare function wyyz() as float4
      declare function xzyz() as float4
      declare function yzyz() as float4
      declare function zzyz() as float4
      declare function wzyz() as float4
      declare function xwyz() as float4
      declare function ywyz() as float4
      declare function zwyz() as float4
      declare function wwyz() as float4
      declare function xxzz() as float4
      declare function yxzz() as float4
      declare function zxzz() as float4
      declare function wxzz() as float4
      declare function xyzz() as float4
      declare function yyzz() as float4
      declare function zyzz() as float4
      declare function wyzz() as float4
      declare function xzzz() as float4
      declare function yzzz() as float4
      declare function zzzz() as float4
      declare function wzzz() as float4
      declare function xwzz() as float4
      declare function ywzz() as float4
      declare function zwzz() as float4
      declare function wwzz() as float4
      declare function xxwz() as float4
      declare function yxwz() as float4
      declare function zxwz() as float4
      declare function wxwz() as float4
      declare function xywz() as float4
      declare function yywz() as float4
      declare function zywz() as float4
      declare function wywz() as float4
      declare function xzwz() as float4
      declare function yzwz() as float4
      declare function zzwz() as float4
      declare function wzwz() as float4
      declare function xwwz() as float4
      declare function ywwz() as float4
      declare function zwwz() as float4
      declare function wwwz() as float4
      declare function xxxw() as float4
      declare function yxxw() as float4
      declare function zxxw() as float4
      declare function wxxw() as float4
      declare function xyxw() as float4
      declare function yyxw() as float4
      declare function zyxw() as float4
      declare function wyxw() as float4
      declare function xzxw() as float4
      declare function yzxw() as float4
      declare function zzxw() as float4
      declare function wzxw() as float4
      declare function xwxw() as float4
      declare function ywxw() as float4
      declare function zwxw() as float4
      declare function wwxw() as float4
      declare function xxyw() as float4
      declare function yxyw() as float4
      declare function zxyw() as float4
      declare function wxyw() as float4
      declare function xyyw() as float4
      declare function yyyw() as float4
      declare function zyyw() as float4
      declare function wyyw() as float4
      declare function xzyw() as float4
      declare function yzyw() as float4
      declare function zzyw() as float4
      declare function wzyw() as float4
      declare function xwyw() as float4
      declare function ywyw() as float4
      declare function zwyw() as float4
      declare function wwyw() as float4
      declare function xxzw() as float4
      declare function yxzw() as float4
      declare function zxzw() as float4
      declare function wxzw() as float4
      declare function yyzw() as float4
      declare function zyzw() as float4
      declare function wyzw() as float4
      declare function xzzw() as float4
      declare function yzzw() as float4
      declare function zzzw() as float4
      declare function wzzw() as float4
      declare function xwzw() as float4
      declare function ywzw() as float4
      declare function zwzw() as float4
      declare function wwzw() as float4
      declare function xxww() as float4
      declare function yxww() as float4
      declare function zxww() as float4
      declare function wxww() as float4
      declare function xyww() as float4
      declare function yyww() as float4
      declare function zyww() as float4
      declare function wyww() as float4
      declare function xzww() as float4
      declare function yzww() as float4
      declare function zzww() as float4
      declare function wzww() as float4
      declare function xwww() as float4
      declare function ywww() as float4
      declare function zwww() as float4
      declare function wwww() as float4
      
      '' Convenience methods
      declare function length() as float
      declare function squaredLength() as float
      declare sub normalize()
      declare function unit() as float4
      declare sub homogeneize()
      declare function homogeneous() as float4
      declare function cross( _
        byref as float4 ) as float4
      declare function dot( _
        byref as float4 ) as float
      declare function distance( _
        byref as float4 ) as float
      
      as float _
        x, y, z, w
  end type
  
  constructor float4()
  end constructor
  
  constructor float4( _
    byval nx as float = 0.0, _
    byval ny as float = 0.0, _
    byval nz as float = 0.0, _
    byval nw as float = 0.0 )
    
    x = nx
    y = ny
    z = nz
    w = nw
  end constructor
  
  constructor float4( _
    byref aFloat3 as float3, _
    byval nw as float = 0.0 )
    
    x = aFloat3.x
    y = aFloat3.y
    z = aFloat3.z
    w = nw
  end constructor
  
  constructor float4( _
    byval nx as float = 0.0, _
    byref aFloat3 as float3 )
    
    x = nx
    y = aFloat3.x
    z = aFloat3.y
    w = aFloat3.z
  end constructor
  
  constructor float4( _
    byref aFloat2_1 as float2, _
    byref aFloat2_2 as float2 )
    
    x = aFloat2_1.x
    y = aFloat2_1.y
    z = aFloat2_2.x
    w = aFloat2_2.y
  end constructor
  
  constructor float4( _
    byval aFloat_1 as float, _
    byref aFloat2 as float2, _
    byval aFloat_2 as float )
    
    x = aFloat_1
    y = aFloat2.x
    z = aFloat2.y
    w = aFloat_2
  end constructor
  
  constructor float4( _
    byval aFloat_1 as float, _
    byval aFloat_2 as float, _
    byref aFloat2 as float2 )
    
    x = aFloat_1
    y = aFloat_2
    z = aFloat2.x
    w = aFloat2.y
  end constructor
  
  constructor float4( _
    byref aFloat2 as float2, _
    byval aFloat_1 as float, _
    byval aFloat_2 as float )
    
    x = aFloat2.x
    y = aFloat2.y
    z = aFloat_1
    w = aFloat_2
  end constructor
  
  constructor float4( _
    byref rhs as float4 )
    '' Copy constructor
    x = rhs.x
    y = rhs.y
    z = rhs.z
    w = rhs.w
  end constructor
  
  operator float4.let( _
    byref rhs as float4 )
    
    x = rhs.x
    y = rhs.y
    z = rhs.z
    w = rhs.w
  end operator
  
  operator float4.cast() as string
    '' Human readable string representation (useful for debugging)
    return( _
      "| " & trim( str( x ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( y ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( z ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( w ) ) & " |" & chr( 13 ) & chr( 10 ) )
  end operator
  
  function float4.xx() as float2
    return( float2( x, x ) )
  end function
  
  function float4.yx() as float2
    return( float2( y, x ) )
  end function
  
  function float4.zx() as float2
    return( float2( z, x ) )
  end function
  
  function float4.wx() as float2
    return( float2( w, x ) )
  end function
  
  function float4.xy() as float2
    return( float2( x, y ) )
  end function
  
  function float4.yy() as float2
    return( float2( y, y ) )
  end function
  
  function float4.zy() as float2
    return( float2( z, y ) )
  end function
  
  function float4.wy() as float2
    return( float2( w, y ) )
  end function
  
  function float4.xz() as float2
    return( float2( x, z ) )
  end function
  
  function float4.yz() as float2
    return( float2( y, z ) )
  end function
  
  function float4.zz() as float2
    return( float2( z, z ) )
  end function
  
  function float4.wz() as float2
    return( float2( w, z ) )
  end function
  
  function float4.xw() as float2
    return( float2( x, w ) )
  end function
  
  function float4.yw() as float2
    return( float2( y, w ) )
  end function
  
  function float4.zw() as float2
    return( float2( z, w ) )
  end function
  
  function float4.ww() as float2
    return( float2( w, w ) )
  end function
  
  function float4.xxx() as float3
    return( float3( x, x, x ) )
  end function
  
  function float4.yxx() as float3
    return( float3( y, x, x ) )
  end function
  
  function float4.zxx() as float3
    return( float3( z, x, x ) )
  end function
  
  function float4.wxx() as float3
    return( float3( w, x, x ) )
  end function
  
  function float4.xyx() as float3
    return( float3( x, y, x ) )
  end function
  
  function float4.yyx() as float3
    return( float3( y, y, x ) )
  end function
  
  function float4.zyx() as float3
    return( float3( z, y, x ) )
  end function
  
  function float4.wyx() as float3
    return( float3( w, y, x ) )
  end function
  
  function float4.xzx() as float3
    return( float3( x, z, x ) )
  end function
  
  function float4.yzx() as float3
    return( float3( y, z, x ) )
  end function
  
  function float4.zzx() as float3
    return( float3( z, z, x ) )
  end function
  
  function float4.wzx() as float3
    return( float3( w, z, x ) )
  end function
  
  function float4.xwx() as float3
    return( float3( x, w, x ) )
  end function
  
  function float4.ywx() as float3
    return( float3( y, w, x ) )
  end function
  
  function float4.zwx() as float3
    return( float3( z, w, x ) )
  end function
  
  function float4.wwx() as float3
    return( float3( w, w, x ) )
  end function
  
  function float4.xxy() as float3
    return( float3( x, x, y ) )
  end function
  
  function float4.yxy() as float3
    return( float3( y, x, y ) )
  end function
  
  function float4.zxy() as float3
    return( float3( z, x, y ) )
  end function
  
  function float4.wxy() as float3
    return( float3( w, x, y ) )
  end function
  
  function float4.xyy() as float3
    return( float3( x, y, y ) )
  end function
  
  function float4.yyy() as float3
    return( float3( y, y, y ) )
  end function
  
  function float4.zyy() as float3
    return( float3( z, y, y ) )
  end function
  
  function float4.wyy() as float3
    return( float3( w, y, y ) )
  end function
  
  function float4.xzy() as float3
    return( float3( x, z, y ) )
  end function
  
  function float4.yzy() as float3
    return( float3( y, z, y ) )
  end function
  
  function float4.zzy() as float3
    return( float3( z, z, y ) )
  end function
  
  function float4.wzy() as float3
    return( float3( w, z, y ) )
  end function
  
  function float4.xwy() as float3
    return( float3( x, w, y ) )
  end function
  
  function float4.ywy() as float3
    return( float3( y, w, y ) )
  end function
  
  function float4.zwy() as float3
    return( float3( z, w, y ) )
  end function
  
  function float4.wwy() as float3
    return( float3( w, w, y ) )
  end function
  
  function float4.xxz() as float3
    return( float3( x, x, z ) )
  end function
  
  function float4.yxz() as float3
    return( float3( y, x, z ) )
  end function
  
  function float4.zxz() as float3
    return( float3( z, x, z ) )
  end function
  
  function float4.wxz() as float3
    return( float3( w, x, z ) )
  end function
  
  function float4.xyz() as float3
    return( float3( x, y, z ) )
  end function
  
  function float4.yyz() as float3
    return( float3( y, y, z ) )
  end function
  
  function float4.zyz() as float3
    return( float3( z, y, z ) )
  end function
  
  function float4.wyz() as float3
    return( float3( w, y, z ) )
  end function
  
  function float4.xzz() as float3
    return( float3( x, z, z ) )
  end function
  
  function float4.yzz() as float3
    return( float3( y, z, z ) )
  end function
  
  function float4.zzz() as float3
    return( float3( z, z, z ) )
  end function
  
  function float4.wzz() as float3
    return( float3( w, z, z ) )
  end function
  
  function float4.xwz() as float3
    return( float3( x, w, z ) )
  end function
  
  function float4.ywz() as float3
    return( float3( y, w, z ) )
  end function
  
  function float4.zwz() as float3
    return( float3( z, w, z ) )
  end function
  
  function float4.wwz() as float3
    return( float3( w, w, z ) )
  end function
  
  function float4.xxw() as float3
    return( float3( x, x, w ) )
  end function
  
  function float4.yxw() as float3
    return( float3( y, x, w ) )
  end function
  
  function float4.zxw() as float3
    return( float3( z, x, w ) )
  end function
  
  function float4.wxw() as float3
    return( float3( w, x, w ) )
  end function
  
  function float4.xyw() as float3
    return( float3( x, y, w ) )
  end function
  
  function float4.yyw() as float3
    return( float3( y, y, w ) )
  end function
  
  function float4.zyw() as float3
    return( float3( z, y, w ) )
  end function
  
  function float4.wyw() as float3
    return( float3( w, y, w ) )
  end function
  
  function float4.xzw() as float3
    return( float3( x, z, w ) )
  end function
  
  function float4.yzw() as float3
    return( float3( y, z, w ) )
  end function
  
  function float4.zzw() as float3
    return( float3( z, z, w ) )
  end function
  
  function float4.wzw() as float3
    return( float3( w, z, w ) )
  end function
  
  function float4.xww() as float3
    return( float3( x, w, w ) )
  end function
  
  function float4.yww() as float3
    return( float3( y, w, w ) )
  end function
  
  function float4.zww() as float3
    return( float3( z, w, w ) )
  end function
  
  function float4.www() as float3
    return( float3( w, w, w ) )
  end function
  
  function float4.xxxx() as float4
    return( float4( x, x, x, x ) )
  end function
  
  function float4.yxxx() as float4
    return( float4( y, x, x, x ) )
  end function
  
  function float4.zxxx() as float4
    return( float4( z, x, x, x ) )
  end function
  
  function float4.wxxx() as float4
    return( float4( w, x, x, x ) )
  end function
  
  function float4.xyxx() as float4
    return( float4( x, y, x, x ) )
  end function
  
  function float4.yyxx() as float4
    return( float4( y, y, x, x ) )
  end function
  
  function float4.zyxx() as float4
    return( float4( z, y, x, x ) )
  end function
  
  function float4.wyxx() as float4
    return( float4( w, y, x, x ) )
  end function
  
  function float4.xzxx() as float4
    return( float4( x, z, x, x ) )
  end function
  
  function float4.yzxx() as float4
    return( float4( y, z, x, x ) )
  end function
  
  function float4.zzxx() as float4
    return( float4( z, z, x, x ) )
  end function
  
  function float4.wzxx() as float4
    return( float4( w, z, x, x ) )
  end function
  
  function float4.xwxx() as float4
    return( float4( x, w, x, x ) )
  end function
  
  function float4.ywxx() as float4
    return( float4( y, w, x, x ) )
  end function
  
  function float4.zwxx() as float4
    return( float4( z, w, x, x ) )
  end function
  
  function float4.wwxx() as float4
    return( float4( w, w, x, x ) )
  end function
  
  function float4.xxyx() as float4
    return( float4( x, x, y, x ) )
  end function
  
  function float4.yxyx() as float4
    return( float4( y, x, y, x ) )
  end function
  
  function float4.zxyx() as float4
    return( float4( z, x, y, x ) )
  end function
  
  function float4.wxyx() as float4
    return( float4( w, x, y, x ) )
  end function
  
  function float4.xyyx() as float4
    return( float4( x, y, y, x ) )
  end function
  
  function float4.yyyx() as float4
    return( float4( y, y, y, x ) )
  end function
  
  function float4.zyyx() as float4
    return( float4( z, y, y, x ) )
  end function
  
  function float4.wyyx() as float4
    return( float4( w, y, y, x ) )
  end function
  
  function float4.xzyx() as float4
    return( float4( x, z, y, x ) )
  end function
  
  function float4.yzyx() as float4
    return( float4( y, z, y, x ) )
  end function
  
  function float4.zzyx() as float4
    return( float4( z, z, y, x ) )
  end function
  
  function float4.wzyx() as float4
    return( float4( w, z, y, x ) )
  end function
  
  function float4.xwyx() as float4
    return( float4( x, w, y, x ) )
  end function
  
  function float4.ywyx() as float4
    return( float4( y, w, y, x ) )
  end function
  
  function float4.zwyx() as float4
    return( float4( z, w, y, x ) )
  end function
  
  function float4.wwyx() as float4
    return( float4( w, w, y, x ) )
  end function
  
  function float4.xxzx() as float4
    return( float4( x, x, z, x ) )
  end function
  
  function float4.yxzx() as float4
    return( float4( y, x, z, x ) )
  end function
  
  function float4.zxzx() as float4
    return( float4( z, x, z, x ) )
  end function
  
  function float4.wxzx() as float4
    return( float4( w, x, z, x ) )
  end function
  
  function float4.xyzx() as float4
    return( float4( x, y, z, x ) )
  end function
  
  function float4.yyzx() as float4
    return( float4( y, y, z, x ) )
  end function
  
  function float4.zyzx() as float4
    return( float4( z, y, z, x ) )
  end function
  
  function float4.wyzx() as float4
    return( float4( w, y, z, x ) )
  end function
  
  function float4.xzzx() as float4
    return( float4( x, z, z, x ) )
  end function
  
  function float4.yzzx() as float4
    return( float4( y, z, z, x ) )
  end function
  
  function float4.zzzx() as float4
    return( float4( z, z, z, x ) )
  end function
  
  function float4.wzzx() as float4
    return( float4( w, z, z, x ) )
  end function
  
  function float4.xwzx() as float4
    return( float4( x, w, z, x ) )
  end function
  
  function float4.ywzx() as float4
    return( float4( y, w, z, x ) )
  end function
  
  function float4.zwzx() as float4
    return( float4( z, w, z, x ) )
  end function
  
  function float4.wwzx() as float4
    return( float4( w, w, z, x ) )
  end function
  
  function float4.xxwx() as float4
    return( float4( x, x, w, x ) )
  end function
  
  function float4.yxwx() as float4
    return( float4( y, x, w, x ) )
  end function
  
  function float4.zxwx() as float4
    return( float4( z, x, w, x ) )
  end function
  
  function float4.wxwx() as float4
    return( float4( w, x, w, x ) )
  end function
  
  function float4.xywx() as float4
    return( float4( x, y, w, x ) )
  end function
  
  function float4.yywx() as float4
    return( float4( y, y, w, x ) )
  end function
  
  function float4.zywx() as float4
    return( float4( z, y, w, x ) )
  end function
  
  function float4.wywx() as float4
    return( float4( w, y, w, x ) )
  end function
  
  function float4.xzwx() as float4
    return( float4( x, z, w, x ) )
  end function
  
  function float4.yzwx() as float4
    return( float4( y, z, w, x ) )
  end function
  
  function float4.zzwx() as float4
    return( float4( z, z, w, x ) )
  end function
  
  function float4.wzwx() as float4
    return( float4( w, z, w, x ) )
  end function
  
  function float4.xwwx() as float4
    return( float4( x, w, w, x ) )
  end function
  
  function float4.ywwx() as float4
    return( float4( y, w, w, x ) )
  end function
  
  function float4.zwwx() as float4
    return( float4( z, w, w, x ) )
  end function
  
  function float4.wwwx() as float4
    return( float4( w, w, w, x ) )
  end function
  
  function float4.xxxy() as float4
    return( float4( x, x, x, y ) )
  end function
  
  function float4.yxxy() as float4
    return( float4( y, x, x, y ) )
  end function
  
  function float4.zxxy() as float4
    return( float4( z, x, x, y ) )
  end function
  
  function float4.wxxy() as float4
    return( float4( w, x, x, y ) )
  end function
  
  function float4.xyxy() as float4
    return( float4( x, y, x, y ) )
  end function
  
  function float4.yyxy() as float4
    return( float4( y, y, x, y ) )
  end function
  
  function float4.zyxy() as float4
    return( float4( z, y, x, y ) )
  end function
  
  function float4.wyxy() as float4
    return( float4( w, y, x, y ) )
  end function
  
  function float4.xzxy() as float4
    return( float4( x, z, x, y ) )
  end function
  
  function float4.yzxy() as float4
    return( float4( y, z, x, y ) )
  end function
  
  function float4.zzxy() as float4
    return( float4( z, z, x, y ) )
  end function
  
  function float4.wzxy() as float4
    return( float4( w, z, x, y ) )
  end function
  
  function float4.xwxy() as float4
    return( float4( x, w, x, y ) )
  end function
  
  function float4.ywxy() as float4
    return( float4( y, w, x, y ) )
  end function
  
  function float4.zwxy() as float4
    return( float4( z, w, x, y ) )
  end function
  
  function float4.wwxy() as float4
    return( float4( w, w, x, y ) )
  end function
  
  function float4.xxyy() as float4
    return( float4( x, x, y, y ) )
  end function
  
  function float4.yxyy() as float4
    return( float4( y, x, y, y ) )
  end function
  
  function float4.zxyy() as float4
    return( float4( z, x, y, y ) )
  end function
  
  function float4.wxyy() as float4
    return( float4( w, x, y, y ) )
  end function
  
  function float4.xyyy() as float4
    return( float4( x, y, y, y ) )
  end function
  
  function float4.yyyy() as float4
    return( float4( y, y, y, y ) )
  end function
  
  function float4.zyyy() as float4
    return( float4( z, y, y, y ) )
  end function
  
  function float4.wyyy() as float4
    return( float4( w, y, y, y ) )
  end function
  
  function float4.xzyy() as float4
    return( float4( x, z, y, y ) )
  end function
  
  function float4.yzyy() as float4
    return( float4( y, z, y, y ) )
  end function
  
  function float4.zzyy() as float4
    return( float4( z, z, y, y ) )
  end function
  
  function float4.wzyy() as float4
    return( float4( w, z, y, y ) )
  end function
  
  function float4.xwyy() as float4
    return( float4( x, w, y, y ) )
  end function
  
  function float4.ywyy() as float4
    return( float4( y, w, y, y ) )
  end function
  
  function float4.zwyy() as float4
    return( float4( z, w, y, y ) )
  end function
  
  function float4.wwyy() as float4
    return( float4( w, w, y, y ) )
  end function
  
  function float4.xxzy() as float4
    return( float4( x, x, z, y ) )
  end function
  
  function float4.yxzy() as float4
    return( float4( y, x, z, y ) )
  end function
  
  function float4.zxzy() as float4
    return( float4( z, x, z, y ) )
  end function
  
  function float4.wxzy() as float4
    return( float4( w, x, z, y ) )
  end function
  
  function float4.xyzy() as float4
    return( float4( x, y, z, y ) )
  end function
  
  function float4.yyzy() as float4
    return( float4( y, y, z, y ) )
  end function
  
  function float4.zyzy() as float4
    return( float4( z, y, z, y ) )
  end function
  
  function float4.wyzy() as float4
    return( float4( w, y, z, y ) )
  end function
  
  function float4.xzzy() as float4
    return( float4( x, z, z, y ) )
  end function
  
  function float4.yzzy() as float4
    return( float4( y, z, z, y ) )
  end function
  
  function float4.zzzy() as float4
    return( float4( z, z, z, y ) )
  end function
  
  function float4.wzzy() as float4
    return( float4( w, z, z, y ) )
  end function
  
  function float4.xwzy() as float4
    return( float4( x, w, z, y ) )
  end function
  
  function float4.ywzy() as float4
    return( float4( y, w, z, y ) )
  end function
  
  function float4.zwzy() as float4
    return( float4( z, w, z, y ) )
  end function
  
  function float4.wwzy() as float4
    return( float4( w, w, z, y ) )
  end function
  
  function float4.xxwy() as float4
    return( float4( x, x, w, y ) )
  end function
  
  function float4.yxwy() as float4
    return( float4( y, x, w, y ) )
  end function
  
  function float4.zxwy() as float4
    return( float4( z, x, w, y ) )
  end function
  
  function float4.wxwy() as float4
    return( float4( w, x, w, y ) )
  end function
  
  function float4.xywy() as float4
    return( float4( x, y, w, y ) )
  end function
  
  function float4.yywy() as float4
    return( float4( y, y, w, y ) )
  end function
  
  function float4.zywy() as float4
    return( float4( z, y, w, y ) )
  end function
  
  function float4.wywy() as float4
    return( float4( w, y, w, y ) )
  end function
  
  function float4.xzwy() as float4
    return( float4( x, z, w, y ) )
  end function
  
  function float4.yzwy() as float4
    return( float4( y, z, w, y ) )
  end function
  
  function float4.zzwy() as float4
    return( float4( z, z, w, y ) )
  end function
  
  function float4.wzwy() as float4
    return( float4( w, z, w, y ) )
  end function
  
  function float4.xwwy() as float4
    return( float4( x, w, w, y ) )
  end function
  
  function float4.ywwy() as float4
    return( float4( y, w, w, y ) )
  end function
  
  function float4.zwwy() as float4
    return( float4( z, w, w, y ) )
  end function
  
  function float4.wwwy() as float4
    return( float4( w, w, w, y ) )
  end function
  
  function float4.xxxz() as float4
    return( float4( x, x, x, z ) )
  end function
  
  function float4.yxxz() as float4
    return( float4( y, x, x, z ) )
  end function
  
  function float4.zxxz() as float4
    return( float4( z, x, x, z ) )
  end function
  
  function float4.wxxz() as float4
    return( float4( w, x, x, z ) )
  end function
  
  function float4.xyxz() as float4
    return( float4( x, y, x, z ) )
  end function
  
  function float4.yyxz() as float4
    return( float4( y, y, x, z ) )
  end function
  
  function float4.zyxz() as float4
    return( float4( z, y, x, z ) )
  end function
  
  function float4.wyxz() as float4
    return( float4( w, y, x, z ) )
  end function
  
  function float4.xzxz() as float4
    return( float4( x, z, x, z ) )
  end function
  
  function float4.yzxz() as float4
    return( float4( y, z, x, z ) )
  end function
  
  function float4.zzxz() as float4
    return( float4( z, z, x, z ) )
  end function
  
  function float4.wzxz() as float4
    return( float4( w, z, x, z ) )
  end function
  
  function float4.xwxz() as float4
    return( float4( x, w, x, z ) )
  end function
  
  function float4.ywxz() as float4
    return( float4( y, w, x, z ) )
  end function
  
  function float4.zwxz() as float4
    return( float4( z, w, x, z ) )
  end function
  
  function float4.wwxz() as float4
    return( float4( w, w, x, z ) )
  end function
  
  function float4.xxyz() as float4
    return( float4( x, x, y, z ) )
  end function
  
  function float4.yxyz() as float4
    return( float4( y, x, y, z ) )
  end function
  
  function float4.zxyz() as float4
    return( float4( z, x, y, z ) )
  end function
  
  function float4.wxyz() as float4
    return( float4( w, x, y, z ) )
  end function
  
  function float4.xyyz() as float4
    return( float4( x, y, y, z ) )
  end function
  
  function float4.yyyz() as float4
    return( float4( y, y, y, z ) )
  end function
  
  function float4.zyyz() as float4
    return( float4( z, y, y, z ) )
  end function
  
  function float4.wyyz() as float4
    return( float4( w, y, y, z ) )
  end function
  
  function float4.xzyz() as float4
    return( float4( x, z, y, z ) )
  end function
  
  function float4.yzyz() as float4
    return( float4( y, z, y, z ) )
  end function
  
  function float4.zzyz() as float4
    return( float4( z, z, y, z ) )
  end function
  
  function float4.wzyz() as float4
    return( float4( w, z, y, z ) )
  end function
  
  function float4.xwyz() as float4
    return( float4( x, w, y, z ) )
  end function
  
  function float4.ywyz() as float4
    return( float4( y, w, y, z ) )
  end function
  
  function float4.zwyz() as float4
    return( float4( z, w, y, z ) )
  end function
  
  function float4.wwyz() as float4
    return( float4( w, w, y, z ) )
  end function
  
  function float4.xxzz() as float4
    return( float4( x, x, z, z ) )
  end function
  
  function float4.yxzz() as float4
    return( float4( y, x, z, z ) )
  end function
  
  function float4.zxzz() as float4
    return( float4( z, x, z, z ) )
  end function
  
  function float4.wxzz() as float4
    return( float4( w, x, z, z ) )
  end function
  
  function float4.xyzz() as float4
    return( float4( x, y, z, z ) )
  end function
  
  function float4.yyzz() as float4
    return( float4( y, y, z, z ) )
  end function
  
  function float4.zyzz() as float4
    return( float4( z, y, z, z ) )
  end function
  
  function float4.wyzz() as float4
    return( float4( w, y, z, z ) )
  end function
  
  function float4.xzzz() as float4
    return( float4( x, z, z, z ) )
  end function
  
  function float4.yzzz() as float4
    return( float4( y, z, z, z ) )
  end function
  
  function float4.zzzz() as float4
    return( float4( z, z, z, z ) )
  end function
  
  function float4.wzzz() as float4
    return( float4( w, z, z, z ) )
  end function
  
  function float4.xwzz() as float4
    return( float4( x, w, z, z ) )
  end function
  
  function float4.ywzz() as float4
    return( float4( y, w, z, z ) )
  end function
  
  function float4.zwzz() as float4
    return( float4( z, w, z, z ) )
  end function
  
  function float4.wwzz() as float4
    return( float4( w, w, z, z ) )
  end function
  
  function float4.xxwz() as float4
    return( float4( x, x, w, z ) )
  end function
  
  function float4.yxwz() as float4
    return( float4( y, x, w, z ) )
  end function
  
  function float4.zxwz() as float4
    return( float4( z, x, w, z ) )
  end function
  
  function float4.wxwz() as float4
    return( float4( w, x, w, z ) )
  end function
  
  function float4.xywz() as float4
    return( float4( x, y, w, z ) )
  end function
  
  function float4.yywz() as float4
    return( float4( y, y, w, z ) )
  end function
  
  function float4.zywz() as float4
    return( float4( z, y, w, z ) )
  end function
  
  function float4.wywz() as float4
    return( float4( w, y, w, z ) )
  end function
  
  function float4.xzwz() as float4
    return( float4( x, z, w, z ) )
  end function
  
  function float4.yzwz() as float4
    return( float4( y, z, w, z ) )
  end function
  
  function float4.zzwz() as float4
    return( float4( z, z, w, z ) )
  end function
  
  function float4.wzwz() as float4
    return( float4( w, z, w, z ) )
  end function
  
  function float4.xwwz() as float4
    return( float4( x, w, w, z ) )
  end function
  
  function float4.ywwz() as float4
    return( float4( y, w, w, z ) )
  end function
  
  function float4.zwwz() as float4
    return( float4( z, w, w, z ) )
  end function
  
  function float4.wwwz() as float4
    return( float4( w, w, w, z ) )
  end function
  
  function float4.xxxw() as float4
    return( float4( x, x, x, w ) )
  end function
  
  function float4.yxxw() as float4
    return( float4( y, x, x, w ) )
  end function
  
  function float4.zxxw() as float4
    return( float4( z, x, x, w ) )
  end function
  
  function float4.wxxw() as float4
    return( float4( w, x, x, w ) )
  end function
  
  function float4.xyxw() as float4
    return( float4( x, y, x, w ) )
  end function
  
  function float4.yyxw() as float4
    return( float4( y, y, x, w ) )
  end function
  
  function float4.zyxw() as float4
    return( float4( z, y, x, w ) )
  end function
  
  function float4.wyxw() as float4
    return( float4( w, y, x, w ) )
  end function
  
  function float4.xzxw() as float4
    return( float4( x, z, x, w ) )
  end function
  
  function float4.yzxw() as float4
    return( float4( y, z, x, w ) )
  end function
  
  function float4.zzxw() as float4
    return( float4( z, z, x, w ) )
  end function
  
  function float4.wzxw() as float4
    return( float4( w, z, x, w ) )
  end function
  
  function float4.xwxw() as float4
    return( float4( x, w, x, w ) )
  end function
  
  function float4.ywxw() as float4
    return( float4( y, w, x, w ) )
  end function
  
  function float4.zwxw() as float4
    return( float4( z, w, x, w ) )
  end function
  
  function float4.wwxw() as float4
    return( float4( w, w, x, w ) )
  end function
  
  function float4.xxyw() as float4
    return( float4( x, x, y, w ) )
  end function
  
  function float4.yxyw() as float4
    return( float4( y, x, y, w ) )
  end function
  
  function float4.zxyw() as float4
    return( float4( z, x, y, w ) )
  end function
  
  function float4.wxyw() as float4
    return( float4( w, x, y, w ) )
  end function
  
  function float4.xyyw() as float4
    return( float4( x, y, y, w ) )
  end function
  
  function float4.yyyw() as float4
    return( float4( y, y, y, w ) )
  end function
  
  function float4.zyyw() as float4
    return( float4( z, y, y, w ) )
  end function
  
  function float4.wyyw() as float4
    return( float4( w, y, y, w ) )
  end function
  
  function float4.xzyw() as float4
    return( float4( x, z, y, w ) )
  end function
  
  function float4.yzyw() as float4
    return( float4( y, z, y, w ) )
  end function
  
  function float4.zzyw() as float4
    return( float4( z, z, y, w ) )
  end function
  
  function float4.wzyw() as float4
    return( float4( w, z, y, w ) )
  end function
  
  function float4.xwyw() as float4
    return( float4( x, w, y, w ) )
  end function
  
  function float4.ywyw() as float4
    return( float4( y, w, y, w ) )
  end function
  
  function float4.zwyw() as float4
    return( float4( z, w, y, w ) )
  end function
  
  function float4.wwyw() as float4
    return( float4( w, w, y, w ) )
  end function
  
  function float4.xxzw() as float4
    return( float4( x, x, z, w ) )
  end function
  
  function float4.yxzw() as float4
    return( float4( y, x, z, w ) )
  end function
  
  function float4.zxzw() as float4
    return( float4( z, x, z, w ) )
  end function
  
  function float4.wxzw() as float4
    return( float4( w, x, z, w ) )
  end function
  
  function float4.yyzw() as float4
    return( float4( y, y, z, w ) )
  end function
  
  function float4.zyzw() as float4
    return( float4( z, y, z, w ) )
  end function
  
  function float4.wyzw() as float4
    return( float4( w, y, z, w ) )
  end function
  
  function float4.xzzw() as float4
    return( float4( x, z, z, w ) )
  end function
  
  function float4.yzzw() as float4
    return( float4( y, z, z, w ) )
  end function
  
  function float4.zzzw() as float4
    return( float4( z, z, z, w ) )
  end function
  
  function float4.wzzw() as float4
    return( float4( w, z, z, w ) )
  end function
  
  function float4.xwzw() as float4
    return( float4( x, w, z, w ) )
  end function
  
  function float4.ywzw() as float4
    return( float4( y, w, z, w ) )
  end function
  
  function float4.zwzw() as float4
    return( float4( z, w, z, w ) )
  end function
  
  function float4.wwzw() as float4
    return( float4( w, w, z, w ) )
  end function
  
  function float4.xxww() as float4
    return( float4( x, x, w, w ) )
  end function
  
  function float4.yxww() as float4
    return( float4( y, x, w, w ) )
  end function
  
  function float4.zxww() as float4
    return( float4( z, x, w, w ) )
  end function
  
  function float4.wxww() as float4
    return( float4( w, x, w, w ) )
  end function
  
  function float4.xyww() as float4
    return( float4( x, y, w, w ) )
  end function
  
  function float4.yyww() as float4
    return( float4( y, y, w, w ) )
  end function
  
  function float4.zyww() as float4
    return( float4( z, y, w, w ) )
  end function
  
  function float4.wyww() as float4
    return( float4( w, y, w, w ) )
  end function
  
  function float4.xzww() as float4
    return( float4( x, z, w, w ) )
  end function
  
  function float4.yzww() as float4
    return( float4( y, z, w, w ) )
  end function
  
  function float4.zzww() as float4
    return( float4( z, z, w, w ) )
  end function
  
  function float4.wzww() as float4
    return( float4( w, z, w, w ) )
  end function
  
  function float4.xwww() as float4
    return( float4( x, w, w, w ) )
  end function
  
  function float4.ywww() as float4
    return( float4( y, w, w, w ) )
  end function
  
  function float4.zwww() as float4
    return( float4( z, w, w, w ) )
  end function
  
  function float4.wwww() as float4
    return( float4( w, w, w, w ) )
  end function
  
  /'
    Returns the squared length of this vector
    
    Useful when you just want to compare which one is bigger,
    as this avoids having to compute a square root.
  '/
  function float4.squaredLength() as float
    return( x * x + y * y + z * z )
  end function
  
  '' Returns the length of this vector
  function float4.length() as float
    return( sqr( x * x + y * y + z * z ) )
  end function
  
  /'
    Normalizes the vector.
    
    Note that the homogeneous coordinate (w) is not to be touched
    here.
  '/
  sub float4.normalize()
    dim as float l = length()
    
    if( l > 0.0 )then
      x /= l : y /= l : z /= l
    end if
  end sub
  
  /'
    Returns this vector normalized but without altering itself
    again the homogeneous coordinate is left alone
  '/
  function float4.unit() as float4
    dim as float l = sqr( x ^ 2 + y ^ 2 + z ^ 2 )
    
    if( l > 0.0 ) then
      return( float4( x / l, y / l, z / l, w ) )
    else
      return( float4( x, y, z, w ) )
    end if
  end function
  
  /'
    Homogeneizes the vector
    
    This is done by dividing the components by the homogeneous
    coordinate (w).
  '/
  sub float4.homogeneize()
    x /= w : y /= w : z /= w : w /= w
  end sub
  
  /'
    Returns this vector homogeneized but without altering it
  '/
  function float4.homogeneous() as float4
    return( float4( x / w, y / w, z / w, w / w ) )
  end function
  
  /'
    Returns the dot product (aka scalar product) of this
    vector and vector v.
  '/
  function float4.dot( _
    byref v as float4 ) as float
    return( v.x * x + v.y * y + v.z * z )
  end function
  
  /'
    Returns the cross product (aka vectorial product) of this
    vector and another vector v.
    Note that there's no cross product defined for a 4 tuple, so
    we simply use a standard 3d cross product, and make the w
    component 1 since the cross product is, indeed, a vector.
  '/
  function float4.cross( _
    byref v as float4 ) as float4
    
    return( float4( _
      v.y * z - v.z * y, _
      v.z * x - v.x * z, _
      v.x * y - v.y * x, _
      1.0 ) )
  end function
  
  /'
    Gets the distance of this vector with vector v
    To calculate the distance, substract them and
    calculate the length of the resultant vector.
  '/
  function float4.distance( _
    byref v as float4 ) as float
    return( sqr( ( v.x - x ) ^ 2 + ( v.y - y ) ^ 2 + ( v.z - z ) ^ 2 ) )
  end function
  
  operator - ( _
    byref v as float4, byref w as float4 ) as float4
    
    return( float4( v.x - w.x, v.y - w.y, v.z - w.z ) )
  end operator
  
  operator - ( _
    byref v as float4 ) as float4
    
    return( float4( -v.x, -v.y, -v.z ) )
  end operator
  
  operator + ( _
    byref v as float4, byref w as float4 ) as float4
    
    return( float4( v.x + w.x, v.y + w.y, v.z + w.z ) )
  end operator
  
  operator _
    * ( _
      byref v as float4, _
      byref w as float4 ) _
    as float4
    
    return( float4( _
      v.x * w.x, _
      v.y * w.y, _
      v.z * w.z, _
      v.w * w.w ) )
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
    byref v as float4, byref s as float ) as float4
    
    return( float4( v.x * s, v.y * s, v.z * s ) )
  end operator
  
  '' Same as above but with the parameters inversed
  operator * ( _
    byref s as float, byref v as float4 ) as float4
    
    return( float4( v.x * s, v.y * s, v.z * s ) )
  end operator
  
  '' Division by a scalar. See note above on multiplying a vector
  operator / ( _
    byref v as float4, byref s as float ) as float4
    
    return( float4( v.x / s, v.y / s, v.z / s ) )
  end operator
  
  function _
    vMax overload( _
      byref p as Float4, _
      byval v as float ) _
    as Float4
    
    return( Float4( _
      fMax( p.x, v ), _
      fMax( p.y, v ), _
      fMax( p.z, v ), _
      fMax( p.w, v ) ) )
  end function
  
  function _
    vMin overload( _
      byref p as Float4, _
      byval v as float ) _
    as Float4
    
    return( Float4( _
      fMin( p.x, v ), _
      fMin( p.y, v ), _
      fMin( p.z, v ), _
      fMin( p.w, v ) ) )
  end function
end namespace

#endif
