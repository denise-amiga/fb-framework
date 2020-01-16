#ifndef __FBFW_MATH_MAT4__
#define __FBFW_MATH_MAT4__

namespace Math
  /'
                      | a b c d |
    4x4 Matrix type   | e f g h |
                      | i j k l |
                      | m n o p |
    
    9/30/2017
      Improved 4x4 matrix inverse calculation. With -gen gcc -Ofast
        (the settings I always use) it is more than 60% faster than the previous
        version. A byproduct of correcting the bug mentioned below.
    9/29/2017
      Fixed determinant calculation (it was erroneously computed).
        The funny thing was that this library is used in various applications,
        including my 3D engine and various tools. When I was implementing a
        feature, it kept doing weird things, and the bug was finally tracked to
        an erroneous calculation of the determinant. The determinant was
        correctly calculated in the 3x3 matrix code, but when I ported the code
        to use OpenGL for rendering, it didn't worked as intended. Goes to show
        you that one is to be extra careful with the math code, as it is the
        foundation of the entire game engine.
      
        The calculations were cross checked with the help of this online resource:
        
          https://www.mathsisfun.com/algebra/matrix-calculator.html
        
        which has a very neat matrix calculator for various dimensions.
  '/
  type Mat4
    public:
      declare constructor()
      declare constructor( _
        byval as float => 0.0, byval as float => 0.0, byval as float => 0.0, byval as float => 0.0, _
        byval as float => 0.0, byval as float => 0.0, byval as float => 0.0, byval as float => 0.0, _
        byval as float => 0.0, byval as float => 0.0, byval as float => 0.0, byval as float => 0.0, _
        byval as float => 0.0, byval as float => 0.0, byval as float => 0.0, byval as float => 0.0 )
      declare constructor( _
        byref as Mat4 )
      declare constructor( _
        byref as Mat3 )
      
      declare operator _
        let( byref rhs as Mat4 )
      declare operator _
        cast() as string
      
      declare static function _
        fromEuler( _
          byval as float, _
          byval as float, _
          byval as float ) as Mat4
      declare static function _
        fromEuler( _
          byref as Float3 ) as Mat4
      declare static function _
        identity() as Mat4
      declare static function _
        empty() as Mat4
      declare static function _
        translation( _
          byref as Float3 ) as Mat4
      declare static function _
        translation( _
          byref as Float4 ) as Mat4
      declare static function _
        scaling( _
          byval as float ) as Mat4
      declare static function _
        scaling( _
          byref as Float3 ) as Mat4
      declare static function _
        scaling( _
          byref as Float3, _
          byref as Float3 ) as Mat4
      declare static function _
        scaling( _
          byref as Float4 ) as Mat4
      declare static function _
        scaling( _
          byref as Float4, _
          byref as Float4 ) as Mat4
      declare static function _
        rotation( _
          byref as Float3 ) as Mat4
      declare static function _
        rotation( _
          byref as Float4 ) as Mat4
        
      declare function _
        determinant() as float
      declare sub _
        transpose()
      declare function _
        transposed() as Mat4
      declare sub _
        inverse()
      declare function _
        inversed() as Mat4
      
      declare sub _
        toIdentity()
      declare sub _
        toEmpty()
      
      as float _
        a, b, c, d, _
        e, f, g, h, _
        i, j, k, l, _
        m, n, o, p
  end type
  
  /'
    The default constructor creates an identity matrix,
    instead of a matrix of zeros. This is usually far
    more useful.
  '/
  constructor _
    Mat4()
  
    a => 1.0 : b => 0.0 : c => 0.0 : d => 0.0
    e => 0.0 : f => 1.0 : g => 0.0 : h => 0.0
    i => 0.0 : j => 0.0 : k => 1.0 : l => 0.0
    m => 0.0 : n => 0.0 : o => 0.0 : p => 1.0
  end constructor
  
  constructor _
    Mat4( _
      byval xx as float => 0.0, byval yx as float => 0.0, byval zx as float => 0.0, byval wx as float => 0.0, _
      byval xy as float => 0.0, byval yy as float => 0.0, byval zy as float => 0.0, byval wy as float => 0.0, _
      byval xz as float => 0.0, byval yz as float => 0.0, byval zz as float => 0.0, byval wz as float => 0.0, _
      byval xw as float => 0.0, byval yw as float => 0.0, byval zw as float => 0.0, byval ww as float => 0.0 )
    
    a => xx : b => yx : c => zx : d => wx
    e => xy : f => yy : g => zy : h => wy
    i => xz : j => yz : k => zz : l => wz
    m => xw : n => yw : o => zw : p => ww
  end constructor
  
  constructor _
    Mat4( _
      byref rhs as Mat4 )
    
    a => rhs.a : b => rhs.b : c => rhs.c : d => rhs.d
    e => rhs.e : f => rhs.f : g => rhs.g : h => rhs.h
    i => rhs.i : j => rhs.j : k => rhs.k : l => rhs.l
    m => rhs.m : n => rhs.n : o => rhs.o : p => rhs.p
  end constructor
  
  constructor _
    Mat4( _
      byref aM as Mat3 )
    
    a => aM.a : b => aM.b : c => aM.c : d => 0.0
    e => aM.d : f => aM.e : g => aM.f : h => 0.0
    i => aM.g : j => aM.h : k => aM.i : l => 0.0
    m =>  0.0 : n =>  0.0 : o =>  0.0 : p => 1.0
  end constructor
  
  operator _
    Mat4.let( _
      byref rhs as Mat4 )
    
    a => rhs.a : b => rhs.b : c => rhs.c : d => rhs.d
    e => rhs.e : f => rhs.f : g => rhs.g : h => rhs.h
    i => rhs.i : j => rhs.j : k => rhs.k : l => rhs.l
    m => rhs.m : n => rhs.n : o => rhs.o : p => rhs.p
  end operator
  
  '' The matrix in a human readable form (very useful for debugging purposes)
  operator _
    Mat4.cast() _
    as string
    
    return( _
      "| " & trim( str( a ) ) & " | " & trim( str( b ) ) & " | " & trim( str( c ) ) & " | " & trim( str( d ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( e ) ) & " | " & trim( str( f ) ) & " | " & trim( str( g ) ) & " | " & trim( str( h ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( i ) ) & " | " & trim( str( j ) ) & " | " & trim( str( k ) ) & " | " & trim( str( l ) ) & " |" & chr( 13 ) & chr( 10 ) & _
      "| " & trim( str( m ) ) & " | " & trim( str( n ) ) & " | " & trim( str( o ) ) & " | " & trim( str( p ) ) & " |" & chr( 13 ) & chr( 10 ) )
  end operator
  
  function _
    Mat4.fromEuler( _
      byval aX as float, _
      byval aY as float, _
      byval aZ as float ) _
    as Mat4
    
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
    
    return( Mat4( _
                      cY * cZ,                -cY * sZ,       sY, 0.0, _
       sX * sY * cZ + cX * sZ, -sX * sY * sZ + cX * cZ, -sX * cY, 0.0, _
      -cX * sY * cZ + sX * sZ,  cX * sY * sZ + sX * cZ,  cX * cY, 0.0, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat4.fromEuler( _
      byref angles as Float3 ) _
    as Mat4
    
    return( Mat4.fromEuler( _
      angles.x, angles.y, angles.z ) )
  end function
  
  function _
    Mat4.identity() _
    as Mat4
    
    return( Mat4( _
      1.0, 0.0, 0.0, 0.0, _
      0.0, 1.0, 0.0, 0.0, _
      0.0, 0.0, 1.0, 0.0, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat4.empty() _
    as Mat4
    
    return( Mat4( _
      0.0, 0.0, 0.0, 0.0, _
      0.0, 0.0, 0.0, 0.0, _
      0.0, 0.0, 0.0, 0.0, _
      0.0, 0.0, 0.0, 0.0 ) )
  end function
  
  function _
    Mat4.translation( _
      byref t as Float3 ) _
    as Mat4
    
    return( Mat4( _
      1.0, 0.0, 0.0, t.x, _
      0.0, 1.0, 0.0, t.y, _
      0.0, 0.0, 1.0, t.z, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat4.translation( _
      byref t as Float4 ) _
    as Mat4
    
    return( Mat4( _
      1.0, 0.0, 0.0, t.x, _
      0.0, 1.0, 0.0, t.y, _
      0.0, 0.0, 1.0, t.z, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat4.scaling( _
      byval s as float ) _
    as Mat4
    
    return( Mat4( _
        s, 0.0, 0.0, 0.0, _
      0.0,   s, 0.0, 0.0, _
      0.0, 0.0,   s, 0.0, _
      0.0, 0.0, 0.0,   s ) )
  end function
  
  function _
    Mat4.scaling( _
      byref s as Float3 ) _
    as Mat4
    
    return( Mat4( _
      s.x, 0.0, 0.0, 0.0, _
      0.0, s.y, 0.0, 0.0, _
      0.0, 0.0, s.z, 0.0, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat4.scaling( _
      byref s as Float4 ) _
    as Mat4
    
    return( Mat4( _
      s.x, 0.0, 0.0, 0.0, _
      0.0, s.y, 0.0, 0.0, _
      0.0, 0.0, s.z, 0.0, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat4.scaling( _
      byref s as Float3, _
      byref o as Float3 ) _
    as Mat4
  
    return( Mat4( _
      s.x, 0.0, -o.x * s.x + o.x, 0.0, _
      0.0, s.y, -o.y * s.y + o.y, 0.0, _
      0.0, 0.0, -o.z * s.z + o.z, 0.0, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat4.scaling( _
      byref s as Float4, _
      byref o as Float4 ) _
    as Mat4
  
    return( Mat4( _
      s.x, 0.0, -o.x * s.x + o.x, 0.0, _
      0.0, s.y, -o.y * s.y + o.y, 0.0, _
      0.0, 0.0, -o.z * s.z + o.z, 0.0, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat4.rotation( _
      byref angles as Float3 ) _
    as Mat4
    
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
    
    return( Mat4( _
                      cY * cZ,                -cY * sZ,       sY, 0.0, _
       sX * sY * cZ + cX * sZ, -sX * sY * sZ + cX * cZ, -sX * cY, 0.0, _
      -cX * sY * cZ + sX * sZ,  cX * sY * sZ + sX * cZ,  cX * cY, 0.0, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  function _
    Mat4.rotation( _
      byref angles as Float4 ) _
    as Mat4
    
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
    
    return( Mat4( _
                      cY * cZ,                -cY * sZ,       sY, 0.0, _
       sX * sY * cZ + cX * sZ, -sX * sY * sZ + cX * cZ, -sX * cY, 0.0, _
      -cX * sY * cZ + sX * sZ,  cX * sY * sZ + sX * cZ,  cX * cY, 0.0, _
      0.0, 0.0, 0.0, 1.0 ) )
  end function
  
  /'
    Computes the determinant of a 4x4 matrix using Laplace Cofactor
    Expansion.
    
    The determinant of a 3x3 matrix is:
      a * ( e * i - f * h ) - b * ( d * i - f * g ) + c * ( d * h - e * g )
    
    Whereas the 4x4 matrix determinant is given by:
    
      a *         b *         c *         d *
      | f g h |   | e g h |   | e f h |   | e f g |
      | j k l | - | i k l | + | i j l | - | i j k |
      | n o p |   | m o p |   | m n p |   | m n o |
      
      where the '|' means the determinant of the inner 3x3 matrices.
      Note that the cofactors are already factored in the calculation.
      
    The determinant is thus:
      + ( a * ( f * ( k * p - l * o ) - g * ( j * p - l * n ) + h * ( j * o - k * n ) ) )
      - ( b * ( e * ( k * p - l * o ) - g * ( i * p - l * m ) + h * ( i * o - k * m ) ) )
      + ( c * ( e * ( j * p - l * n ) - f * ( i * p - l * m ) + h * ( i * n - j * m ) ) )
      - ( d * ( e * ( j * o - k * n ) - f * ( i * o - k * m ) + g * ( i * n - j * m ) ) )
    
  '/
  function _
    Mat4.determinant() _
    as float
    
    dim as float _
      det => _
          ( a * ( f * ( k * p - l * o ) - g * ( j * p - l * n ) + h * ( j * o - k * n ) ) ) _
        - ( b * ( e * ( k * p - l * o ) - g * ( i * p - l * m ) + h * ( i * o - k * m ) ) ) _
        + ( c * ( e * ( j * p - l * n ) - f * ( i * p - l * m ) + h * ( i * n - j * m ) ) ) _
        - ( d * ( e * ( j * o - k * n ) - f * ( i * o - k * m ) + g * ( i * n - j * m ) ) )
    /'
      This isn't matematically correct, just a programmer's dirty hack.
      if the determinant of a matrix is 0, it means it has no inverse. In the
      code for calculating the inverse, a division by the determinant is performed;
      and if it is zero, a division by zero is performed on *every* element of
      the matrix, filling it with positive or negative infinity values and rendering
      it useless. A matrix without inverse is the matrix itself, so setting the
      determinant value to 1 does the trick.
    '/
    if( det = 0.0 ) then
      det => 1.0
    end if
    
    return( det )
  end function
  
  /'
    Transposes the matrix
    
      [ a b c d ]T    [ a e i m ]
      [ e f g h ]  =  [ b f j n ]
      [ i j k l ]     [ c g k o ]
      [ m n o p ]     [ d h l p ]
  '/
  sub _
    Mat4.transpose()
    
    this => Mat4( _
      a, e, i, m, _
      b, f, j, n, _
      c, g, k, o, _
      d, h, l, p )
  end sub
  
  function _
    Mat4.transposed() _
    as Mat4
    
    return( Mat4( _
      a, e, i, m, _
      b, f, j, n, _
      c, g, k, o, _
      d, h, l, p ) )
  end function
  
  /'
    Computes the inverse of a 4x4 matrix
    
    This version is 60%+ faster and 400%+ uglier than the previous
    version. It was made so by computing the determinant inside the
    method and recycling as much calculation as possible.
  '/
  sub _
    Mat4.inverse()
    
    '' List of 2x2 determinants
    dim as float _
      kplo => k * p - l * o, _
      jpln => j * p - l * n, _
      jokn => j * o - k * n, _
      iplm => i * p - l * m, _
      iokm => i * o - k * m, _
      injm => i * n - j * m, _
      gpho => g * p - h * o, _
      fphn => f * p - h * n, _
      fogn => f * o - g * n, _
      ephm => e * p - h * m, _
      eogm => e * o - g * m, _
      enfm => e * n - f * m, _
      glhk => g * l - h * k, _
      flhj => f * l - h * j, _
      fkgj => f * k - g * j, _
      elhi => e * l - h * i, _
      ekgi => e * k - g * i, _
      ejfi => e * j - f * i
  
    '' List of 3x3 determinants
    dim as float _
      d1kplo => f * kplo, _
      d1jpln => g * jpln, _
      d1jokn => h * jokn, _
      d2kplo => e * kplo, _
      d2iplm => g * iplm, _
      d2iokm => h * iokm, _
      d3jpln => e * jpln, _
      d3iplm => f * iplm, _
      d3injm => h * injm, _
      d4jokn => e * jokn, _
      d4iokm => f * iokm, _
      d4injm => g * injm, _
      d5kplo => b * kplo, _
      d5jpln => c * jpln, _
      d5jokn => d * jokn, _
      d6kplo => a * kplo, _
      d6iplm => c * iplm, _
      d6iokm => d * iokm, _
      d7jpln => a * jpln, _
      d7iplm => b * iplm, _
      d7injm => d * injm, _
      d8jokn => a * jokn, _
      d8iokm => b * iokm, _
      d8injm => c * injm, _
      d9gpho => b * gpho, _
      d9fphn => c * fphn, _
      d9fogn => d * fogn, _
      d10gpho => a * gpho, _
      d10ephm => c * ephm, _
      d10eogm => d * eogm, _
      d11fphn => a * fphn, _
      d11ephm => b * ephm, _
      d11enfm => d * enfm, _
      d12fogn => a * fogn, _
      d12eogm => b * eogm, _
      d12enfm => c * enfm, _
      d13glhk => b * glhk, _
      d13flhj => c * flhj, _
      d13fkgj => d * fkgj, _
      d14glhk => a * glhk, _
      d14elhi => c * elhi, _
      d14ekgi => d * ekgi, _
      d15flhj => a * flhj, _
      d15elhi => b * elhi, _
      d15ejfi => d * ejfi, _
      d16fkgj => a * fkgj, _
      d16ekgi => b * ekgi, _
      d16ejfi => c * ejfi
    
    '' 4x4 determinant (inversed)
    dim as float _
      det => _
          ( a * ( d1kplo - d1jpln + d1jokn ) _
        - ( b * ( d2kplo - d2iplm + d2iokm ) ) _
        + ( c * ( d3jpln - d3iplm + d3injm ) ) _
        - ( d * ( d4jokn - d4iokm + d4injm ) ) )
    
    '' If the determinant is 0, the matrix has no inverse
    if( det = 0 ) then
      exit sub
    end if
    
    '' Multiplying with the reciprocal is faster than dividing
    dim as float _
      invDet => 1.0 / det
    
    '' Minors
    dim as float _
      Ma => d1kplo - d1jpln + d1jokn, _
      Mb => d2kplo - d2iplm + d2iokm, _
      Mc => d3jpln - d3iplm + d3injm, _
      Md => d4jokn - d4iokm + d4injm, _
      Me => d5kplo - d5jpln + d5jokn, _
      Mf => d6kplo - d6iplm + d6iokm, _
      Mg => d7jpln - d7iplm + d7injm, _
      Mh => d8jokn - d8iokm + d8injm, _
      Mi => d9gpho - d9fphn + d9fogn, _
      Mj => d10gpho - d10ephm + d10eogm, _
      Mk => d11fphn - d11ephm + d11enfm, _
      Ml => d12fogn - d12eogm + d12enfm, _
      Mm => d13glhk - d13flhj + d13fkgj, _
      Mn => d14glhk - d14elhi + d14ekgi, _
      Mo => d15flhj - d15elhi + d15ejfi, _
      Mp => d16fkgj - d16ekgi + d16ejfi
    
    /'
      Adjugate (the adjugate is the transpose of the cofactored matrix
      of minors).
       
       Ma  -Me   Mi  -Mm
      -Mb   Mf  -Mj   Mn
       Mc  -Mg   Mk  -Mo
      -Md   Mh  -Ml   Mp
    '/
    this => Mat4( _
       Ma * invDet, -Me * invDet,  Mi * invDet, -Mm * invDet, _
      -Mb * invDet,  Mf * invDet, -Mj * invDet,  Mn * invDet, _
       Mc * invDet, -Mg * invDet,  Mk * invDet, -Mo * invDet, _
      -Md * invDet,  Mh * invDet, -Ml * invDet,  Mp * invDet )
  end sub
  
  function _
    Mat4.inversed() _
    as Mat4
    
    var _
      inv => this
    
    inv.inverse()
    
    return( inv )
  end function
  
  sub _
    Mat4.toIdentity()
    
    a => 1.0 : b => 0.0 : c => 0.0 : d => 0.0
    e => 0.0 : f => 1.0 : g => 0.0 : h => 0.0
    i => 0.0 : j => 0.0 : k => 1.0 : l => 0.0
    m => 0.0 : n => 0.0 : o => 0.0 : p => 1.0
  end sub
  
  sub _
    Mat4.toEmpty()
  
    a => 0.0 : b => 0.0 : c => 0.0 : d => 0.0
    e => 0.0 : f => 0.0 : g => 0.0 : h => 0.0
    i => 0.0 : j => 0.0 : k => 0.0 : l => 0.0
    m => 0.0 : n => 0.0 : o => 0.0 : p => 0.0
  end sub
  
  /'
    Multiply two 4x4 matrices
    
    Remember that matrix multiplication is not commutative!
      A * B != B * A
  '/
  operator * ( _
    byref A as Mat4, byref B as Mat4 ) as Mat4
    return( Mat4( _
      A.a * B.a + A.b * B.e + A.c * B.i + A.d * B.m, _
      A.a * B.b + A.b * B.f + A.c * B.j + A.d * B.n, _
      A.a * B.c + A.b * B.g + A.c * B.k + A.d * B.o, _
      A.a * B.d + A.b * B.h + A.c * B.l + A.d * B.p, _
      A.e * B.a + A.f * B.e + A.g * B.i + A.h * B.m, _
      A.e * B.b + A.f * B.f + A.g * B.j + A.h * B.n, _
      A.e * B.c + A.f * B.g + A.g * B.k + A.h * B.o, _
      A.e * B.d + A.f * B.h + A.g * B.l + A.h * B.p, _
      A.i * B.a + A.j * B.e + A.k * B.i + A.l * B.m, _
      A.i * B.b + A.j * B.f + A.k * B.j + A.l * B.n, _
      A.i * B.c + A.j * B.g + A.k * B.k + A.l * B.o, _
      A.i * B.d + A.j * B.h + A.k * B.l + A.l * B.p, _
      A.m * B.a + A.n * B.e + A.o * B.i + A.p * B.m, _
      A.m * B.b + A.n * B.f + A.o * B.j + A.p * B.n, _
      A.m * B.c + A.n * B.g + A.o * B.k + A.p * B.o, _
      A.m * B.d + A.n * B.h + A.o * B.l + A.p * B.p _
    ) )
  end operator
  
  '' Adds two 4x4 matrices
  operator + ( _
    byref A as Mat4, byref B as Mat4 ) as Mat4
    
    return( Mat4( _
      A.a + B.a, A.b + B.b, A.c + B.c, A.d + B.d, _
      A.e + B.e, A.f + B.f, A.g + B.g, A.h + B.h, _
      A.i + B.i, A.j + B.j, A.k + B.k, A.l + B.l, _
      A.m + B.m, A.n + B.n, A.o + B.o, A.p + B.p ) )
  end operator
  
  '' Substracts two 4x4 matrices
  operator - ( _
    byref A as Mat4, byref B as Mat4 ) as Mat4
    
    return( Mat4( _
      A.a - B.a, A.b - B.b, A.c - B.c, A.d - B.d, _
      A.e - B.e, A.f - B.f, A.g - B.g, A.h - B.h, _
      A.i - B.i, A.j - B.j, A.k - B.k, A.l - B.l, _
      A.m - B.m, A.n - B.n, A.o - B.o, A.p - B.p ) )
  end operator
  
  '' Negates the matrix
  operator - ( _
    byref A as Mat4 ) as Mat4
    
    return( Mat4( _
      -A.a, -A.b, -A.c, -A.d, _
      -A.e, -A.f, -A.g, -A.h, _
      -A.i, -A.j, -A.k, -A.l, _
      -A.m, -A.n, -A.o, -A.p ) )
  end operator
  
  '' Scalar multiplication
  operator * ( _
    byref A as Mat4, byref s as float ) as Mat4
    
    return( Mat4( _
      A.a * s, A.b * s, A.c * s, A.d * s, _
      A.e * s, A.f * s, A.g * s, A.h * s, _
      A.i * s, A.j * s, A.k * s, A.l * s, _
      A.m * s, A.n * s, A.o * s, A.p * s ) )
  end operator
  
  '' Scalar multiplication
  operator * ( _
    byref s as float, byref A as Mat4 ) as Mat4
    
    return( Mat4( _
      A.a * s, A.b * s, A.c * s, A.d * s, _
      A.e * s, A.f * s, A.g * s, A.h * s, _
      A.i * s, A.j * s, A.k * s, A.l * s, _
      A.m * s, A.n * s, A.o * s, A.p * s ) )
  end operator
  
  /'
    Scalar divide
    
      The 'division' of a matrix by another matrix is not defined, the
      equivalent operation is multiplying one matrix by the inverse of
      the other on scalars though it can be defined also like this,
      mostly for convenience purposes.
  '/
  operator / ( _
    byref s as float, byref A as Mat4 ) as Mat4
    
    return( Mat4( _
      A.a / s, A.b / s, A.c / s, A.d / s, _
      A.e / s, A.f / s, A.g / s, A.h / s, _
      A.i / s, A.j / s, A.k / s, A.l / s, _
      A.m / s, A.n / s, A.o / s, A.p / s ) )
  end operator
  
  operator / ( _
    byref A as Mat4, byref s as float ) as Mat4
    
    return( Mat4( _
      A.a / s, A.b / s, A.c / s, A.d / s, _
      A.e / s, A.f / s, A.g / s, A.h / s, _
      A.i / s, A.j / s, A.k / s, A.l / s, _
      A.m / s, A.n / s, A.o / s, A.p / s ) )
  end operator
  
  /'
    Multiply a vector with a row matrix, resulting in a row vector.
      
      A row vector looks like this:
      
      | x y z w |
      
      and is the format that Direct3D uses. What this means, code-wise,
      is that you have to pre-multiply the vectors with the matrices,
      and some other stuff, like transposing the matrices if you are
      using column vectors (as this library does).
  '/
  operator * ( _
    byref v as Float4, byref A as Mat4 ) as Float4
    
    return( Float4( _ 
      A.a * v.x + A.e * v.y + A.i * v.z + A.m * v.w, _
      A.b * v.x + A.f * v.y + A.j * v.z + A.n * v.w, _
      A.c * v.x + A.g * v.y + A.k * v.z + A.o * v.w, _
      A.d * v.x + A.h * v.y + A.l * v.z + A.p * v.w ) )
  end operator
  
  /'
    Multiply a vector with a column matrix, resulting in a column
    vector.
    
      A column vector looks like this
      
      | x |
      | y |
      | z |
      | w |
      
      and is the format favored by OpenGL. In this library, column
      vectors are used for direct compatibility with it.
  '/
  operator * ( _
    byref A as Mat4, byref v as Float4 ) as Float4
    
    return( Float4( _
      A.a * v.X + A.b * v.Y + A.c * v.Z + A.d * v.w, _
      A.e * v.X + A.f * v.Y + A.g * v.Z + A.h * v.w, _
      A.i * v.X + A.j * v.Y + A.k * v.Z + A.l * v.w, _
      A.m * v.X + A.n * v.Y + A.o * v.Z + A.p * v.w ) )
  end operator
  
  '' Returns the inverse of the provided matrix      
  function inverse( _
    byval M as Mat4 ) as Mat4
    
    M.inverse()
    
    return( M )
  end function
end namespace

#endif
