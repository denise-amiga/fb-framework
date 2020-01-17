#ifndef __FBFW_EASING_FUNC__
#define __FBFW_EASING_FUNC__

#include once "fbfw-math-commons.bi"

namespace Easings
  type as function( _
    byval as single ) _
  as single _
  InterpolationFunction
  
  type as function ( _
    byval as double, _
    byval as single, _
    byval as single, _
    byval as double, _
    byref func as InterpolationFunction ) _
  as double _
  EasingFunction
  
  function _
    linear( _
      byval t as single ) _
    as single
    
    return( t )
  end function
  
  function _
    sine( _
      byval t as single ) _
    as single
    
    return( 1.0 - sin( Math.Pi * 0.5 * ( t + 1 ) ) )
  end function
  
  function _
    quadratic( _
      byval t as single ) _
    as single
    
    return( t * t )
  end function
  
  function _
    cubic( _
      byval t as single ) _
    as single
    
    return( t ^ 3 )
  end function
  
  function _
    quartic( _
      byval t as single ) _
    as single
    
    return( t ^ 4 )
  end function
  
  function _
    quintic( _
      byval t as single ) _
    as single
    
    return( t ^ 5 )
  end function
  
  function _
    exponential( _
      byval t as single ) _
    as single
    
    return( t ^ 10 )
  end function
  
  function _
    circular( _
      byval t as single ) _
    as single
    
    return( 1.0 - sqr( 1.0 - t ^ 2 ) )
  end function
  
  function _
    circularCubic( _
      byval t as single ) _
    as single
    
    return( 1.0 - sqr( 1.0 - t ^ 3 ) )
  end function
  
  function _
    circularQuartic( _
      byval t as single ) _
    as single
    
    return( 1.0 - sqr( 1.0 - t ^ 4 ) )
  end function
  
  function _
    back( _
      byval t as single ) _
    as single
    
    return( ( ( t + 0.4 ) ^ 3 - ( t + 0.4 ) ^ 2 + 0.1 ) * 1.125 )
  end function
  
  function _
    elastic( _
      byval t as single ) _
    as single
    
    return( sin( t * Math.Pi * 6.5 ) * t ^ 6 )
  end function
  
  function _
    bounce( _
      byval t as single ) _
    as single      
    
    if( t < 0.125 ) then
      return( sin( t * 8.0 * Math.Pi ) * 0.0625 )
    elseif( t < 0.333 ) then
      return( sin( ( t - 0.125 ) * 4.8076 * Math.Pi ) * 0.104 )
    elseif( t < 0.6 ) then
      return( sin( ( t - 0.333 ) * 3.7453 * Math.Pi ) * 0.267 )
    else
      return( sin( ( t - 0.6 ) * 2.5 * Math.HalfPi ) )
    end if
  end function
  
  function _
    easeIn( _
      byval currentT as double, _
      byval startValue as single, _
      byval endValue as single, _
      byval targetT as double, _
      byref func as InterpolationFunction ) _
    as double
  
    return( startValue + _
      func( currentT / targetT ) * endValue )
  end function
  
  function _
    easeOut( _
      byval currentT as double, _
      byval startValue as single, _
      byval endValue as single, _
      byval targetT as double, _
      byref func as InterpolationFunction ) _
    as double
    
    return( startValue + _
      ( 1.0 - func( 1.0 - ( currentT / targetT ) ) ) * endValue )
  end function
end namespace

#endif
