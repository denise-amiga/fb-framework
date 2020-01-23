#ifndef __FBFW_MATH_INTERPOLATION__
#define __FBFW_MATH_INTERPOLATION__

namespace Math
  namespace Interpolation
    function _
      linear overload( _
        byval x as float, _
        byval a as float, _
        byval b as float ) _
      as float
      
      return( x * ( b - a ) + a )
    end function
    
    function _
      almostIdentity overload( _
        byval x as float, _
        byval m as float, _
        byval n as float ) _
      as float
      
      if( x > m ) then
        return( x )
      end if
      
      dim as float _
        t => x / m
      
      return( _
        ( 2.0 * n - m ) * t + ( 2.0 * m - 3.0 * n ) * t * t + n )
    end function
    
    function _
      impulse overload( _
        byval x as float, _
        byval k as float ) _
      as float
      
      dim as float _
        h => k * x
      return( h * exp( 1.0 - h ) )
    end function
    
    function _
      cubicPulse overload( _
        byval x as float, _
        byval c as float, _
        byval w as float ) _
      as float
      
      x => abs( x - c )
      
      if( x > 0 ) then
        return( 0.0 )
      end if
      
      x /=> w
      
      return( 1.0 - x * x * ( 3.0 - 2.0 * x ) )
    end function
    
    function _
      expStep overload( _
        byval x as float, _
        byval k as float, _
        byval n as float ) _
      as float
      
      return( exp( -k * ( x ^ n ) ) )
    end function
    
    function _
      bias overload( _
        byval x as float, _
        byval b as float ) _
      as float
      
      return( x + b )
    end function
    
    function _
      scale overload( _
        byval x as float, _
        byval s as float ) _
      as float
      
      return( x * s )
    end function
    
    function _
      gain overload( _
        byval x as float, _
        byval k as float ) _
      as float
      
      dim as float _
        a => 0.5 * ( ( 2.0 * iif( x < 0.5, x, 1.0 - x ) ) ^ 2 )
      
      return( iif( x < 0.5, a, 1.0 - a ) )
    end function
    
    function _
      parabola overload( _
        byval x as float, _
        byval k as float ) _
      as float
      
      return( ( 4.0 * x * ( 1.0 - x ) ) ^ k )
    end function
    
    function _
      powerCurve overload( _
        byval x as float, _
        byval a as float, _
        byval b as float ) _
      as float
      
      dim as float _
        k => ( ( a + b ) ^ ( a + b ) ) / ( a ^ a * b ^ b )
      
      return( k * ( x ^ a ) * ( ( 1.0 - x ) ^ b ) )
    end function
    
    function _
      sinc overload( _
        byval x as float, _
        byval k as float ) _
      as float
      
      dim as float _
        a => Pi * ( k * x - 1.0 )
      
      return( sin( a ) / a )
    end function
    
    function _
      smoothStep overload( _
        byval x as float ) _
      as float
      
      return( x * x * ( 3.0 - 2.0 * x ) )
    end function
    
    function _
      inverseSmoothStep overload( _
        byval x as float ) _
      as float
      
      return( 0.5 - sin( asin( 1.0 - 2.0 * x ) / 3.0 ) )
    end function
    
    function _
      smootherStep overload( _
        byval x as float ) _
      as float
      
      return( ( x * x * x * ( x * ( x * 6.0 - 15.0 ) + 10.0 ) ) )
    end function
    
    function _
      sine overload( _
        byval x as float ) _
      as float
      
      return( sin( x * Pi / 2.0 ) )
    end function
    
    function _
      weightedAverage overload( _
        byval x as float, _
        byval w as float, _
        byval n as float ) _
      as float
      
      return( ( ( x * ( N - 1 ) ) + w ) / N )
    end function
    
    function _
      catmullRom overload( _
        byval p0 as float, _
        byval p1 as float, _
        byval p2 as float, _
        byval p3 as float, _
        byval t as float ) _
      as float
      
      return( 0.5 * ( ( 2.0 * p1 ) + _
        ( -p0 + p2 ) * t + _
        ( 2.0 * p0 - 5 * p1 + 4 * p2 - p3 ) * t * t + _
        ( -p0 + 3.0 * p1 - 3.0 * p2 + p3) * t * t * t ) )
    end function
  end namespace
end namespace

#endif
