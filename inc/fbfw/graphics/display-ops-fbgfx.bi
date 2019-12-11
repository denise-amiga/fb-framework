#ifndef __FBFW_GRAPHICS_DISPLAYOPS_FBGFX__
#define __FBFW_GRAPHICS_DISPLAYOPS_FBGFX__

namespace Graphics
  /'
    FBGFX display ops implementation
  '/
  namespace FBGFX
    type _
      DisplayOps _
      extends Graphics.DisplayOps
      
      public:
        declare constructor()
        declare constructor( _
          byval as integer )
        declare virtual destructor() override
        
        declare virtual property _
          opName() as string override
        declare property _
          opWidth() as integer override
        declare property _
          opHeight() as integer override
        declare property _
          opForeColor() as Drawing.FbColor override
        declare property _
          opBackColor() as Drawing.FbColor override
        declare property _
          opRows() as integer override
        declare property _
          opColumns() as integer override
        
        declare sub _
          opInit( _
            byval as integer, _
            byval as integer ) override
        declare sub _
          opInitFullScreen() override
        declare sub _
          opInitFullScreenLowest() override
        declare sub _
          opInitFullScreenHighest() override
        declare sub _
          opInitFullScreen( _
            byval as integer, _
            byval as integer ) override
        declare sub _
          opClear() override
        declare sub _
          opClear( _
            byval as Drawing.FbColor ) override
        declare sub _
          opStartFrame() override
        declare sub _
          opEndFrame() override
        
        declare sub _
          opTextAt( _
            byval as integer, _
            byval as integer, _
            byref as const string ) override
        declare sub _
          opTextAt( _
            byval as integer, _
            byval as integer, _
            byref as const string, _
            byval as Drawing.FbColor ) override
        declare sub _
          opTextAt( _
            byval as integer, _
            byval as integer, _
            byref as const string, _
            byval as Drawing.FbColor, _
            byval as Drawing.FbColor ) override
      
      protected:
        declare sub _
          initialize()
        declare sub _
          setMeasures( _
            byval as integer, _
            byval as integer )
          
        as integer _
          _width, _
          _height, _
          _flags, _
          _rows, _
          _columns, _
          _fontWidth => 8, _
          _fontHeight => 16
        as Drawing.FbColor _
          _foreColor => Drawing.Colors.Gray, _
          _backColor => Drawing.Colors.Black
        as boolean _
          _initialized
    end type
    
    constructor _
      DisplayOps()
      
      this.constructor( 0 )
    end constructor
    
    constructor _
      DisplayOps( _
        byval aFlags as integer )
      
      _flags => aFlags and not Fb.GFX_FULLSCREEN
    end constructor
    
    destructor _
      DisplayOps()
    end destructor
    
    property _
      DisplayOps.opName() _
      as string
      
      return( "fbgfx" )
    end property
    
    property _
      DisplayOps.opWidth() _
      as integer
      
      return( _width )
    end property
    
    property _
      DisplayOps.opHeight() _
      as integer
      
      return( _height )
    end property
    
    property _
      DisplayOps.opForeColor() _
      as Drawing.FbColor
      
      return( _foreColor )
    end property
    
    property _
      DisplayOps.opBackColor() _
      as Drawing.FbColor
      
      return( _backColor )
    end property
    
    property _
      DisplayOps.opRows() _
      as integer
      
      return( _rows )
    end property
    
    property _
      DisplayOps.opColumns() _
      as integer
      
      return( _columns )
    end property
    
    sub _
      DisplayOps.initialize()
      
      if( not _initialized ) then
        dim as long _
          mode, w, h
        
        mode => screenList( 32 )
        
        do while( mode <> 0 )
          _fullScreenModes->add( _
            new FullScreenModeInfo( _
              hiWord( mode ), _
              loWord( mode ), _
              32 ) )
          
          mode => screenList()
        loop
        
        _initialized => true
      end if
    end sub
    
    sub _
      DisplayOps.setMeasures( _
        byval aWidth as integer, _
        byval aHeight as integer )
      
      _width => aWidth
      _height => aHeight
      _columns => _width \ _fontWidth
      _rows => _height \ _fontHeight
      
      width _columns, _rows
    end sub
    
    sub _
      DisplayOps.opInit( _
        byval aWidth as integer, _
        byval aHeight as integer )
      
      initialize()
      
      screenRes( _
        aWidth, aHeight, _
        32, , _flags )
      
      setMeasures( aWidth, aHeight )
    end sub
    
    sub _
      DisplayOps.opInitFullScreen()
      
      initialize()
      
      var _
        maxRes => fullScreenModes.at( fullScreenModes.count - 1 )
      
      screenRes( _
        maxRes->width, _
        maxRes->height, _
        32, , _flags )
      
      setMeasures( maxRes->width, maxRes->height )
    end sub
    
    sub _
      DisplayOps.opInitFullScreenLowest()
      
      initialize()
      
      var _
        minRes => fullScreenModes.at( 0 )
      
      screenRes( _
        minRes->width, _
        minRes->height, _
        32, , _flags or Fb.GFX_FULLSCREEN )
      
      setMeasures( minRes->width, minRes->height )
    end sub
    
    sub _
      DisplayOps.opInitFullScreenHighest()
      
      initialize()
      
      var _
        maxRes => fullScreenModes.at( fullScreenModes.count - 1 )
      
      screenRes( _
        maxRes->width, _
        maxRes->height, _
        32, , _flags or Fb.GFX_FULLSCREEN )
      
      setMeasures( maxRes->width, maxRes->height )
    end sub
    
    sub _
      DisplayOps.opInitFullScreen( _
        byval aWidth as integer, _
        byval aHeight as integer )
      
      initialize()
      
      var _
        closestRes => closestFullScreenResTo( aWidth, aHeight )
      
      screenRes( _
        closestRes->width, _
        closestRes->height, _
        32, , _flags or Fb.GFX_FULLSCREEN )
      
      setMeasures( closestRes->width, closestRes->height )
    end sub
    
    sub _
      DisplayOps.opClear()
      
      cls()
    end sub
    
    sub _
      DisplayOps.opClear( _
        byval aBackColor as Drawing.FbColor )
      
      _backColor => aBackColor
      
      color( , _backColor )
      cls()
    end sub
    
    sub _
      DisplayOps.opStartFrame()
      
      screenLock()
    end sub
    
    sub _
      DisplayOps.opEndFrame()
      
      screenUnlock()
      
      sleep( 1, 1 )
    end sub
    
    sub _
      DisplayOps.opTextAt( _
        byval aCol as integer, _
        byval aRow as integer, _
        byref aText as const string )
      
      opTextAt( _
        aCol, aRow, aText, _foreColor, _backColor )
    end sub
    
    sub _
      DisplayOps.opTextAt( _
        byval aCol as integer, _
        byval aRow as integer, _
        byref aText as const string, _
        byval aForeColor as Drawing.FbColor )
      
      opTextAt( _
        aCol, aRow, aText, aForeColor, _backColor )
    end sub
    
    sub _
      DisplayOps.opTextAt( _
        byval aCol as integer, _
        byval aRow as integer, _
        byref aText as const string, _
        byval aForeColor as Drawing.FbColor, _
        byval aBackColor as Drawing.FbColor )
      
      dim as integer _
        posX => aCol * _fontWidth, _
        posY => aRow * _fontHeight
      
      line _
        ( posX, posY ) - _
        ( ( posX + len( aText ) * _fontWidth ) - 1, _
          ( posY + _fontHeight - 1 ) ), _
        aBackColor, bf
      
      draw string _
        ( posX, posY ), _
        aText, _
        aForeColor
    end sub
  end namespace
end namespace

#endif
