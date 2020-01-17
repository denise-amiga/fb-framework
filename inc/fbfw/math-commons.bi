#ifndef __FBFW_MATH_COMMONS__
#define __FBFW_MATH_COMMONS__

/'
  Contains the common definitions, classes and functions used by the Math
  framework. Standalone so the definitions can be used from other places
  without including the entire Math framework.
'/
namespace Math
  /'
    This alias describes which precision we will be using for
    representing floating-point values.
  '/
  type as single _
    float
  
  /'
    Floating-point equality comparison
  '/
  #define fEq ( a, b ) _
    abs( a - b ) < FWCommons.Epsilon
  
  /'
    These types describe the units of angle measurement that the
    functions that deal with angles expect.
  '/
  type as float _
    radians, _
    degrees
  
  /'
    The Null pointer
  '/
  const as any ptr _
    Nil => 0
  
  /'
    Common mathematical constants and conversion factors
  '/
  const as float _
    Pi => 4.0 * atn( 1.0 ), _
    TwoPi => 2.0 * Pi, _
    HalfPi => Pi / 2.0, _
    Phi => ( 1.0 + sqr( 5.0 ) ) / 2.0, _
    Epsilon => 0.0001, _
    degToRad => Pi / 180.0, _
    radToDeg => 180.0 / Pi
  
  /'
    This is used to modulo-divide a floating point value. Useful
    because FreeBasic's MOD operator works only with integer types.
  '/
  function _
    fMod overload( _
      byval n as float, _
      byval d as float ) _
    as float
    
    return( n - int( n / d ) * d )
  end function
  
  '' Select the minimum of two values
  function _
    iMin overload( _
      byval a as integer, _
      byval b as integer ) _
    as integer
    
    return( iif( a < b, a, b ) )
  end function
  
  function _
    fMin( _
      byval a as float, _
      byval b as float ) _
    as float
    
    return( iif( a < b, a, b ) )
  end function
  
  '' Select the maximum of two values
  function _
    iMax overload( _
      byval a as integer, _
      byval b as integer ) _
    as integer
    
    return( iif( a > b, a, b ) )
  end function
  
  function _
    fMax( _
      byval a as float, _
      byval b as float ) _
    as float
    
    return( iif( a > b, a, b ) )
  end function
  
  '' Clamps a value 'v' between two values, 'a' and 'b'
  function _
    iClamp overload( _
      byval v as integer, _
      byval a as integer, _
      byval b as integer ) _
    as integer
    
    return( iMax( a, iMin( v, b ) ) )
  end function
  
  function _
    fClamp( _
      byval v as float, _
      byval a as float, _
      byval b as float ) _
    as float
    
    return( fMax( a, fMin( v, b ) ) )
  end function
  
  '' Wraps a value 'v' between two values, 'a' and 'b'
  function _
    iWrap overload( _
      byval v as integer, _
      byval a as integer, _
      byval b as integer ) _
    as integer
    
    return( _
      ( ( ( v - a ) mod ( b - a ) ) + ( b - a ) ) mod ( b - a ) + a )
  end function
  
  '' Same as above, but for floating-point values
  function _
    fWrap( _
      byval v as float, _
      byval a as float, _
      byval b as float ) _
    as float
    
    return( fMod( ( _
      fMod( ( v - a ), ( b - a ) ) + ( b - a  ) ), _
        ( b - a ) + a ) )
  end function
  
  /'
    Floor and ceiling for floating-point values
  '/
  function _
    floor( _
      byval n as float ) _
    as integer
    
    return( ( ( n ) * 2.0 - 0.5 ) shr 1 )
  end function
  
  function _
    ceil( _
      byval n as float ) _
    as integer
    
    return( _
      ( - ( ( - ( ( n ) * 2.0 - 0.5 ) shr 1 ) ) ) )
  end function
  
  /'
    Conversion functions for angles
  '/
  function _
    toRadians( _
      byval angle as degrees ) _
    as radians
    
    return( angle * degToRad )
  end function
  
  function _
    toDegrees( _
      byval angle as radians ) _
    as degrees
    
    return( angle * radToDeg )
  end function
end namespace

#include once "math/interpolation.bi"

#endif
