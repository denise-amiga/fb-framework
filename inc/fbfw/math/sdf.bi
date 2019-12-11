#ifndef __FBFW_MATH_DISTANCES__
#define __FBFW_MATH_DISTANCES__

/'
  Framework for evaluating Signed Distance Functions (SDFs).
  
  Note that there are also some Unsigned Distance Functions in here too
  (denoted with the 'ud' prefix, as opposed to the 'sd' prefix for signed
  distances). 
  In all cases, 'p' denotes the point to be evaluated, and all functions
  are defined centered around the origin and untransformed.
  
  If the object that the functions define need to be rotated, translated, 
  etc. it must be transformed first. Simply multiply it with the inverse 
  of the desired transform (to bring the point to the object's coordinate
  space). For simple transforms such as a translation and/or scale, a
  simple transform suffices. For example, to compute the distance 'd' of
  a point 'p' to a circle centered around 'o' and of radius 'r' one would
  do:
  
  d => sdCircle( o - p, r )
  
  All functions return a distance <= 1.0 if the point evaluated lies
  inside the shape.
'/
namespace Math
  function _
    sdCircle( _
      byref p as Float2, _
      byval s as float ) _
    as float
    
    return( length( p ) - s )
  end function
  
  function _
    sdRectangle( _
      byref p as Float2, _
      byref b as Float2 ) _
    as float
    
    var _
      d => abs( p ) - b
    
    return( fMin( _
      fMax( d.x,d.y ), 0.0 ) + _
      length( vMax( d, 0.0 ) ) )
  end function
  
  function _
    sdEllipse( _
      byref p as Float2, _
      byref r as Float2 ) _
    as float
    
    return( ( length( p / r ) - 1.0 ) * _
      fMin( r.x, r.y ) )
  end function
  
  function _
    udRoundedRectangle( _
      byref p as Float2, _
      byref b as Float2, _
      byval r as float ) _
    as float
    
    return( length( _
      vMax( abs( p ) - b, 0.0 ) ) - r )
  end function
  
  function _
    sdCapsule( _
      byref p as Float2, _
      byref a as Float2, _
      byref b as Float2, _
      byval r as float ) _
    as float
    
    var _
      pa => p - a, _
      ba => b - a
    
    dim as float _
      h => fClamp( _
        dot( pa, ba ) / dot( ba, ba ), _
        0.0, 1.0 )
      
    return( length( pa - ba * h ) - r )
  end function
  
  /'
    The three basic set theoretical operations for distance functions.
    These allow to compose complex functions from all the primitives
    above. Pass them the result of an evaluated distance function.
  '/
  function _
    opUnion( _
      byval d1 as float, _
      byval d2 as float ) _
    as float
    
    return( fMin( d1, d2 ) )
  end function
  
  function _
    opSubstract( _
      byval d1 as float, _
      byval d2 as float ) _
    as float
    
    return( fMax( -d1, d2 ) )
  end function
  
  function _
    opIntersect( _
      byval d1 as float, _
      byval d2 as float ) _
    as float
    
    return( fMax( d1, d2 ) )
  end function
end namespace

#endif
