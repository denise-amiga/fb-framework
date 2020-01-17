#ifndef __FBFW_WINDOWING_DESKTOP__
#define __FBFW_WINDOWING_DESKTOP__

namespace Windowing
  type _
    Desktop _
    extends Events.WithEvents
    
    public:
      declare constructor( _
        byval as integer, _
        byval as integer )
      declare virtual destructor() override
      
      declare property _
        width() as integer
      declare property _
        height() as integer
      
    private:
      declare constructor()
      
      static as integer _
        _width, _
        _height
  end type
  
  dim as integer _
    Desktop._width => 0, _
    Desktop._height => 0
  
  constructor _
    Desktop()
  end constructor
  
  constructor _
    Desktop( _
      byval aWidth as integer, _
      byval aHeight as integer )
    
    _width => aWidth
    _height => aHeight
  end constructor
  
  destructor _
    Desktop()
  end destructor
end namespace

#endif
