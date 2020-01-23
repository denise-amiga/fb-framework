#ifndef __FBFW_DRAWING_GRAPHICS_FBGFX__
#define __FBFW_DRAWING_GRAPHICS_FBGFX__

namespace Drawing
  namespace FBGFX
    type _
      Graphics _
      extends Drawing.Graphics
      
      public:
        declare static function _
          createFor( _
            byref as Drawing.Surface ) _
          as Graphics ptr
        
        declare destructor() override
        
        declare sub _
          clear() override
        declare sub _
          clear( _
            byref as const Drawing.FbColor ) override
        declare sub _
          drawLine( _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byref as const Drawing.FbColor ) override
        declare sub _
          drawLine( _
            byref as Drawing.Point, _
            byref as Drawing.Point, _
            byref as const Drawing.FbColor ) override
        declare sub _
          drawCircle( _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byref as const Drawing.FbColor ) override
        declare sub _
          drawRectangle( _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byref as const Drawing.FbColor ) override
        declare sub _
          filledRectangle( _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byref as const Drawing.FbColor ) override
        declare sub _
          filledCircle( _
            byval as integer, _
            byval as integer, _
            byval as integer, _
            byref as const Drawing.FbColor ) override
          
      protected:
        declare constructor( _
          byref as Surface )
        
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
    
    function _
      Graphics.createFor( _
        byref aSurface as Drawing.Surface ) _
      as Graphics ptr
      
      return( new Graphics( aSurface ) )
    end function
    
    sub _
      Graphics.clear()
      
      _surface->clear()
    end sub
    
    sub _
      Graphics.clear( _
        byref aColor as const Drawing.FbColor )
      
      _surface->clear( aColor )
    end sub
    
    sub _
      Graphics.drawLine( _
        byval X1 as integer, _
        byval Y1 as integer, _
        byval X2 as integer, _
        byval Y2 as integer, _
        byref aColor as const Drawing.FbColor )
      
      line _
        *_surface, _
        ( X1, Y1 ) - _
        ( X2, Y2 ), _
        aColor
    end sub
    
    sub _
      Graphics.drawLine( _
        byref P1 as Drawing.Point, _
        byref P2 as Drawing.Point, _
        byref aColor as const Drawing.FbColor )
      
      line _
        *_surface, _
        ( P1.X, P1.Y ) - _
        ( P2.X, P2.Y ), _
        aColor
    end sub
    
    sub _
      Graphics.drawCircle( _
        byval CX as integer, _
        byval CY as integer, _
        byval radius as integer, _
        byref aColor as const Drawing.FbColor )
      
      circle _
        *_surface, _
        ( CX, CY ), _
        radius, aColor
    end sub
    
    sub _
      Graphics.drawRectangle( _
        byval X1 as integer, _
        byval Y1 as integer, _
        byval X2 as integer, _
        byval Y2 as integer, _
        byref aColor as const Drawing.FbColor )
      
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
        byref aColor as const Drawing.FbColor )
      
      line _
        *_surface, _
        ( X1, Y1 ) - _
        ( X2, Y2 ), _
        aColor, bf
    end sub
    
    sub _
      Graphics.filledCircle( _
        byval CX as integer, _
        byval CY as integer, _
        byval radius as integer, _
        byref aColor as const Drawing.FbColor )
      
      circle _
        *_surface, _
        ( CX, CY ), _
        radius, _
        aColor, , , , f
    end sub
  end namespace
end namespace

#endif
