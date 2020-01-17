#ifndef __FBFW_RANDOM__
#define __FBFB_RANDOM__

namespace Randomization
  /'
    Represents a random number generator.
    
    Uses the Middle Square Weyl Sequence algorithm by
    Bernard Widyinsky.
    
    The original code can be found at:
      https://mswsrng.wixsite.com/rand
  '/
  type _
    Random
    
    public:
      declare constructor()
      declare constructor( _
        byval as double )
      declare destructor()
      
      declare function _
        nextInt() as ulong
      declare function _
        nextInt( _
          byval as long, _
          byval as long ) _
        as long
      declare function _
        nextDouble() as double
      
    private:
      static as double _
        _coef
      as ulongint _
        _x, _w, _s
  end type
  
  dim as double _
    Random._coef => 1.0 / culng( -1 )
  
  constructor _
    Random()
    
    randomize()
    
    this.constructor( rnd() )
  end constructor
  
  constructor _
    Random( _
      byval aSeed as double )
    
    _s => &hfedc65a1ce2d9587
    _w => aSeed * culngint( -1 )
  end constructor
  
  destructor _
    Random()
  end destructor
  
  function _
    Random.nextInt() _
    as ulong
    
    _x *=> _x : _w +=> _s : _x +=> _w
    _x => ( _x shr 32 ) or ( _x shl 32 )
    
    return( _x )
  end function
  
  function _
    Random.nextInt( _
      byval aMin as long, _
      byval aMax as long ) _
    as long
    
    return( nextDouble() * _
      ( aMax - aMin + 1 ) - 0.5 + aMin )
  end function
  
  function _
    Random.nextDouble() _
    as double
    
    return( nextInt() * _coef )
  end function
end namespace

#endif

