#ifndef __FBFW_MATH_MAT3__
#define __FBFW_MATH_MAT3__

namespace Math
  /'
                    | a b c |
    3x3 Matrix type | d e f |
                    | g h i |
    
    Note that this type also defines operators to work with
    2D homogeneous vectors.
    
    08/28/2017
      Fixed typo in multiplication of two matrices
  '/	
  type Mat3
    public:			
      declare constructor()
      declare constructor(_
        byval as float, byval as float, byval as float, _
        byval as float, byval as float, byval as float, _
        byval as float, byval as float, byval as float )
      declare constructor( _
        byref as Mat3 )
      
      declare operator _
        let( _
          byref as Mat3 )
      declare operator _
        cast() as string
      
      declare static function _
        fromEuler( _
          byval as float, _
          byval as float, _
          byval as float ) as Mat3
      declare static function _
        fromEuler( _
          byref as Float3 ) as Mat3
      declare static function _
        identity() as Mat3
      declare static function _
        empty() as Mat3 
      declare static function _
        translation( _
          byref as Float2 ) as Mat3
      declare static function _
        translation( _
          byref as Float3 ) as Mat3
      declare static function _
        scaling( _
          byval as float ) as Mat3
      declare static function _
        scaling( _
          byref as Float2 ) as Mat3
      declare static function _
        scaling( _
          byref as Float2, _
          byref as Float2 ) as Mat3
      declare static function _
        scaling( _
          byref as Float3 ) as Mat3
      declare static function _
        scaling( _
          byref as Float3, _
          byref as Float3 ) as Mat3
      declare static function _
        rotation( _
          byval as float ) as Mat3
      declare static function _
        rotation( _
          byref as Float2, _
          byval as float ) as Mat3
      declare static function _
        rotation( _
          byref as Float3 ) as Mat3
      declare static function _
        rotation( _
          byref as Float3, _
          byval as float ) as Mat3
        
      declare function _
        determinant() as float
      declare sub _
        transpose()
      declare function _
        transposed() as Mat3
      declare sub _
        inverse()
      declare function _
        inversed() as Mat3
      declare sub _
        toIdentity()
      declare sub _
        toEmpty()
      
      as float _
        a, b, c, _
        d, e, f, _
        g, h, i
  end type
  
  /'
    The default constructor creates an identity matrix,
    instead of a matrix of zeros. This is usually far
    more useful.
  '/
  constructor _
    Mat3() 
    
    a => 1.0: b => 0.0: c => 0.0
    d => 0.0: e => 1.0: f => 0.0
    g => 0.0: h => 0.0: i => 1.0
  end constructor
  
  constructor _
    Mat3( _
      byval na as float, byval nb as float, byval nc as float, _
      byval nd as float, byval ne as float, byval nf as float, _
      byval ng as float, byval nh as float, byval ni as float )
     
    a => na: b => nb: c => nc
    d => nd: e => ne: f => nf
    g => ng: h => nh: i => ni
  end constructor
  
  constructor _
    Mat3( _
      byref rhs as Mat3 ) 
    
    a => rhs.a: b => rhs.b: c => rhs.c
    d => rhs.d: e => rhs.e: f => rhs.f
    g => rhs.g: h => rhs.h: i => rhs.i	
  end constructor
  
  operator _
    Mat3.let( _
      byref rhs as Mat3 ) 
    
    a => rhs.a: b => rhs.b: c => rhs.c
    d => rhs.d: e => rhs.e: f => rhs.f
    g => rhs.g: h => rhs.h: i => rhs.i
  end operator
  
  '' This is only to obtain a human readable representation of the matrix
  operator _
    Mat3.cast() _
    as string 
    
    return( _
      "| " & trim( str( a ) ) & " | " & trim( str( b ) ) & " | " & trim( str( c ) ) & " |" & chr( 10 ) & chr( 13 ) & _
      "| " & trim( str( d ) ) & " | " & trim( str( e ) ) & " | " & trim( str( f ) ) & " |" & chr( 10 ) & chr( 13 ) & _
      "| " & trim( str( g ) ) & " | " & trim( str( h ) ) & " | " & trim( str( i ) ) & " |" )
  end operator
  
  function _
    Mat3.fromEuler( _
      byval aX as float, _
      byval aY as float, _
      byval aZ as float ) _
    as Mat3
    
    '' Pitch
    dim as float _
      theta => Math.toRadians( aX )
    
    dim as float _
      sX => sin( theta ), _
      cX => cos( theta )
    
    '' Yaw
    theta => Math.toRadians( aY )
    
    dim as float _
      sY => sin( theta ), _
      cY => cos( theta )
    
    '' Roll
    theta => Math.toRadians( aZ )
    
    dim as float _
      sZ => sin( theta ), _
      cZ => cos( theta )
    
    return( Mat3( _
                      cY * cZ,                -cY * sZ,       sY, _
       sX * sY * cZ + cX * sZ, -sX * sY * sZ + cX * cZ, -sX * cY, _
      -cX * sY * cZ + sX * sZ,  cX * sY * sZ + sX * cZ,  cX * cY ) )
  end function
  
  function _
    Mat3.fromEuler( _
      byref angles as Float3 ) _
    as Mat3
    
    return( Mat3.fromEuler( _
      angles.x, angles.y, angles.z ) )
  end function
  
  function _
    Mat3.identity() _
    as Mat3
    
    return( _
      Mat3( _
        1.0, 0.0, 0.0, _
        0.0, 1.0, 0.0, _
        0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat3.empty() _
    as Mat3
    
    return( _
      Mat3( _
        0.0, 0.0, 0.0, _
        0.0, 0.0, 0.0, _
        0.0, 0.0, 0.0 ) )
  end function
  
  function _
    Mat3.translation( _
      byref t as Float2 ) _
    as Mat3
  
    return( Mat3( _
      1.0, 0.0, t.x, _
      0.0, 1.0, t.y, _
      0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat3.translation( _
      byref t as Float3 ) _
    as Mat3
    
    return( Mat3( _
      1.0, 0.0, t.x, _
      0.0, 1.0, t.y, _
      0.0, 0.0, t.z ) )
  end function
  
  function _
    Mat3.scaling( _
      byval s as float ) _
    as Mat3
    
    return( Mat3( _
        s, 0.0, 0.0, _
      0.0,   s, 0.0, _
      0.0, 0.0,   s ) )
  end function
  
  function _
    Mat3.scaling( _
      byref s as Float2 ) _
    as Mat3
    
    return( Mat3( _
      s.x, 0.0, 0.0, _
      0.0, s.y, 0.0, _
      0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat3.scaling( _
      byref s as Float2, _
      byref o as Float2 ) _
    as Mat3
    
    return( Mat3( _
      s.x, 0.0, -o.x * s.x + o.x, _
      0.0, s.y, -o.y * s.y + o.y, _
      0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat3.scaling( _
      byref s as Float3 ) _
    as Mat3
    
    return( Mat3( _
      s.x, 0.0, 0.0, _
      0.0, s.y, 0.0, _
      0.0, 0.0, s.z ) )
  end function
  
  function _
    Mat3.scaling( _
      byref s as Float3, _
      byref o as Float3 ) _
    as Mat3
    
    return( Mat3( _
      s.x, 0.0, -o.x * s.x + o.x, _
      0.0, s.y, -o.y * s.y + o.y, _
      0.0, 0.0, -o.z * s.z + o.z ) )
  end function
  
  function _
    Mat3.rotation( _
      byval angle as float ) _
    as Mat3
    
    dim as float _
      theta => Math.toRadians( angle ), _
      co => cos( theta ), _
      si => sin( theta )
    
    return( Mat3( _
        co,  -si, 0.0, _
        si,   co, 0.0, _
       0.0,  0.0, 1.0 ) )
  end function
  
  function _
    Mat3.rotation( _
      byref o as Float2, _
      byval angle as float ) _
    as Mat3
    
    dim as float _
      theta => Math.toRadians( angle ), _
      co => cos( theta ), _
      si => sin( theta )
    
    return( Mat3( _
       co, -si, -o.x * co + o.y * si + o.x, _
       si,  co, -o.x * si - o.y * co + o.y, _
      0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat3.rotation( _
      byref angles as Float3 ) _
    as Mat3
    
    '' X
    dim as float _
      theta => Math.toRadians( angles.x )
    
    dim as float _
      sx => sin( theta ), _
      cx => cos( theta )
    
    '' Y
    theta => Math.toRadians( angles.y )
    
    dim as float _
      sy => sin( theta ), _
      cy => cos( theta )
    
    '' Z
    theta => Math.toRadians( angles.z )
    
    dim as float _
      sz => sin( theta ), _
      cz => cos( theta )
    
    return( Mat3( _
                      cY * cZ,                -cY * sZ,       sY, _
       sX * sY * cZ + cX * sZ, -sX * sY * sZ + cX * cZ, -sX * cY, _
      -cX * sY * cZ + sX * sZ,  cX * sY * sZ + sX * cZ,  cX * cY ) )
  end function
  
  function _
    Mat3.rotation( _
      byref axis as Float3, _
      byval angle as float ) _
    as Mat3
    
    var _
      u => axis.normalized()
    
    dim as float _
      theta => Math.toRadians( angle ), _
      si => sin( theta ), _
      co => cos( theta ), _
      iCo => 1.0 - co
    
    return( Mat3( _
            co + u.x * u.x * iCo, u.x * u.y * iCo - u.z * si, u.x * u.z * iCo + u.y * si, _
      u.y * u.x * iCo + u.z * si,       co + u.y * u.y * iCo, u.y * u.z * iCo - u.x * si, _
      u.z * u.x * iCo - u.y * si, u.z * u.y * iCo + u.x * si,        co + u.z * u.z * iCo ) )
  end function
  
  '' Computes the determinant of the matrix
  function _
    Mat3.determinant() _
    as float 
    
    dim as float _
      det => _ 
        ( a * e * i _ 
        + b * f * g _
        + d * h * c _
        - g * e * c _
        - d * b * i _
        - h * f * a )
    
    /'    
      This is, of course, not matematically correct but it saves
      some comprobations when you're calculating the inverse of
      the matrix (and to avoid dividing by zero).
    '/
    if( det = 0.0 ) then
      det => 1.0
    end if
    
    return( det )
  end function
  
  /'
    Transpose:
  
    | a b c |T    | a d g |
    | d e f |  =  | b e h |
    | g h i |     | c f i |
  '/
  sub _
    Mat3.transpose() 
    
    b +=> d: d => b - d: b -=> d '' swap b and d
    c +=> g: g => c - g: c -=> g '' swap c and g
    f +=> h: h => f - h: f -=> h '' swap f and h
  end sub
  
  function _
    Mat3.transposed() _
    as Mat3
    
    return( Mat3( _
      a, d, g, _
      b, e, h, _
      c, f, i ) )
  end function
  
  /'
    Computes the inverse of a 3x3 matrix.
    The inverse is the adjoint divided through the determinant.
  '/
  sub _
    Mat3.inverse() 
    
    dim as float _
      det => determinant()
    
    '' If the determinant is 0, the matrix has no inverse
    dim as float _
      rDet => 1.0 / det
    
    /'
      Included in these calculations: minors, cofactor (changed signs),
      transpose and division through determinant (expressed here by
      multiplying by the reciprocal of the determinant). This method of
      computing the inverse of a matrix is called Laplace Cofactor
      Expansion.
    '/
    var _
      inv => Mat3( _
        (  e * i - h * f ) * rDet, ( -b * i + h * c ) * rDet, (  b * f - e * c ) * rDet, _
        ( -d * i + g * f ) * rDet, (  a * i - g * c ) * rDet, ( -a * f + d * c ) * rDet, _
        (  d * h - g * e ) * rDet, ( -a * h + g * b ) * rDet, (  a * e - d * b ) * rDet )
    
    '' Set this matrix to the computed inverse
    this => inv
  end sub
  
  function _
    Mat3.inversed() _
    as Mat3
    
    var _
      M => this
    
    M.inverse()
    
    return( M )
  end function
  
  '' Make the matrix an empty matrix
  sub _
    Mat3.toEmpty() 
    
    a => 0.0: b => 0.0: c => 0.0
    d => 0.0: e => 0.0: f => 0.0
    g => 0.0: h => 0.0: i => 0.0
  end sub
  
  '' Make the matrix an identity matrix
  sub _
    Mat3.toIdentity() 
    
    a => 1.0: b => 0.0: c => 0.0
    d => 0.0: e => 1.0: f => 0.0
    g => 0.0: h => 0.0: i => 1.0
  end sub
  
  '' Adds two matrices
  operator _
    + ( _
      byref A as Mat3, _
      byref B as Mat3 ) _
    as Mat3 
    
    return( Mat3( _
      A.a + B.a, A.b + B.b, A.c + B.c, _
      A.d + B.d, A.e + B.e, A.f + B.f, _
      A.g + B.g, A.h + B.h, A.i + B.i ) )
  end operator
  
  '' Substracts two matrices
  operator _
    - ( _
      byref A as Mat3, _
      byref B as Mat3 ) _
    as Mat3 
    
    return( Mat3( _
      A.a - B.a, A.b - B.b, A.c - B.c, _
      A.d - B.d, A.e - B.e, A.f - B.f, _
      A.g - B.g, A.h - B.h, A.i - B.i ) )
  end operator
  
  '' Multiply a matrix with a scalar
  operator _
    * ( _
      byref A as Mat3, _
      byref s as float ) _
    as Mat3 
    
    return( Mat3( _
      A.a * s, A.b * s, A.c * s, _
      A.d * s, A.e * s, A.f * s, _
      A.g * s, A.h * s, A.i * s ) )
  end operator
  
  '' Multiply a matrix with a scalar    
  operator _
    * ( _
      byref s as float, _
      byref A as Mat3 ) _
    as Mat3 
    
    return( Mat3( _
      A.a * s, A.b * s, A.c * s, _
      A.d * s, A.e * s, A.f * s, _
      A.g * s, A.h * s, A.i * s ) )
  end operator
  
  '' Multiply two matrices
  operator _
    * ( _
      byref A as Mat3, _
      byref B as Mat3 ) _
    as Mat3 
    
    return( Mat3( _
      A.a * B.a + A.b * B.d + A.c * B.g, A.a * B.b + A.b * B.e + A.c * B.h, A.a * B.c + A.b * B.f + A.c * B.i, _
      A.d * B.a + A.e * B.d + A.f * B.g, A.d * B.b + A.e * B.e + A.f * B.h, A.d * B.c + A.e * B.f + A.f * B.i, _
      A.g * B.a + A.h * B.d + A.i * B.g, A.g * B.b + A.h * B.e + A.i * B.h, A.g * B.c + A.h * B.f + A.i * B.i ) )
  end operator
  
  '' Multiply a matrix with a column vector, resulting in a column vector
  operator _
    * ( _
      byref A as Mat3, _
      byref v as Float3 ) _
    as Float3 
    
    return( Float3( _
      A.a * v.x + A.b * v.y + A.c * v.z, _
      A.d * v.x + A.e * v.y + A.f * v.z, _
      A.g * v.x + A.h * v.y + A.i * v.z ) )  
  end operator
  
  '' Multiply a vector with a row matrix, resulting in a row vector
  operator _
    * ( _
      byref v as Float3, _
      byref A as Mat3 ) _
    as Float3 
    
    return( Float3( _
      A.a * v.x + A.d * v.y + A.g * v.z, _
      A.b * v.x + A.e * v.y + A.h * v.z, _
      A.c * v.x + A.f * v.y + A.i * v.z ) )
  end operator
  
  /'
    Same as above, but for a Float2. Note that the vector is multiplied as it were
    a homogeneous 2D vector internally.
  '/
  operator _
    * ( _
      byref A as Mat3, _
      byref v as Float2 ) _
    as Float2
    
    var _
      p => A * Float3( v.x, v.y, 1.0 )
    
    return( p.xy )
  end operator
  
  operator _
    * ( _
      byref v as Float2, _
      byref A as Mat3 ) _
    as Float2
    
    var _
      p => Float3( v.x, v.y, 1.0 ) * A
    
    return( p.xy )
  end operator
  
  '' Divide a matrix trough a scalar
  operator _
    / ( _
      byref A as Mat3, _
      byref s as float ) _
    as Mat3 
    
    return( Mat3( _
      A.a / s, A.b / s, A.c / s, _ 
      A.d / s, A.e / s, A.f / s, _
      A.g / s, A.h / s, A.i / s ) )
  end operator
end namespace

#endif