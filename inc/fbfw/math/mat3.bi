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
  type mat3
    public:			
      declare constructor()
      declare constructor(_
        byval xx as float, byval yx as float, byval zx as float, _
        byval xy as float, byval yy as float, byval zy as float, _
        byval xz as float, byval yz as float, byval zz as float )
      
      declare constructor( _
        byref as mat3 )
      
      declare operator let( _
        byref as mat3 )
      
      declare sub transpose()
      declare function determinant() as float
      declare sub inverse()
      declare sub identity()
      
      declare operator cast() as string
      
      as float a, b, c
      as float d, e, f
      as float g, h, i
  end type
  
  constructor mat3() 
    /'
      The default constructor creates an identity matrix,
      instead of a matrix of zeros. This is usually far
      more useful.
    '/
    a = 1.0: b = 0.0: c = 0.0
    d = 0.0: e = 1.0: f = 0.0
    g = 0.0: h = 0.0: i = 1.0
  end constructor
  
  constructor mat3( _
    byval na as float, byval nb as float, byval nc as float, _
    byval nd as float, byval ne as float, byval nf as float, _
    byval ng as float, byval nh as float, byval ni as float ) 
												
    a = na: b = nb: c = nc
    d = nd: e = ne: f = nf
    g = ng: h = nh: i = ni
  end constructor
  
  constructor mat3( _
    byref rhs as mat3 ) 
    
    a = rhs.a: b = rhs.b: c = rhs.c
    d = rhs.d: e = rhs.e: f = rhs.f
    g = rhs.g: h = rhs.h: i = rhs.i	
  end constructor
  
  operator mat3.let( _
    byref rhs as mat3 ) 
    
    a = rhs.a: b = rhs.b: c = rhs.c
    d = rhs.d: e = rhs.e: f = rhs.f
    g = rhs.g: h = rhs.h: i = rhs.i
  end operator
  
  sub mat3.transpose() 
    /'
      Transpose:
    
      | a b c |T    | a d g |
      | d e f |  =  | b e h |
      | g h i |     | c f i |
    '/
    b += d: d = b - d: b -= d '' swap b and d
    c += g: g = c - g: c -= g '' swap c and g
    f += h: h = f - h: f -= h '' swap f and h
  end sub
  
  function transpose( _
    byval A as mat3 ) as mat3 
    
    A.transpose()
    
    return( A )
  end function
  
  function mat3.determinant() as float 
    '' Computes the determinant of the matrix
    dim as float det = _ 
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
      det = 1.0
    end if
    
    return( det )
  end function
  
  function determinant( _
    byval A as mat3 ) as float 
    
    return( A.determinant() )
  end function
  
  sub mat3.inverse() 
    /'
      Computes the inverse of a 3x3 matrix.
      The inverse is the adjoint divided through the determinant
    '/
    dim as float det = determinant()
  
    '' If the determinant is 0, the matrix has no inverse
    dim as float rDet = 1.0 / det
    
    /'
      Included in these calculations: minors, cofactor (changed signs),
      transpose and division through determinant (expressed here by
      multiplying by the reciprocal of the determinant). This method of
      computing the inverse of a matrix is called Laplace Cofactor
      Expansion.
    '/
    dim as mat3 INV = mat3( _
      (  e * i - h * f ) * rDet, ( -b * i + h * c ) * rDet, (  b * f - e * c ) * rDet, _
      ( -d * i + g * f ) * rDet, (  a * i - g * c ) * rDet, ( -a * f + d * c ) * rDet, _
      (  d * h - g * e ) * rDet, ( -a * h + g * b ) * rDet, (  a * e - d * b ) * rDet )
  
    '' Set this matrix to the computed inverse
    this = INV
  end sub
  
  function inverse overload( _
    byval M as mat3 ) as mat3 
    
    M.inverse()
    
    return( M )
  end function
  
  sub mat3.identity() 
    '' Make the matrix an identity matrix
    a = 1.0: b = 0.0: c = 0.0
    d = 0.0: e = 1.0: f = 0.0
    g = 0.0: h = 0.0: i = 1.0
  end sub
  
  operator mat3.cast() as string 
  '' This is only to obtain a human readable representation of the matrix
    return( _
      "| " & trim( str( a ) ) & " | " & trim( str( b ) ) & " | " & trim( str( c ) ) & " |" & chr( 10 ) & chr( 13 ) & _
      "| " & trim( str( d ) ) & " | " & trim( str( e ) ) & " | " & trim( str( f ) ) & " |" & chr( 10 ) & chr( 13 ) & _
      "| " & trim( str( g ) ) & " | " & trim( str( h ) ) & " | " & trim( str( i ) ) & " |" )
  end operator
  
  operator + ( _
    byref A as mat3, byref B as mat3 ) as mat3 
    
    '' Adds two matrices
    return( mat3( _
      A.a + B.a, A.b + B.b, A.c + B.c, _
      A.d + B.d, A.e + B.e, A.f + B.f, _
      A.g + B.g, A.h + B.h, A.i + B.i ) )
  end operator
  
  operator - ( _
    byref A as mat3, byref B as mat3 ) as mat3 
    
    '' Substracts two matrices
    return( mat3( _
      A.a - B.a, A.b - B.b, A.c - B.c, _
      A.d - B.d, A.e - B.e, A.f - B.f, _
      A.g - B.g, A.h - B.h, A.i - B.i ) )
  end operator
  
  operator * ( _
    byref A as mat3, byref s as float ) as mat3 
    
    '' Multiply a matrix with a scalar
    return( mat3( _
      A.a * s, A.b * s, A.c * s, _
      A.d * s, A.e * s, A.f * s, _
      A.g * s, A.h * s, A.i * s ) )
  end operator
  
  operator * ( _
    byref s as float, byref A as mat3 ) as mat3 
    
    '' Multiply a matrix with a scalar    
    return( mat3( _
      A.a * s, A.b * s, A.c * s, _
      A.d * s, A.e * s, A.f * s, _
      A.g * s, A.h * s, A.i * s ) )
  end operator
  
  operator * ( _
    byref A as mat3, byref B as mat3 ) as mat3 
    
    '' Multiply two matrices
    return( mat3( _
      A.a * B.a + A.b * B.d + A.c * B.g, A.a * B.b + A.b * B.e + A.c * B.h, A.a * B.c + A.b * B.f + A.c * B.i, _
      A.d * B.a + A.e * B.d + A.f * B.g, A.d * B.b + A.e * B.e + A.f * B.h, A.d * B.c + A.e * B.f + A.f * B.i, _
      A.g * B.a + A.h * B.d + A.i * B.g, A.g * B.b + A.h * B.e + A.i * B.h, A.g * B.c + A.h * B.f + A.i * B.i ) )
  end operator
  
  operator * ( _
    byref A as mat3, byref v as float3 ) as float3 
    
    '' Multiply a matrix with a column vector, resulting in a column vector
    return( float3( _
      A.a * v.x + A.b * v.y + A.c * v.z, _
      A.d * v.x + A.e * v.y + A.f * v.z, _
      A.g * v.x + A.h * v.y + A.i * v.z ) )  
  end operator
  
  operator * ( _
    byref v as float3, byref A as mat3 ) as float3 
    
    '' Multiply a vector with a row matrix, resulting in a row vector
    return( float3( _
      A.a * v.x + A.d * v.y + A.g * v.z, A.b * v.x + A.e * v.y + A.h * v.z, A.c * v.x + A.f * v.y + A.i * v.z ) )
  end operator
  
  /'
    Same as above, but for a Float2. Note that the vector is multiplied as it were
    a homogeneous 2D vector internally.
  '/
  operator * ( _
    byref A as mat3, byref v as Float2 ) as Float2
    
    var _
      p => A * Float3( v.x, v.y, 1.0 )
    
    return( p.xy )
  end operator
  
  operator * ( _
    byref v as Float2, byref A as mat3 ) as Float2
    
    var _
      p => Float3( v.x, v.y, 1.0 ) * A
    
    return( p.xy )
  end operator
  
  
  operator / ( _
    byref A as mat3, byref s as float ) as mat3 
    
    '' Divide a matrix trough a scalar
    return( mat3( _
      A.a / s, A.b / s, A.c / s, _ 
      A.d / s, A.e / s, A.f / s, _
      A.g / s, A.h / s, A.i / s ) )
  end operator
end namespace

#endif