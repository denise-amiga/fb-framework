#ifndef __FBFW_DRAWING_GRAPHICS__
#define __FBFW_DRAWING_GRAPHICS__

namespace Drawing
  /'
    Represents the rendering operations that can be performed on
    a Drawing.Surface object.
  '/
  type _
    Graphics _
    extends Object
    
    public:
      declare virtual destructor()
      
      declare property _
        bounds() as Drawing.Size
      declare property _
        pixels() as ulong ptr
      declare property _
        pitch() as integer
      
      declare static function _
        createSurface( _
          byval as integer, _
          byval as integer ) _
        as Drawing.Surface ptr
      
      declare virtual sub _
        clear()
      declare virtual sub _
        clear( _
          byref as const Drawing.FbColor )
      declare virtual sub _
        drawLine( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as const Drawing.FbColor )
      declare virtual sub _
        drawLine( _
          byref as Drawing.Point, _
          byref as Drawing.Point, _
          byref as const Drawing.FbColor )
      declare virtual sub _
        drawCircle( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as const Drawing.FbColor )
      declare virtual sub _
        drawRectangle( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as const Drawing.FbColor )
      declare virtual sub _
        filledRectangle( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as const Drawing.FbColor )
      declare virtual sub _
        filledCircle( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as const Drawing.FbColor )
      declare virtual sub _
        drawSurface( _
          byref as Drawing.Surface, _
          byval as integer, _
          byval as integer )
      declare virtual sub _
        drawString( _
          byval as integer, _
          byval as integer, _
          byref as const string, _
          byref as const Drawing.FbColor )
        
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
  
  property _
    Graphics.bounds() _
    as Drawing.Size
    
    return( Drawing.Size( _
      _surface->width, _
      _surface->height ) )
  end property
  
  property _
    Graphics.pixels() _
    as ulong ptr
    
    return( _surface->pixels )
  end property
  
  property _
    Graphics.pitch() _
    as integer
    
    return( _surface->pitchInPixels )
  end property
  
  function _
    Graphics.createSurface( _
      byval aWidth as integer, _
      byval aHeight as integer ) _
    as Drawing.Surface ptr
    
    return( new Drawing.Surface( aWidth, aHeight ) )
  end function
  
  sub _
    Graphics.clear()
  end sub
  
  sub _
    Graphics.clear( _
      byref aColor as const Drawing.FbColor )
  end sub
  
  sub _
    Graphics.drawLine( _
      byval X1 as integer, _
      byval Y1 as integer, _
      byval X2 as integer, _
      byval Y2 as integer, _
      byref aColor as const Drawing.FbColor )
  end sub
  
  sub _
    Graphics.drawLine( _
      byref P1 as Drawing.Point, _
      byref P2 as Drawing.Point, _
      byref aColor as const Drawing.FbColor )
  end sub
  
  sub _
    Graphics.drawCircle( _
      byval CX as integer, _
      byval CY as integer, _
      byval radius as integer, _
      byref aColor as const Drawing.FbColor )
  end sub
  
  sub _
    Graphics.drawRectangle( _
      byval X1 as integer, _
      byval Y1 as integer, _
      byval X2 as integer, _
      byval Y2 as integer, _
      byref aColor as const Drawing.FbColor )
  end sub
  
  sub _
    Graphics.filledRectangle( _
      byval X1 as integer, _
      byval Y1 as integer, _
      byval X2 as integer, _
      byval Y2 as integer, _
      byref aColor as const Drawing.FbColor )
  end sub
  
  sub _
    Graphics.filledCircle( _
      byval CX as integer, _
      byval CY as integer, _
      byval radius as integer, _
      byref aColor as const Drawing.FbColor )
  end sub
  
  sub _
    Graphics.drawSurface( _
      byref s as Drawing.Surface, _
      byval x as integer, _
      byval y as integer )
    
    put _
      *_surface, _
      ( x, y ), _
      s, alpha
  end sub
  
  sub _
    Graphics.drawString( _
      byval x as integer, _
      byval y as integer, _
      byref text as const string, _
      byref aColor as const Drawing.FbColor )
    
    draw string _
      *_surface, _
      ( x, y ), _
      text, _
      aColor
  end sub
end namespace

#endif
