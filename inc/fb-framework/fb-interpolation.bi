#ifndef __FB_INTERPOLATION__
#define __FB_INTERPOLATION__

/'
  Framework for doing several common interpolations.
  
  Note that it defines all its symbols in the 'Math' namespace but it 
  does not depends on it.
'/
namespace Math
  namespace Interpolation
    #ifndef __const_Pi
      const as double _
        __const_Pi => 4.0 * atn( 1.0 )
    #endif
    
    function _
      linear overload( _
        byval x as double, _
        byval a as double, _
        byval b as double ) _
      as double
      
      return( x * ( b - a ) + a )
    end function
    
    function _
      bias overload( _
        byval x as double, _
        byval b as double ) _
      as double
      
      return( x + b )
    end function
    
    function _
      scale overload( _
        byval x as double, _
        byval s as double ) _
      as double
      
      return( x * s )
    end function
    
  'double almostIdentity( double x, double m, double n )
  '{
  '    if( x>m ) return x;
  '
  '    const double a = 2.0*n - m
  '    const double b = 2.0*m - 3.0*n;
  '    const double t = x/m;
  '
  '    return (a*t + b)*t*t + n;
  '}  
    function _
      almostIdentity overload( _
        byval x as double, _
        byval m as double, _
        byval n as double ) _
      as double
      
      if( x > m ) then
        return( x )
      end if
      
      dim as double _
        t => x / m
      
      return( _
        ( 2.0 * n - m ) * t + ( 2.0 * m - 3.0 * n ) * t * t + n )
    end function
    
    'double impulse( double k, double x )
    '{
    '    const double h = k*x;
    '    return h*exp(1.0-h);
    '}  
    function _
      impulse overload( _
        byval x as double, _
        byval k as double ) _
      as double
      
      dim as double _
        h => k * x
      
      return( h * exp( 1.0 - h ) )
    end function
    
    'double cubicPulse( double c, double w, double x )
    '{
    '    x = fabs(x - c);
    '    if( x>w ) return 0.0;
    '    x /= w;
    '    return 1.0 - x*x*(3.0-2.0*x);
    '}  
    function _
      cubicPulse overload( _
        byval x as double, _
        byval c as double, _
        byval w as double ) _
      as double
      
      x => abs( x - c )
      
      if( x > w ) then
        return( 0.0 )
      end if
      
      x /=> w
      
      return( 1.0 - x * x * ( 3.0 - 2.0 * x ) )
    end function
  
    'double expStep( double x, double k, double n )
    '{
    '    return exp( -k*pow(x,n) );
    '}
    function _
      expStep overload( _
        byval x as double, _
        byval k as double, _
        byval n as double ) _
      as double
      
      return( exp( -k * ( x ^ n ) ) )
    end function
    'double gain(double x, double k) 
    '{
        'double a = 0.5*pow(2.0*((x<0.5)?x:1.0-x), k);
    '    return (x<0.5)?a:1.0-a;
    '}
    function _
      gain overload( _
        byval x as double, _
        byval k as double ) _
      as double
      
      'double a = 0.5*pow(2.0*((x<0.5)?x:1.0-x), k);
      dim as double _
        a => 0.5 * ( ( 2.0 * iif( x < 0.5, x, 1.0 - x ) ) ^ k )
      
      return( iif( x < 0.5, a, 1.0 - a ) )
    end function
  
    'double parabola( double x, double k )
    '{
    '    return pow( 4.0*x*(1.0-x), k );
    '}  
    function _
      parabola overload( _
        byval x as double, _
        byval k as double ) _
      as double
      
      return( ( 4.0 * x * ( 1.0 - x ) ) ^ k )
    end function
  
    'double pcurve( double x, double a, double b )
    '{
    '    double k = pow(a+b,a+b) / (pow(a,a)*pow(b,b));
    '    return k * pow( x, a ) * pow( 1.0-x, b );
    '}  
    function _
      powerCurve overload( _
        byval x as double, _
        byval a as double, _
        byval b as double ) _
      as double
      
      dim as double _
        k => ( ( a + b ) ^ ( a + b ) ) / ( a ^ a * b ^ b )
      
      return( k * ( x ^ a ) * ( ( 1.0 - x ) ^ b ) )
    end function
    
    'double sinc( double x, double k )
    '{
    '    const double a = PI * ((double(k)*x-1.0);
    '    return sin(a)/a;
    '}
    function _
      sinc overload( _
        byval x as double, _
        byval k as double ) _
      as double
      
      dim as double _
        a => __const_Pi * ( k * x - 1.0 )
      
      return( sin( a ) / a )
    end function
    
    function _
      smoothStep overload( _
        byval x as double ) _
      as double
      
      return( x * x * ( 3.0 - 2.0 * x ) )
    end function
    
    function _
      smootherStep overload( _
        byval x as double ) _
      as double
      
      return( ( x * x * x * ( x * ( x * 6.0 - 15.0 ) + 10.0 ) ) )
    end function
    
    function _
      inverseSmoothStep overload( _
        byval x as double ) _
      as double
      
      return( 0.5 - sin( asin( 1.0 - 2.0 * x ) / 3.0 ) )
    end function
    
    function _
      sine overload( _
        byval x as double ) _
      as double
      
      return( sin( x * __const_Pi / 2.0 ) )
    end function
    
    function _
      weightedAverage overload( _
        byval x as double, _
        byval w as double, _
        byval n as double ) _
      as double
      
      return( ( ( x * ( n - 1.0 ) ) + w ) / n )
    end function
    
    function _
      catmullRom overload( _
        byval p0 as double, _
        byval p1 as double, _
        byval p2 as double, _
        byval p3 as double, _
        byval t as double ) _
      as double
      
      return( 0.5 * ( ( 2.0 * p1 ) + _
        ( -p0 + p2 ) * t + _
        ( 2.0 * p0 - 5 * p1 + 4 * p2 - p3 ) * t * t + _
        ( -p0 + 3.0 * p1 - 3.0 * p2 + p3) * t * t * t ) )
    end function
    
    'double catmullrom(double t, double p0, double p1, double p2, double p3)
    '{
    'return 0.5f * (
    '              (2 * p1) +
    '              (-p0 + p2) * t +
    '              (2 * p0 - 5 * p1 + 4 * p2 - p3) * t * t +
    '              (-p0 + 3 * p1 - 3 * p2 + p3) * t * t * t
    '              );
    '}
  end namespace
end namespace

#endif
