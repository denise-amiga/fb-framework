#ifndef __FBFW_DRAWING_GRAPHICS__
#define __FBFW_DRAWING_GRAPHICS__

namespace Drawing
  /'
    Represents the rendering operations that can be performed on
    a Graphics.Surface object.
  '/
  type _
    Graphics _
    extends Object
    
    public:
      declare virtual destructor()
      
      declare virtual sub _
        clear()
      declare virtual sub _
        clear( _
          byref as Drawing.FbColor )
      declare virtual sub _
        drawLine( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as Drawing.FbColor )
      declare virtual sub _
        drawRectangle( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as Drawing.FbColor )
      declare virtual sub _
        filledRectangle( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as Drawing.FbColor )
        
    protected:
      declare constructor()
      declare constructor( _
        byref as Surface )
      
      as Surface ptr _
        _surface
  end type
  
  constructor _
    Graphics()
  end constructor
  
  constructor _
    Graphics( _
      byref aSurface as Surface )
    
    _surface => @aSurface
  end constructor
  
  destructor _
    Graphics()
  end destructor
  
  sub _
    Graphics.clear()
  end sub
  
  sub _
    Graphics.clear( _
      byref aColor as Drawing.FbColor )
  end sub
  
  sub _
    Graphics.drawLine( _
      byval X1 as integer, _
      byval Y1 as integer, _
      byval X2 as integer, _
      byval Y2 as integer, _
      byref aColor as Drawing.FbColor )
  end sub
  
  sub _
    Graphics.drawRectangle( _
      byval X1 as integer, _
      byval Y1 as integer, _
      byval X2 as integer, _
      byval Y2 as integer, _
      byref aColor as Drawing.FbColor )
  end sub
  
  sub _
    Graphics.filledRectangle( _
      byval X1 as integer, _
      byval Y1 as integer, _
      byval X2 as integer, _
      byval Y2 as integer, _
      byref aColor as Drawing.FbColor )
  end sub
end namespace

#endif
