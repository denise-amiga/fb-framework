#ifndef __FBFW_DRAWING_DISPLAY__
#define __FBFW_DRAWING_DISPLAY__

namespace Drawing
  /'
    Represents the main display for the app
  '/
  type _
    Display _
    extends Events.WithEvents
    
    public:
      declare constructor( _
        byref as Drawing.DisplayOps )
      declare constructor( _
        byval as Drawing.DisplayOps ptr )
      declare virtual destructor() override
      
      declare property _
        displayChanged() _
        byref as const Events.Event
      
      declare property _
        name() as string
      declare property _
        width() as integer
      declare property _
        height() as integer
      declare property _
        rows() as integer
      declare property _
        columns() as integer
      declare property _
        foreColor() as Drawing.FbColor
      declare property _
        backColor() as Drawing.FbColor
      
      declare sub _
        init( _
          byval as integer, _
          byval as integer )
      declare sub _
        initFullScreen()
      declare sub _
        initFullScreenLowest()
      declare sub _
        initFullScreenHighest()
      declare sub _
        initFullScreen( _
          byval as integer, _
          byval as integer )
      
      declare sub _
        clear()
      declare sub _
        clear( _
          byval as Drawing.FbColor )
      declare sub _
        startFrame()
      declare sub _
        endFrame()
      declare sub _
        textAt( _
          byval as integer, _
          byval as integer, _
          byref as const string )
      declare sub _
        textAt( _
          byval as integer, _
          byval as integer, _
          byref as const string, _
          byval as Drawing.FbColor )
      declare sub _
        textAt( _
          byval as integer, _
          byval as integer, _
          byref as const string, _
          byval as Drawing.FbColor, _
          byval as Drawing.FbColor )
      
    protected:
      declare constructor()
      
      static as Drawing.DisplayOps ptr _
        _displayOps
      
    private:
      declare constructor( _
        byref as Display )
      declare operator _
        let( _
          byref as Display )
        
      declare sub _
        initializeComponent( _
          byval as Drawing.DisplayOps ptr, _
          byval as boolean )
      declare sub _
        dispose()
      
      static as Events.Event _
        _EvDisplayChanged
      
      static as boolean _
        _needsDisposing
  end type
  
  dim as Events.Event _
    Display._EvDisplayChanged => _
      Events.Event( "DisplayChanged" )
  dim as Drawing.DisplayOps ptr _
    Display._displayOps => 0
  dim as boolean _
    Display._needsDisposing => false
  
  constructor _
    Display()
  end constructor
  
  constructor _
    Display( _
      byref anOps as Drawing.DisplayOps )
    
    initializeComponent( _
      @anOps, _
      false )
  end constructor
  
  constructor _
    Display( _
      byval anOps as Drawing.DisplayOps ptr )
    
    initializeComponent( _
      anOps, _
      true )
  end constructor
  
  constructor _
    Display( _
      byref rhs as Display )
  end constructor
  
  operator _
    Display.let( _
      byref rhs as Display )
  end operator
  
  destructor _
    Display()
    
    dispose()
  end destructor
  
  sub _
    Display.initializeComponent( _
      byval anOps as Drawing.DisplayOps ptr, _
      byval disposeOps as boolean )
    
    register( _EvDisplayChanged )
    
    dispose()
    
    _displayOps => anOps
    _needsDisposing => disposeOps
  end sub
  
  sub _
    Display.dispose()
    
    if( _
      _displayOps <> 0 andAlso _
      _needsDisposing ) then
      
      delete( _displayOps )
    end if
  end sub
  
  property _
    Display.displayChanged() _
    byref as const Events.Event
    
    return( _EvDisplayChanged.forInstance( @this ) )
  end property
  
  property _
    Display.name() _
    as string
    
    return( _displayOps->opName )
  end property
  
  property _
    Display.width() _
    as integer
    
    return( _displayOps->opWidth )
  end property
  
  property _
    Display.height() _
    as integer
    
    return( _displayOps->opHeight )
  end property
  
  property _
    Display.rows() _
    as integer
    
    return( _displayOps->opRows )
  end property
  
  property _
    Display.columns() _
    as integer
    
    return( _displayOps->opColumns )
  end property
  
  property _
    Display.foreColor() _
    as Drawing.FbColor
    
    return( _displayOps->opForeColor )
  end property
  
  property _
    Display.backColor() _
    as Drawing.FbColor
    
    return( _displayOps->opBackColor )
  end property
  
  sub _
    Display.init( _
      byval aWidth as integer, _
      byval aHeight as integer )
    
    _displayOps->opInit( _
      aWidth, aHeight )
    
    raiseEvent( _
      displayChanged, Events.EventArgs() )
  end sub
  
  sub _
    Display.initFullScreen()
    
    _displayOps->opInitFullScreen()
    
    raiseEvent( _
      displayChanged, Events.EventArgs() )
  end sub
  
  sub _
    Display.initFullScreenLowest()
    
    _displayOps->opInitFullScreenLowest()
    
    raiseEvent( _
      displayChanged, Events.EventArgs() )
  end sub
  
  sub _
    Display.initFullScreenHighest()
    
    _displayOps->opInitFullScreenHighest()
    
    raiseEvent( _
      displayChanged, Events.EventArgs() )
  end sub
  
  sub _
    Display.initFullScreen( _
      byval aWidth as integer, _
      byval aHeight as integer )
    
    _displayOps->opInitFullScreen( _
      aWidth, aHeight )
    
    raiseEvent( _
      displayChanged, Events.EventArgs() )
  end sub
  
  sub _
    Display.clear()
    
    _displayOps->opClear()
  end sub
  
  sub _
    Display.clear( _
      byval aColor as Drawing.FbColor )
    
    _displayOps->opClear( aColor )
  end sub
  
  sub _
    Display.startFrame()
    
    _displayOps->opStartFrame()
  end sub
  
  sub _
    Display.endFrame()
    
    _displayOps->opEndFrame()
  end sub
  
  sub _
    Display.textAt( _
      byval aCol as integer, _
      byval aRow as integer, _
      byref aText as const string )
    
    _displayOps->opTextAt( _
      aCol, aRow, aText )
  end sub
  
  sub _
    Display.textAt( _
      byval aCol as integer, _
      byval aRow as integer, _
      byref aText as const string, _
      byval aForeColor as Drawing.FbColor )
    
    _displayOps->opTextAt( _
      aCol, aRow, aText, aForeColor )
  end sub
  
  sub _
    Display.textAt( _
      byval aCol as integer, _
      byval aRow as integer, _
      byref aText as const string, _
      byval aForeColor as Drawing.FbColor, _
      byval aBackColor as Drawing.FbColor )
    
    _displayOps->opTextAt( _
      aCol, aRow, aText, aForeColor, aBackColor )
  end sub
end namespace

#endif
