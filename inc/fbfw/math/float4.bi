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
  type Float4
    public:
      declare constructor()
      declare constructor( _
        byval as float => 0.0, _
        byval as float => 0.0, _
        byval as float => 0.0, _
        byval as float => 0.0 )
      declare constructor( _
        byref as Float3, _
        byval as float => 0.0 )
      declare constructor( _
        byval as float => 0.0, _
        byref as Float3 )
      declare constructor( _
        byref as Float2, _
        byref as Float2 )
      declare constructor( _
        byval as float, _
        byref as Float2, _
        byval as float )
      declare constructor( _
        byval as float, _
        byval as float, _
        byref as Float2 )
      declare constructor( _
        byref as Float2, _
        byval as float, _
        byval as float )
      declare constructor( _
        byref rhs as Float4 )
      declare operator let( _
        byref rhs as Float4 )
      
      declare operator cast() as string
      
      '' Swizzlings
      declare function xx() as Float2
      declare function yx() as Float2
      declare function zx() as Float2
      declare function wx() as Float2
      declare function xy() as Float2
      declare function yy() as Float2
      declare function zy() as Float2
      declare function wy() as Float2
      declare function xz() as Float2
      declare function yz() as Float2
      declare function zz() as Float2
      declare function wz() as Float2
      declare function xw() as Float2
      declare function yw() as Float2
      declare function zw() as Float2
      declare function ww() as Float2
      
      declare function xxx() as Float3
      declare function yxx() as Float3
      declare function zxx() as Float3
      declare function wxx() as Float3
      declare function xyx() as Float3
      declare function yyx() as Float3
      declare function zyx() as Float3
      declare function wyx() as Float3
      declare function xzx() as Float3
      declare function yzx() as Float3
      declare function zzx() as Float3
      declare function wzx() as Float3
      declare function xwx() as Float3
      declare function ywx() as Float3
      declare function zwx() as Float3
      declare function wwx() as Float3
      declare function xxy() as Float3
      declare function yxy() as Float3
      declare function zxy() as Float3
      declare function wxy() as Float3
      declare function xyy() as Float3
      declare function yyy() as Float3
      declare function zyy() as Float3
      declare function wyy() as Float3
      declare function xzy() as Float3
      declare function yzy() as Float3
      declare function zzy() as Float3
      declare function wzy() as Float3
      declare function xwy() as Float3
      declare function ywy() as Float3
      declare function zwy() as Float3
      declare function wwy() as Float3
      declare function xxz() as Float3
      declare function yxz() as Float3
      declare function zxz() as Float3
      declare function wxz() as Float3
      declare function xyz() as Float3
      declare function yyz() as Float3
      declare function zyz() as Float3
      declare function wyz() as Float3
      declare function xzz() as Float3
      declare function yzz() as Float3
      declare function zzz() as Float3
      declare function wzz() as Float3
      declare function xwz() as Float3
      declare function ywz() as Float3
      declare function zwz() as Float3
      declare function wwz() as Float3
      declare function xxw() as Float3
      declare function yxw() as Float3
      declare function zxw() as Float3
      declare function wxw() as Float3
      declare function xyw() as Float3
      declare function yyw() as Float3
      declare function zyw() as Float3
      declare function wyw() as Float3
      declare function xzw() as Float3
      declare function yzw() as Float3
      declare function zzw() as Float3
      declare function wzw() as Float3
      declare function xww() as Float3
      declare function yww() as Float3
      declare function zww() as Float3
      declare function www() as Float3
      
      declare function xxxx() as Float4
      declare function yxxx() as Float4
      declare function zxxx() as Float4
      declare function wxxx() as Float4
      declare function xyxx() as Float4
      declare function yyxx() as Float4
      declare function zyxx() as Float4
      declare function wyxx() as Float4
      declare function xzxx() as Float4
      declare function yzxx() as Float4
      declare function zzxx() as Float4
      declare function wzxx() as Float4
      declare function xwxx() as Float4
      declare function ywxx() as Float4
      declare function zwxx() as Float4
      declare function wwxx() as Float4
      declare function xxyx() as Float4
      declare function yxyx() as Float4
      declare function zxyx() as Float4
      declare function wxyx() as Float4
      declare function xyyx() as Float4
      declare function yyyx() as Float4
      declare function zyyx() as Float4
      declare function wyyx() as Float4
      declare function xzyx() as Float4
      declare function yzyx() as Float4
      declare function zzyx() as Float4
      declare function wzyx() as Float4
      declare function xwyx() as Float4
      declare function ywyx() as Float4
      declare function zwyx() as Float4
      declare function wwyx() as Float4
      declare function xxzx() as Float4
      declare function yxzx() as Float4
      declare function zxzx() as Float4
      declare function wxzx() as Float4
      declare function xyzx() as Float4
      declare function yyzx() as Float4
      declare function zyzx() as Float4
      declare function wyzx() as Float4
      declare function xzzx() as Float4
      declare function yzzx() as Float4
      declare function zzzx() as Float4
      declare function wzzx() as Float4
      declare function xwzx() as Float4
      declare function ywzx() as Float4
      declare function zwzx() as Float4
      declare function wwzx() as Float4
      declare function xxwx() as Float4
      declare function yxwx() as Float4
      declare function zxwx() as Float4
      declare function wxwx() as Float4
      declare function xywx() as Float4
      declare function yywx() as Float4
      declare function zywx() as Float4
      declare function wywx() as Float4
      declare function xzwx() as Float4
      declare function yzwx() as Float4
      declare function zzwx() as Float4
      declare function wzwx() as Float4
      declare function xwwx() as Float4
      declare function ywwx() as Float4
      declare function zwwx() as Float4
      declare function wwwx() as Float4
      declare function xxxy() as Float4
      declare function yxxy() as Float4
      declare function zxxy() as Float4
      declare function wxxy() as Float4
      declare function xyxy() as Float4
      declare function yyxy() as Float4
      declare function zyxy() as Float4
      declare function wyxy() as Float4
      declare function xzxy() as Float4
      declare function yzxy() as Float4
      declare function zzxy() as Float4
      declare function wzxy() as Float4
      declare function xwxy() as Float4
      declare function ywxy() as Float4
      declare function zwxy() as Float4
      declare function wwxy() as Float4
      declare function xxyy() as Float4
      declare function yxyy() as Float4
      declare function zxyy() as Float4
      declare function wxyy() as Float4
      declare function xyyy() as Float4
      declare function yyyy() as Float4
      declare function zyyy() as Float4
      declare function wyyy() as Float4
      declare function xzyy() as Float4
      declare function yzyy() as Float4
      declare function zzyy() as Float4
      declare function wzyy() as Float4
      declare function xwyy() as Float4
      declare function ywyy() as Float4
      declare function zwyy() as Float4
      declare function wwyy() as Float4
      declare function xxzy() as Float4
      declare function yxzy() as Float4
      declare function zxzy() as Float4
      declare function wxzy() as Float4
      declare function xyzy() as Float4
      declare function yyzy() as Float4
      declare function zyzy() as Float4
      declare function wyzy() as Float4
      declare function xzzy() as Float4
      declare function yzzy() as Float4
      declare function zzzy() as Float4
      declare function wzzy() as Float4
      declare function xwzy() as Float4
      declare function ywzy() as Float4
      declare function zwzy() as Float4
      declare function wwzy() as Float4
      declare function xxwy() as Float4
      declare function yxwy() as Float4
      declare function zxwy() as Float4
      declare function wxwy() as Float4
      declare function xywy() as Float4
      declare function yywy() as Float4
      declare function zywy() as Float4
      declare function wywy() as Float4
      declare function xzwy() as Float4
      declare function yzwy() as Float4
      declare function zzwy() as Float4
      declare function wzwy() as Float4
      declare function xwwy() as Float4
      declare function ywwy() as Float4
      declare function zwwy() as Float4
      declare function wwwy() as Float4
      declare function xxxz() as Float4
      declare function yxxz() as Float4
      declare function zxxz() as Float4
      declare function wxxz() as Float4
      declare function xyxz() as Float4
      declare function yyxz() as Float4
      declare function zyxz() as Float4
      declare function wyxz() as Float4
      declare function xzxz() as Float4
      declare function yzxz() as Float4
      declare function zzxz() as Float4
      declare function wzxz() as Float4
      declare function xwxz() as Float4
      declare function ywxz() as Float4
      declare function zwxz() as Float4
      declare function wwxz() as Float4
      declare function xxyz() as Float4
      declare function yxyz() as Float4
      declare function zxyz() as Float4
      declare function wxyz() as Float4
      declare function xyyz() as Float4
      declare function yyyz() as Float4
      declare function zyyz() as Float4
      declare function wyyz() as Float4
      declare function xzyz() as Float4
      declare function yzyz() as Float4
      declare function zzyz() as Float4
      declare function wzyz() as Float4
      declare function xwyz() as Float4
      declare function ywyz() as Float4
      declare function zwyz() as Float4
      declare function wwyz() as Float4
      declare function xxzz() as Float4
      declare function yxzz() as Float4
      declare function zxzz() as Float4
      declare function wxzz() as Float4
      declare function xyzz() as Float4
      declare function yyzz() as Float4
      declare function zyzz() as Float4
      declare function wyzz() as Float4
      declare function xzzz() as Float4
      declare function yzzz() as Float4
      declare function zzzz() as Float4
      declare function wzzz() as Float4
      declare function xwzz() as Float4
      declare function ywzz() as Float4
      declare function zwzz() as Float4
      declare function wwzz() as Float4
      declare function xxwz() as Float4
      declare function yxwz() as Float4
      declare function zxwz() as Float4
      declare function wxwz() as Float4
      declare function xywz() as Float4
      declare function yywz() as Float4
      declare function zywz() as Float4
      declare function wywz() as Float4
      declare function xzwz() as Float4
      declare function yzwz() as Float4
      declare function zzwz() as Float4
      declare function wzwz() as Float4
      declare function xwwz() as Float4
      declare function ywwz() as Float4
      declare function zwwz() as Float4
      declare function wwwz() as Float4
      declare function xxxw() as Float4
      declare function yxxw() as Float4
      declare function zxxw() as Float4
      declare function wxxw() as Float4
      declare function xyxw() as Float4
      declare function yyxw() as Float4
      declare function zyxw() as Float4
      declare function wyxw() as Float4
      declare function xzxw() as Float4
      declare function yzxw() as Float4
      declare function zzxw() as Float4
      declare function wzxw() as Float4
      declare function xwxw() as Float4
      declare function ywxw() as Float4
      declare function zwxw() as Float4
      declare function wwxw() as Float4
      declare function xxyw() as Float4
      declare function yxyw() as Float4
      declare function zxyw() as Float4
      declare function wxyw() as Float4
      declare function xyyw() as Float4
      declare function yyyw() as Float4
      declare function zyyw() as Float4
      declare function wyyw() as Float4
      declare function xzyw() as Float4
      declare function yzyw() as Float4
      declare function zzyw() as Float4
      declare function wzyw() as Float4
      declare function xwyw() as Float4
      declare function ywyw() as Float4
      declare function zwyw() as Float4
      declare function wwyw() as Float4
      declare function xxzw() as Float4
      declare function yxzw() as Float4
      declare function zxzw() as Float4
      declare function wxzw() as Float4
      declare function yyzw() as Float4
      declare function zyzw() as Float4
      declare function wyzw() as Float4
      declare function xzzw() as Float4
      declare function yzzw() as Float4
      declare function zzzw() as Float4
      declare function wzzw() as Float4
      declare function xwzw() as Float4
      declare function ywzw() as Float4
      declare function zwzw() as Float4
      declare function wwzw() as Float4
      declare function xxww() as Float4
      declare function yxww() as Float4
      declare function zxww() as Float4
      declare function wxww() as Float4
      declare function xyww() as Float4
      declare function yyww() as Float4
      declare function zyww() as Float4
      declare function wyww() as Float4
      declare function xzww() as Float4
      declare function yzww() as Float4
      declare function zzww() as Float4
      declare function wzww() as Float4
      declare function xwww() as Float4
      declare function ywww() as Float4
      declare function zwww() as Float4
      declare function wwww() as Float4
      
      '' Convenience methods
      declare function length() as float
      declare function squaredLength() as float
      declare sub normalize()
      declare function normalized() as Float4
      declare sub homogeneize()
      declare function homogeneous() as Float4
      declare function cross( _
        byref as Float4 ) as Float4
      declare function dot( _
        byref as Float4 ) as float
      declare function distance( _
        byref as Float4 ) as float
      declare function squaredDistance( _
        byref as Float4 ) as float
      
      as float _
        x, y, z, w
  end type
  
  constructor Float4()
    x => 0.0
    y => 0.0
    z => 0.0
    w => 0.0
  end constructor
  
  constructor Float4( _
    byval nx as float => 0.0, _
    byval ny as float => 0.0, _
    byval nz as float => 0.0, _
    byval nw as float => 0.0 )
    
    x => nx
    y => ny
    z => nz
    w => nw
  end constructor
  
  constructor Float4( _
    byref aFloat3 as Float3, _
    byval nw as float => 0.0 )
    
    x => aFloat3.x
    y => aFloat3.y
    z => aFloat3.z
    w => nw
  end constructor
  
  constructor Float4( _
    byval nx as float => 0.0, _
    byref aFloat3 as Float3 )
    
    x => nx
    y => aFloat3.x
    z => aFloat3.y
    w => aFloat3.z
  end constructor
  
  constructor Float4( _
    byref aFloat2_1 as Float2, _
    byref aFloat2_2 as Float2 )
    
    x => aFloat2_1.x
    y => aFloat2_1.y
    z => aFloat2_2.x
    w => aFloat2_2.y
  end constructor
  
  constructor Float4( _
    byval aFloat_1 as float, _
    byref aFloat2 as Float2, _
    byval aFloat_2 as float )
    
    x => aFloat_1
    y => aFloat2.x
    z => aFloat2.y
    w => aFloat_2
  end constructor
  
  constructor Float4( _
    byval aFloat_1 as float, _
    byval aFloat_2 as float, _
    byref aFloat2 as Float2 )
    
    x => aFloat_1
    y => aFloat_2
    z => aFloat2.x
    w => aFloat2.y
  end constructor
  
  constructor Float4( _
    byref aFloat2 as Float2, _
    byval aFloat_1 as float, _
    byval aFloat_2 as float )
    
    x => aFloat2.x
    y => aFloat2.y
    z => aFloat_1
    w => aFloat_2
  end constructor
  
  '' Copy constructor
  constructor Float4( _
    byref rhs as Float4 )
    x => rhs.x
    y => rhs.y
    z => rhs.z
    w => rhs.w
  end constructor
  
  operator Float4.let( _
    byref rhs as Float4 )
    
    x => rhs.x
    y => rhs.y
    z => rhs.z
    w => rhs.w
  end operator
  
  operator Float4.cast() as string
    '' Human readable string representation (useful for debugging)
    return( _
      "| " & trim( str( x ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( y ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( z ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( w ) ) & " |" & chr( 13 ) & chr( 10 ) )
  end operator
  
  function Float4.xx() as Float2
    return( Float2( x, x ) )
  end function
  
  function Float4.yx() as Float2
    return( Float2( y, x ) )
  end function
  
  function Float4.zx() as Float2
    return( Float2( z, x ) )
  end function
  
  function Float4.wx() as Float2
    return( Float2( w, x ) )
  end function
  
  function Float4.xy() as Float2
    return( Float2( x, y ) )
  end function
  
  function Float4.yy() as Float2
    return( Float2( y, y ) )
  end function
  
  function Float4.zy() as Float2
    return( Float2( z, y ) )
  end function
  
  function Float4.wy() as Float2
    return( Float2( w, y ) )
  end function
  
  function Float4.xz() as Float2
    return( Float2( x, z ) )
  end function
  
  function Float4.yz() as Float2
    return( Float2( y, z ) )
  end function
  
  function Float4.zz() as Float2
    return( Float2( z, z ) )
  end function
  
  function Float4.wz() as Float2
    return( Float2( w, z ) )
  end function
  
  function Float4.xw() as Float2
    return( Float2( x, w ) )
  end function
  
  function Float4.yw() as Float2
    return( Float2( y, w ) )
  end function
  
  function Float4.zw() as Float2
    return( Float2( z, w ) )
  end function
  
  function Float4.ww() as Float2
    return( Float2( w, w ) )
  end function
  
  function Float4.xxx() as Float3
    return( Float3( x, x, x ) )
  end function
  
  function Float4.yxx() as Float3
    return( Float3( y, x, x ) )
  end function
  
  function Float4.zxx() as Float3
    return( Float3( z, x, x ) )
  end function
  
  function Float4.wxx() as Float3
    return( Float3( w, x, x ) )
  end function
  
  function Float4.xyx() as Float3
    return( Float3( x, y, x ) )
  end function
  
  function Float4.yyx() as Float3
    return( Float3( y, y, x ) )
  end function
  
  function Float4.zyx() as Float3
    return( Float3( z, y, x ) )
  end function
  
  function Float4.wyx() as Float3
    return( Float3( w, y, x ) )
  end function
  
  function Float4.xzx() as Float3
    return( Float3( x, z, x ) )
  end function
  
  function Float4.yzx() as Float3
    return( Float3( y, z, x ) )
  end function
  
  function Float4.zzx() as Float3
    return( Float3( z, z, x ) )
  end function
  
  function Float4.wzx() as Float3
    return( Float3( w, z, x ) )
  end function
  
  function Float4.xwx() as Float3
    return( Float3( x, w, x ) )
  end function
  
  function Float4.ywx() as Float3
    return( Float3( y, w, x ) )
  end function
  
  function Float4.zwx() as Float3
    return( Float3( z, w, x ) )
  end function
  
  function Float4.wwx() as Float3
    return( Float3( w, w, x ) )
  end function
  
  function Float4.xxy() as Float3
    return( Float3( x, x, y ) )
  end function
  
  function Float4.yxy() as Float3
    return( Float3( y, x, y ) )
  end function
  
  function Float4.zxy() as Float3
    return( Float3( z, x, y ) )
  end function
  
  function Float4.wxy() as Float3
    return( Float3( w, x, y ) )
  end function
  
  function Float4.xyy() as Float3
    return( Float3( x, y, y ) )
  end function
  
  function Float4.yyy() as Float3
    return( Float3( y, y, y ) )
  end function
  
  function Float4.zyy() as Float3
    return( Float3( z, y, y ) )
  end function
  
  function Float4.wyy() as Float3
    return( Float3( w, y, y ) )
  end function
  
  function Float4.xzy() as Float3
    return( Float3( x, z, y ) )
  end function
  
  function Float4.yzy() as Float3
    return( Float3( y, z, y ) )
  end function
  
  function Float4.zzy() as Float3
    return( Float3( z, z, y ) )
  end function
  
  function Float4.wzy() as Float3
    return( Float3( w, z, y ) )
  end function
  
  function Float4.xwy() as Float3
    return( Float3( x, w, y ) )
  end function
  
  function Float4.ywy() as Float3
    return( Float3( y, w, y ) )
  end function
  
  function Float4.zwy() as Float3
    return( Float3( z, w, y ) )
  end function
  
  function Float4.wwy() as Float3
    return( Float3( w, w, y ) )
  end function
  
  function Float4.xxz() as Float3
    return( Float3( x, x, z ) )
  end function
  
  function Float4.yxz() as Float3
    return( Float3( y, x, z ) )
  end function
  
  function Float4.zxz() as Float3
    return( Float3( z, x, z ) )
  end function
  
  function Float4.wxz() as Float3
    return( Float3( w, x, z ) )
  end function
  
  function Float4.xyz() as Float3
    return( Float3( x, y, z ) )
  end function
  
  function Float4.yyz() as Float3
    return( Float3( y, y, z ) )
  end function
  
  function Float4.zyz() as Float3
    return( Float3( z, y, z ) )
  end function
  
  function Float4.wyz() as Float3
    return( Float3( w, y, z ) )
  end function
  
  function Float4.xzz() as Float3
    return( Float3( x, z, z ) )
  end function
  
  function Float4.yzz() as Float3
    return( Float3( y, z, z ) )
  end function
  
  function Float4.zzz() as Float3
    return( Float3( z, z, z ) )
  end function
  
  function Float4.wzz() as Float3
    return( Float3( w, z, z ) )
  end function
  
  function Float4.xwz() as Float3
    return( Float3( x, w, z ) )
  end function
  
  function Float4.ywz() as Float3
    return( Float3( y, w, z ) )
  end function
  
  function Float4.zwz() as Float3
    return( Float3( z, w, z ) )
  end function
  
  function Float4.wwz() as Float3
    return( Float3( w, w, z ) )
  end function
  
  function Float4.xxw() as Float3
    return( Float3( x, x, w ) )
  end function
  
  function Float4.yxw() as Float3
    return( Float3( y, x, w ) )
  end function
  
  function Float4.zxw() as Float3
    return( Float3( z, x, w ) )
  end function
  
  function Float4.wxw() as Float3
    return( Float3( w, x, w ) )
  end function
  
  function Float4.xyw() as Float3
    return( Float3( x, y, w ) )
  end function
  
  function Float4.yyw() as Float3
    return( Float3( y, y, w ) )
  end function
  
  function Float4.zyw() as Float3
    return( Float3( z, y, w ) )
  end function
  
  function Float4.wyw() as Float3
    return( Float3( w, y, w ) )
  end function
  
  function Float4.xzw() as Float3
    return( Float3( x, z, w ) )
  end function
  
  function Float4.yzw() as Float3
    return( Float3( y, z, w ) )
  end function
  
  function Float4.zzw() as Float3
    return( Float3( z, z, w ) )
  end function
  
  function Float4.wzw() as Float3
    return( Float3( w, z, w ) )
  end function
  
  function Float4.xww() as Float3
    return( Float3( x, w, w ) )
  end function
  
  function Float4.yww() as Float3
    return( Float3( y, w, w ) )
  end function
  
  function Float4.zww() as Float3
    return( Float3( z, w, w ) )
  end function
  
  function Float4.www() as Float3
    return( Float3( w, w, w ) )
  end function
  
  function Float4.xxxx() as Float4
    return( Float4( x, x, x, x ) )
  end function
  
  function Float4.yxxx() as Float4
    return( Float4( y, x, x, x ) )
  end function
  
  function Float4.zxxx() as Float4
    return( Float4( z, x, x, x ) )
  end function
  
  function Float4.wxxx() as Float4
    return( Float4( w, x, x, x ) )
  end function
  
  function Float4.xyxx() as Float4
    return( Float4( x, y, x, x ) )
  end function
  
  function Float4.yyxx() as Float4
    return( Float4( y, y, x, x ) )
  end function
  
  function Float4.zyxx() as Float4
    return( Float4( z, y, x, x ) )
  end function
  
  function Float4.wyxx() as Float4
    return( Float4( w, y, x, x ) )
  end function
  
  function Float4.xzxx() as Float4
    return( Float4( x, z, x, x ) )
  end function
  
  function Float4.yzxx() as Float4
    return( Float4( y, z, x, x ) )
  end function
  
  function Float4.zzxx() as Float4
    return( Float4( z, z, x, x ) )
  end function
  
  function Float4.wzxx() as Float4
    return( Float4( w, z, x, x ) )
  end function
  
  function Float4.xwxx() as Float4
    return( Float4( x, w, x, x ) )
  end function
  
  function Float4.ywxx() as Float4
    return( Float4( y, w, x, x ) )
  end function
  
  function Float4.zwxx() as Float4
    return( Float4( z, w, x, x ) )
  end function
  
  function Float4.wwxx() as Float4
    return( Float4( w, w, x, x ) )
  end function
  
  function Float4.xxyx() as Float4
    return( Float4( x, x, y, x ) )
  end function
  
  function Float4.yxyx() as Float4
    return( Float4( y, x, y, x ) )
  end function
  
  function Float4.zxyx() as Float4
    return( Float4( z, x, y, x ) )
  end function
  
  function Float4.wxyx() as Float4
    return( Float4( w, x, y, x ) )
  end function
  
  function Float4.xyyx() as Float4
    return( Float4( x, y, y, x ) )
  end function
  
  function Float4.yyyx() as Float4
    return( Float4( y, y, y, x ) )
  end function
  
  function Float4.zyyx() as Float4
    return( Float4( z, y, y, x ) )
  end function
  
  function Float4.wyyx() as Float4
    return( Float4( w, y, y, x ) )
  end function
  
  function Float4.xzyx() as Float4
    return( Float4( x, z, y, x ) )
  end function
  
  function Float4.yzyx() as Float4
    return( Float4( y, z, y, x ) )
  end function
  
  function Float4.zzyx() as Float4
    return( Float4( z, z, y, x ) )
  end function
  
  function Float4.wzyx() as Float4
    return( Float4( w, z, y, x ) )
  end function
  
  function Float4.xwyx() as Float4
    return( Float4( x, w, y, x ) )
  end function
  
  function Float4.ywyx() as Float4
    return( Float4( y, w, y, x ) )
  end function
  
  function Float4.zwyx() as Float4
    return( Float4( z, w, y, x ) )
  end function
  
  function Float4.wwyx() as Float4
    return( Float4( w, w, y, x ) )
  end function
  
  function Float4.xxzx() as Float4
    return( Float4( x, x, z, x ) )
  end function
  
  function Float4.yxzx() as Float4
    return( Float4( y, x, z, x ) )
  end function
  
  function Float4.zxzx() as Float4
    return( Float4( z, x, z, x ) )
  end function
  
  function Float4.wxzx() as Float4
    return( Float4( w, x, z, x ) )
  end function
  
  function Float4.xyzx() as Float4
    return( Float4( x, y, z, x ) )
  end function
  
  function Float4.yyzx() as Float4
    return( Float4( y, y, z, x ) )
  end function
  
  function Float4.zyzx() as Float4
    return( Float4( z, y, z, x ) )
  end function
  
  function Float4.wyzx() as Float4
    return( Float4( w, y, z, x ) )
  end function
  
  function Float4.xzzx() as Float4
    return( Float4( x, z, z, x ) )
  end function
  
  function Float4.yzzx() as Float4
    return( Float4( y, z, z, x ) )
  end function
  
  function Float4.zzzx() as Float4
    return( Float4( z, z, z, x ) )
  end function
  
  function Float4.wzzx() as Float4
    return( Float4( w, z, z, x ) )
  end function
  
  function Float4.xwzx() as Float4
    return( Float4( x, w, z, x ) )
  end function
  
  function Float4.ywzx() as Float4
    return( Float4( y, w, z, x ) )
  end function
  
  function Float4.zwzx() as Float4
    return( Float4( z, w, z, x ) )
  end function
  
  function Float4.wwzx() as Float4
    return( Float4( w, w, z, x ) )
  end function
  
  function Float4.xxwx() as Float4
    return( Float4( x, x, w, x ) )
  end function
  
  function Float4.yxwx() as Float4
    return( Float4( y, x, w, x ) )
  end function
  
  function Float4.zxwx() as Float4
    return( Float4( z, x, w, x ) )
  end function
  
  function Float4.wxwx() as Float4
    return( Float4( w, x, w, x ) )
  end function
  
  function Float4.xywx() as Float4
    return( Float4( x, y, w, x ) )
  end function
  
  function Float4.yywx() as Float4
    return( Float4( y, y, w, x ) )
  end function
  
  function Float4.zywx() as Float4
    return( Float4( z, y, w, x ) )
  end function
  
  function Float4.wywx() as Float4
    return( Float4( w, y, w, x ) )
  end function
  
  function Float4.xzwx() as Float4
    return( Float4( x, z, w, x ) )
  end function
  
  function Float4.yzwx() as Float4
    return( Float4( y, z, w, x ) )
  end function
  
  function Float4.zzwx() as Float4
    return( Float4( z, z, w, x ) )
  end function
  
  function Float4.wzwx() as Float4
    return( Float4( w, z, w, x ) )
  end function
  
  function Float4.xwwx() as Float4
    return( Float4( x, w, w, x ) )
  end function
  
  function Float4.ywwx() as Float4
    return( Float4( y, w, w, x ) )
  end function
  
  function Float4.zwwx() as Float4
    return( Float4( z, w, w, x ) )
  end function
  
  function Float4.wwwx() as Float4
    return( Float4( w, w, w, x ) )
  end function
  
  function Float4.xxxy() as Float4
    return( Float4( x, x, x, y ) )
  end function
  
  function Float4.yxxy() as Float4
    return( Float4( y, x, x, y ) )
  end function
  
  function Float4.zxxy() as Float4
    return( Float4( z, x, x, y ) )
  end function
  
  function Float4.wxxy() as Float4
    return( Float4( w, x, x, y ) )
  end function
  
  function Float4.xyxy() as Float4
    return( Float4( x, y, x, y ) )
  end function
  
  function Float4.yyxy() as Float4
    return( Float4( y, y, x, y ) )
  end function
  
  function Float4.zyxy() as Float4
    return( Float4( z, y, x, y ) )
  end function
  
  function Float4.wyxy() as Float4
    return( Float4( w, y, x, y ) )
  end function
  
  function Float4.xzxy() as Float4
    return( Float4( x, z, x, y ) )
  end function
  
  function Float4.yzxy() as Float4
    return( Float4( y, z, x, y ) )
  end function
  
  function Float4.zzxy() as Float4
    return( Float4( z, z, x, y ) )
  end function
  
  function Float4.wzxy() as Float4
    return( Float4( w, z, x, y ) )
  end function
  
  function Float4.xwxy() as Float4
    return( Float4( x, w, x, y ) )
  end function
  
  function Float4.ywxy() as Float4
    return( Float4( y, w, x, y ) )
  end function
  
  function Float4.zwxy() as Float4
    return( Float4( z, w, x, y ) )
  end function
  
  function Float4.wwxy() as Float4
    return( Float4( w, w, x, y ) )
  end function
  
  function Float4.xxyy() as Float4
    return( Float4( x, x, y, y ) )
  end function
  
  function Float4.yxyy() as Float4
    return( Float4( y, x, y, y ) )
  end function
  
  function Float4.zxyy() as Float4
    return( Float4( z, x, y, y ) )
  end function
  
  function Float4.wxyy() as Float4
    return( Float4( w, x, y, y ) )
  end function
  
  function Float4.xyyy() as Float4
    return( Float4( x, y, y, y ) )
  end function
  
  function Float4.yyyy() as Float4
    return( Float4( y, y, y, y ) )
  end function
  
  function Float4.zyyy() as Float4
    return( Float4( z, y, y, y ) )
  end function
  
  function Float4.wyyy() as Float4
    return( Float4( w, y, y, y ) )
  end function
  
  function Float4.xzyy() as Float4
    return( Float4( x, z, y, y ) )
  end function
  
  function Float4.yzyy() as Float4
    return( Float4( y, z, y, y ) )
  end function
  
  function Float4.zzyy() as Float4
    return( Float4( z, z, y, y ) )
  end function
  
  function Float4.wzyy() as Float4
    return( Float4( w, z, y, y ) )
  end function
  
  function Float4.xwyy() as Float4
    return( Float4( x, w, y, y ) )
  end function
  
  function Float4.ywyy() as Float4
    return( Float4( y, w, y, y ) )
  end function
  
  function Float4.zwyy() as Float4
    return( Float4( z, w, y, y ) )
  end function
  
  function Float4.wwyy() as Float4
    return( Float4( w, w, y, y ) )
  end function
  
  function Float4.xxzy() as Float4
    return( Float4( x, x, z, y ) )
  end function
  
  function Float4.yxzy() as Float4
    return( Float4( y, x, z, y ) )
  end function
  
  function Float4.zxzy() as Float4
    return( Float4( z, x, z, y ) )
  end function
  
  function Float4.wxzy() as Float4
    return( Float4( w, x, z, y ) )
  end function
  
  function Float4.xyzy() as Float4
    return( Float4( x, y, z, y ) )
  end function
  
  function Float4.yyzy() as Float4
    return( Float4( y, y, z, y ) )
  end function
  
  function Float4.zyzy() as Float4
    return( Float4( z, y, z, y ) )
  end function
  
  function Float4.wyzy() as Float4
    return( Float4( w, y, z, y ) )
  end function
  
  function Float4.xzzy() as Float4
    return( Float4( x, z, z, y ) )
  end function
  
  function Float4.yzzy() as Float4
    return( Float4( y, z, z, y ) )
  end function
  
  function Float4.zzzy() as Float4
    return( Float4( z, z, z, y ) )
  end function
  
  function Float4.wzzy() as Float4
    return( Float4( w, z, z, y ) )
  end function
  
  function Float4.xwzy() as Float4
    return( Float4( x, w, z, y ) )
  end function
  
  function Float4.ywzy() as Float4
    return( Float4( y, w, z, y ) )
  end function
  
  function Float4.zwzy() as Float4
    return( Float4( z, w, z, y ) )
  end function
  
  function Float4.wwzy() as Float4
    return( Float4( w, w, z, y ) )
  end function
  
  function Float4.xxwy() as Float4
    return( Float4( x, x, w, y ) )
  end function
  
  function Float4.yxwy() as Float4
    return( Float4( y, x, w, y ) )
  end function
  
  function Float4.zxwy() as Float4
    return( Float4( z, x, w, y ) )
  end function
  
  function Float4.wxwy() as Float4
    return( Float4( w, x, w, y ) )
  end function
  
  function Float4.xywy() as Float4
    return( Float4( x, y, w, y ) )
  end function
  
  function Float4.yywy() as Float4
    return( Float4( y, y, w, y ) )
  end function
  
  function Float4.zywy() as Float4
    return( Float4( z, y, w, y ) )
  end function
  
  function Float4.wywy() as Float4
    return( Float4( w, y, w, y ) )
  end function
  
  function Float4.xzwy() as Float4
    return( Float4( x, z, w, y ) )
  end function
  
  function Float4.yzwy() as Float4
    return( Float4( y, z, w, y ) )
  end function
  
  function Float4.zzwy() as Float4
    return( Float4( z, z, w, y ) )
  end function
  
  function Float4.wzwy() as Float4
    return( Float4( w, z, w, y ) )
  end function
  
  function Float4.xwwy() as Float4
    return( Float4( x, w, w, y ) )
  end function
  
  function Float4.ywwy() as Float4
    return( Float4( y, w, w, y ) )
  end function
  
  function Float4.zwwy() as Float4
    return( Float4( z, w, w, y ) )
  end function
  
  function Float4.wwwy() as Float4
    return( Float4( w, w, w, y ) )
  end function
  
  function Float4.xxxz() as Float4
    return( Float4( x, x, x, z ) )
  end function
  
  function Float4.yxxz() as Float4
    return( Float4( y, x, x, z ) )
  end function
  
  function Float4.zxxz() as Float4
    return( Float4( z, x, x, z ) )
  end function
  
  function Float4.wxxz() as Float4
    return( Float4( w, x, x, z ) )
  end function
  
  function Float4.xyxz() as Float4
    return( Float4( x, y, x, z ) )
  end function
  
  function Float4.yyxz() as Float4
    return( Float4( y, y, x, z ) )
  end function
  
  function Float4.zyxz() as Float4
    return( Float4( z, y, x, z ) )
  end function
  
  function Float4.wyxz() as Float4
    return( Float4( w, y, x, z ) )
  end function
  
  function Float4.xzxz() as Float4
    return( Float4( x, z, x, z ) )
  end function
  
  function Float4.yzxz() as Float4
    return( Float4( y, z, x, z ) )
  end function
  
  function Float4.zzxz() as Float4
    return( Float4( z, z, x, z ) )
  end function
  
  function Float4.wzxz() as Float4
    return( Float4( w, z, x, z ) )
  end function
  
  function Float4.xwxz() as Float4
    return( Float4( x, w, x, z ) )
  end function
  
  function Float4.ywxz() as Float4
    return( Float4( y, w, x, z ) )
  end function
  
  function Float4.zwxz() as Float4
    return( Float4( z, w, x, z ) )
  end function
  
  function Float4.wwxz() as Float4
    return( Float4( w, w, x, z ) )
  end function
  
  function Float4.xxyz() as Float4
    return( Float4( x, x, y, z ) )
  end function
  
  function Float4.yxyz() as Float4
    return( Float4( y, x, y, z ) )
  end function
  
  function Float4.zxyz() as Float4
    return( Float4( z, x, y, z ) )
  end function
  
  function Float4.wxyz() as Float4
    return( Float4( w, x, y, z ) )
  end function
  
  function Float4.xyyz() as Float4
    return( Float4( x, y, y, z ) )
  end function
  
  function Float4.yyyz() as Float4
    return( Float4( y, y, y, z ) )
  end function
  
  function Float4.zyyz() as Float4
    return( Float4( z, y, y, z ) )
  end function
  
  function Float4.wyyz() as Float4
    return( Float4( w, y, y, z ) )
  end function
  
  function Float4.xzyz() as Float4
    return( Float4( x, z, y, z ) )
  end function
  
  function Float4.yzyz() as Float4
    return( Float4( y, z, y, z ) )
  end function
  
  function Float4.zzyz() as Float4
    return( Float4( z, z, y, z ) )
  end function
  
  function Float4.wzyz() as Float4
    return( Float4( w, z, y, z ) )
  end function
  
  function Float4.xwyz() as Float4
    return( Float4( x, w, y, z ) )
  end function
  
  function Float4.ywyz() as Float4
    return( Float4( y, w, y, z ) )
  end function
  
  function Float4.zwyz() as Float4
    return( Float4( z, w, y, z ) )
  end function
  
  function Float4.wwyz() as Float4
    return( Float4( w, w, y, z ) )
  end function
  
  function Float4.xxzz() as Float4
    return( Float4( x, x, z, z ) )
  end function
  
  function Float4.yxzz() as Float4
    return( Float4( y, x, z, z ) )
  end function
  
  function Float4.zxzz() as Float4
    return( Float4( z, x, z, z ) )
  end function
  
  function Float4.wxzz() as Float4
    return( Float4( w, x, z, z ) )
  end function
  
  function Float4.xyzz() as Float4
    return( Float4( x, y, z, z ) )
  end function
  
  function Float4.yyzz() as Float4
    return( Float4( y, y, z, z ) )
  end function
  
  function Float4.zyzz() as Float4
    return( Float4( z, y, z, z ) )
  end function
  
  function Float4.wyzz() as Float4
    return( Float4( w, y, z, z ) )
  end function
  
  function Float4.xzzz() as Float4
    return( Float4( x, z, z, z ) )
  end function
  
  function Float4.yzzz() as Float4
    return( Float4( y, z, z, z ) )
  end function
  
  function Float4.zzzz() as Float4
    return( Float4( z, z, z, z ) )
  end function
  
  function Float4.wzzz() as Float4
    return( Float4( w, z, z, z ) )
  end function
  
  function Float4.xwzz() as Float4
    return( Float4( x, w, z, z ) )
  end function
  
  function Float4.ywzz() as Float4
    return( Float4( y, w, z, z ) )
  end function
  
  function Float4.zwzz() as Float4
    return( Float4( z, w, z, z ) )
  end function
  
  function Float4.wwzz() as Float4
    return( Float4( w, w, z, z ) )
  end function
  
  function Float4.xxwz() as Float4
    return( Float4( x, x, w, z ) )
  end function
  
  function Float4.yxwz() as Float4
    return( Float4( y, x, w, z ) )
  end function
  
  function Float4.zxwz() as Float4
    return( Float4( z, x, w, z ) )
  end function
  
  function Float4.wxwz() as Float4
    return( Float4( w, x, w, z ) )
  end function
  
  function Float4.xywz() as Float4
    return( Float4( x, y, w, z ) )
  end function
  
  function Float4.yywz() as Float4
    return( Float4( y, y, w, z ) )
  end function
  
  function Float4.zywz() as Float4
    return( Float4( z, y, w, z ) )
  end function
  
  function Float4.wywz() as Float4
    return( Float4( w, y, w, z ) )
  end function
  
  function Float4.xzwz() as Float4
    return( Float4( x, z, w, z ) )
  end function
  
  function Float4.yzwz() as Float4
    return( Float4( y, z, w, z ) )
  end function
  
  function Float4.zzwz() as Float4
    return( Float4( z, z, w, z ) )
  end function
  
  function Float4.wzwz() as Float4
    return( Float4( w, z, w, z ) )
  end function
  
  function Float4.xwwz() as Float4
    return( Float4( x, w, w, z ) )
  end function
  
  function Float4.ywwz() as Float4
    return( Float4( y, w, w, z ) )
  end function
  
  function Float4.zwwz() as Float4
    return( Float4( z, w, w, z ) )
  end function
  
  function Float4.wwwz() as Float4
    return( Float4( w, w, w, z ) )
  end function
  
  function Float4.xxxw() as Float4
    return( Float4( x, x, x, w ) )
  end function
  
  function Float4.yxxw() as Float4
    return( Float4( y, x, x, w ) )
  end function
  
  function Float4.zxxw() as Float4
    return( Float4( z, x, x, w ) )
  end function
  
  function Float4.wxxw() as Float4
    return( Float4( w, x, x, w ) )
  end function
  
  function Float4.xyxw() as Float4
    return( Float4( x, y, x, w ) )
  end function
  
  function Float4.yyxw() as Float4
    return( Float4( y, y, x, w ) )
  end function
  
  function Float4.zyxw() as Float4
    return( Float4( z, y, x, w ) )
  end function
  
  function Float4.wyxw() as Float4
    return( Float4( w, y, x, w ) )
  end function
  
  function Float4.xzxw() as Float4
    return( Float4( x, z, x, w ) )
  end function
  
  function Float4.yzxw() as Float4
    return( Float4( y, z, x, w ) )
  end function
  
  function Float4.zzxw() as Float4
    return( Float4( z, z, x, w ) )
  end function
  
  function Float4.wzxw() as Float4
    return( Float4( w, z, x, w ) )
  end function
  
  function Float4.xwxw() as Float4
    return( Float4( x, w, x, w ) )
  end function
  
  function Float4.ywxw() as Float4
    return( Float4( y, w, x, w ) )
  end function
  
  function Float4.zwxw() as Float4
    return( Float4( z, w, x, w ) )
  end function
  
  function Float4.wwxw() as Float4
    return( Float4( w, w, x, w ) )
  end function
  
  function Float4.xxyw() as Float4
    return( Float4( x, x, y, w ) )
  end function
  
  function Float4.yxyw() as Float4
    return( Float4( y, x, y, w ) )
  end function
  
  function Float4.zxyw() as Float4
    return( Float4( z, x, y, w ) )
  end function
  
  function Float4.wxyw() as Float4
    return( Float4( w, x, y, w ) )
  end function
  
  function Float4.xyyw() as Float4
    return( Float4( x, y, y, w ) )
  end function
  
  function Float4.yyyw() as Float4
    return( Float4( y, y, y, w ) )
  end function
  
  function Float4.zyyw() as Float4
    return( Float4( z, y, y, w ) )
  end function
  
  function Float4.wyyw() as Float4
    return( Float4( w, y, y, w ) )
  end function
  
  function Float4.xzyw() as Float4
    return( Float4( x, z, y, w ) )
  end function
  
  function Float4.yzyw() as Float4
    return( Float4( y, z, y, w ) )
  end function
  
  function Float4.zzyw() as Float4
    return( Float4( z, z, y, w ) )
  end function
  
  function Float4.wzyw() as Float4
    return( Float4( w, z, y, w ) )
  end function
  
  function Float4.xwyw() as Float4
    return( Float4( x, w, y, w ) )
  end function
  
  function Float4.ywyw() as Float4
    return( Float4( y, w, y, w ) )
  end function
  
  function Float4.zwyw() as Float4
    return( Float4( z, w, y, w ) )
  end function
  
  function Float4.wwyw() as Float4
    return( Float4( w, w, y, w ) )
  end function
  
  function Float4.xxzw() as Float4
    return( Float4( x, x, z, w ) )
  end function
  
  function Float4.yxzw() as Float4
    return( Float4( y, x, z, w ) )
  end function
  
  function Float4.zxzw() as Float4
    return( Float4( z, x, z, w ) )
  end function
  
  function Float4.wxzw() as Float4
    return( Float4( w, x, z, w ) )
  end function
  
  function Float4.yyzw() as Float4
    return( Float4( y, y, z, w ) )
  end function
  
  function Float4.zyzw() as Float4
    return( Float4( z, y, z, w ) )
  end function
  
  function Float4.wyzw() as Float4
    return( Float4( w, y, z, w ) )
  end function
  
  function Float4.xzzw() as Float4
    return( Float4( x, z, z, w ) )
  end function
  
  function Float4.yzzw() as Float4
    return( Float4( y, z, z, w ) )
  end function
  
  function Float4.zzzw() as Float4
    return( Float4( z, z, z, w ) )
  end function
  
  function Float4.wzzw() as Float4
    return( Float4( w, z, z, w ) )
  end function
  
  function Float4.xwzw() as Float4
    return( Float4( x, w, z, w ) )
  end function
  
  function Float4.ywzw() as Float4
    return( Float4( y, w, z, w ) )
  end function
  
  function Float4.zwzw() as Float4
    return( Float4( z, w, z, w ) )
  end function
  
  function Float4.wwzw() as Float4
    return( Float4( w, w, z, w ) )
  end function
  
  function Float4.xxww() as Float4
    return( Float4( x, x, w, w ) )
  end function
  
  function Float4.yxww() as Float4
    return( Float4( y, x, w, w ) )
  end function
  
  function Float4.zxww() as Float4
    return( Float4( z, x, w, w ) )
  end function
  
  function Float4.wxww() as Float4
    return( Float4( w, x, w, w ) )
  end function
  
  function Float4.xyww() as Float4
    return( Float4( x, y, w, w ) )
  end function
  
  function Float4.yyww() as Float4
    return( Float4( y, y, w, w ) )
  end function
  
  function Float4.zyww() as Float4
    return( Float4( z, y, w, w ) )
  end function
  
  function Float4.wyww() as Float4
    return( Float4( w, y, w, w ) )
  end function
  
  function Float4.xzww() as Float4
    return( Float4( x, z, w, w ) )
  end function
  
  function Float4.yzww() as Float4
    return( Float4( y, z, w, w ) )
  end function
  
  function Float4.zzww() as Float4
    return( Float4( z, z, w, w ) )
  end function
  
  function Float4.wzww() as Float4
    return( Float4( w, z, w, w ) )
  end function
  
  function Float4.xwww() as Float4
    return( Float4( x, w, w, w ) )
  end function
  
  function Float4.ywww() as Float4
    return( Float4( y, w, w, w ) )
  end function
  
  function Float4.zwww() as Float4
    return( Float4( z, w, w, w ) )
  end function
  
  function Float4.wwww() as Float4
    return( Float4( w, w, w, w ) )
  end function
  
  /'
    Returns the squared length of this vector
    
    Useful when you just want to compare which one is bigger,
    as this avoids having to compute a square root.
  '/
  function Float4.squaredLength() as float
    return( x * x + y * y + z * z )
  end function
  
  '' Returns the length of this vector
  function Float4.length() as float
    return( sqr( x * x + y * y + z * z ) )
  end function
  
  /'
    Normalizes the vector.
    
    Note that the homogeneous coordinate (w) is not to be touched
    here.
  '/
  sub Float4.normalize()
    dim as float _
      l => length()
    
    if( l > 0.0 )then
      x /=> l : y /=> l : z /=> l
    end if
  end sub
  
  /'
    Returns this vector normalized but without altering itself
    again the homogeneous coordinate is left alone
  '/
  function Float4.normalized() as Float4
    dim as float _
      l => sqr( x ^ 2 + y ^ 2 + z ^ 2 )
    
    if( l > 0.0 ) then
      return( Float4( x / l, y / l, z / l, w ) )
    else
      return( Float4( x, y, z, w ) )
    end if
  end function
  
  /'
    Homogeneizes the vector
    
    This is done by dividing the components by the homogeneous
    coordinate (w).
  '/
  sub Float4.homogeneize()
    x /=> w : y /=> w : z /=> w : w /=> w
  end sub
  
  /'
    Returns this vector homogeneized but without altering it
  '/
  function Float4.homogeneous() as Float4
    return( Float4( x / w, y / w, z / w, w / w ) )
  end function
  
  /'
    Returns the dot product (aka scalar product) of this
    vector and vector v.
  '/
  function Float4.dot( _
    byref v as Float4 ) as float
    return( v.x * x + v.y * y + v.z * z )
  end function
  
  /'
    Returns the cross product (aka vectorial product) of this
    vector and another vector v.
    Note that there's no cross product defined for a 4 tuple, so
    we simply use a standard 3d cross product, and make the w
    component 1 since the cross product is, indeed, a vector.
  '/
  function Float4.cross( _
    byref v as Float4 ) as Float4
    
    return( Float4( _
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
  function _
    Float4.distance( _
      byref v as Float4 ) _
    as float
    
    return( sqr( _
      ( v.x - x ) ^ 2 + _
      ( v.y - y ) ^ 2 + _
      ( v.z - z ) ^ 2 ) )
  end function
  
  /'
    Gets the squared distance of this vector with
    another. Useful to compare distances.
  '/
  function _
    Float4.squaredDistance( _
      byref v as Float4 ) _
    as float
    
    return( _
      ( v.x - x ) ^ 2 + _
      ( v.y - y ) ^ 2 + _
      ( v.z - z ) ^ 2 )
  end function
  
  operator - ( _
    byref v as Float4, byref w as Float4 ) as Float4
    
    return( Float4( v.x - w.x, v.y - w.y, v.z - w.z ) )
  end operator
  
  operator - ( _
    byref v as Float4 ) as Float4
    
    return( Float4( -v.x, -v.y, -v.z ) )
  end operator
  
  operator + ( _
    byref v as Float4, byref w as Float4 ) as Float4
    
    return( Float4( v.x + w.x, v.y + w.y, v.z + w.z ) )
  end operator
  
  operator _
    * ( _
      byref v as Float4, _
      byref w as Float4 ) _
    as Float4
    
    return( Float4( _
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
    byref v as Float4, byref s as float ) as Float4
    
    return( Float4( v.x * s, v.y * s, v.z * s ) )
  end operator
  
  '' Same as above but with the parameters inversed
  operator * ( _
    byref s as float, byref v as Float4 ) as Float4
    
    return( Float4( v.x * s, v.y * s, v.z * s ) )
  end operator
  
  '' Division by a scalar. See note above on multiplying a vector
  operator / ( _
    byref v as Float4, byref s as float ) as Float4
    
    return( Float4( v.x / s, v.y / s, v.z / s ) )
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
