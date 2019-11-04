#ifndef __FB_EASINGS__
#define __FB_EASINGS__

/'
  Framework for working with easings (also called 'tweenings').
'/
#include once "easings/easing-funcs.bi"

namespace Easings
  'type _
  '  Easing
  '  
  '  public:
  '    declare constructor()
  '    declare constructor( _
  '      byref as EasingFunction )
  '    declare destructor()
  '    
  '    declare function _
  '      easeIn( _
  '        byval as double, _
  '        byval as single, _
  '        byval as single, _
  '        byval as double ) _
  '      as single
  '    
  '    declare function _
  '      easeOut( _
  '        byval as double, _
  '        byval as single, _
  '        byval as single, _
  '        byval as double ) _
  '      as single
  '    
  '  private:
  '    as EasingFunction _
  '      _easingFunction
  'end type
  '
  'constructor _
  '  Easing()
  '  
  '  _easingFunction => @Easings.linear
  'end constructor
  '
  'constructor _
  '  Easing( _
  '    byref anEasingFunction as EasingFunction )
  '  
  '  _easingFunction => anEasingFunction
  'end constructor
  '
  'destructor _
  '  Easing()
  'end destructor
  '
  'function _
  '  Easing.easeIn( _
  '    byval currentT as double, _
  '    byval startValue as single, _
  '    byval endValue as single, _
  '    byval targetT as double ) _
  '  as single
  '  
  '  return( startValue + _
  '    _easingFunction( currentT / targetT ) * endValue )
  'end function
  '
  'function _
  '  Easing.easeOut( _
  '    byval currentT as double, _
  '    byval startValue as single, _
  '    byval endValue as single, _
  '    byval targetT as double ) _
  '  as single
  '  
  '  return( startValue + _
  '    ( 1.0 - _easingFunction( 1.0 - ( currentT / targetT ) ) ) * endValue )
  'end function
end namespace

#endif
