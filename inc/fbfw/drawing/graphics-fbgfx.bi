#ifndef __FBFW_DRAWING_GRAPHICS_FBGFX__
#define __FBFW_DRAWING_GRAPHICS_FBGFX__

namespace Drawing
  namespace FBGFX
    type _
      Graphics _
      extends Drawing.Graphics
      
      public:
        declare constructor( _
          byref as Surface )
        declare destructor() override
        
        declare sub _
          clear() override
        declare sub _
          clear( _
            byref as Drawing.FbColor ) override
        declare sub _
          drawLine( _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byref as Drawing.FbColor ) override
        declare sub _
          drawRectangle( _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byref as Drawing.FbColor ) override
        declare sub _
          filledRectangle( _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byref as Drawing.FbColor ) override
          
      private:
        declare constructor()
    end type
    
    constructor _
      Graphics()
    end constructor
    
    constructor _
      Graphics( _
        byref aSurface as Surface )
      
      base( aSurface )
    end constructor
    
    destructor _
      Graphics()
    end destructor
    
    sub _
      Graphics.clear()
      
      _surface->clear()
    end sub
    
    sub _
      Graphics.clear( _
        byref aColor as Drawing.FbColor )
      
      _surface->clear( aColor )
    end sub
    
    sub _
      Graphics.drawLine( _
        byval X1 as integer, _
        byval Y1 as integer, _
        byval X2 as integer, _
        byval Y2 as integer, _
        byref aColor as Drawing.FbColor )
      
      line _
        *_surface, _
        ( X1, Y1 ) - _
        ( X2, Y2 ), _
        aColor
    end sub
    
    sub _
      Graphics.drawRectangle( _
        byval X1 as integer, _
        byval Y1 as integer, _
        byval X2 as integer, _
        byval Y2 as integer, _
        byref aColor as Drawing.FbColor )
      
      line _
        *_surface, _
        ( X1, Y1 ) - _
        ( X2, Y2 ), _
        aColor, b
    end sub
    
    sub _
      Graphics.filledRectangle( _
        byval X1 as integer, _
        byval Y1 as integer, _
        byval X2 as integer, _
        byval Y2 as integer, _
        byref aColor as Drawing.FbColor )
      
      line _
        *_surface, _
        ( X1, Y1 ) - _
        ( X2, Y2 ), _
        aColor, bf
    end sub
  end namespace
end namespace

#endif
