#ifndef __FBFW_WINDOWING_WINDOW__
#define __FBFW_WINDOWING_WINDOW__

namespace Windowing
  type _
    Window _
    extends Events.WithEvents
    
    public:
      declare virtual destructor() override
      
      declare property _
        location() as Drawing.Point
      declare property _
        size() as Drawing.Size
        
      declare sub _
        refresh()
      
    protected:
      declare constructor()
      declare constructor( _
        byval as integer, _
        byval as integer, _
        byval as integer, _
        byval as integer )
      declare constructor( _
        byref as Drawing.Point, _
        byref as Drawing.Size )
      
      declare virtual sub _
        onEnter()
      declare virtual sub _
        onExit()
      declare virtual sub _
        onPaint()
      
    private:
      as Drawing.Region _
        _clientArea
      as Graphics.Surface ptr _
        _surface
  end type
  
  constructor _
    Window()
  end constructor
  
  constructor _
    Window( _
      byval X1 as integer, _
      byval Y1 as integer, _
      byval X2 as integer, _
      byval Y2 as integer )
    
    _clientArea => Drawing.Region( _
      X1, Y1, X2, Y2 )
  end constructor
  
  constructor _
    Window( _
      byref aLocation as Drawing.Point, _ 
      byref aSize as Drawing.Size )
    
    _clientArea => Drawing.Region( _
      aLocation, _
      aSize )
    _surface => new Graphics.Surface( _
      _clientArea.size.width, _
      _clientArea.size.height )
  end constructor
  
  destructor _
    Window()
    
    delete( _surface )
  end destructor
  
  property _
    Window.location() _
    as Drawing.Point
    
    return( Drawing.Point( _
      _clientArea.location.X, _
      _clientArea.location.Y ) )
  end property
  
  property _
    Window.size() _
    as Drawing.Size
    
    return( Drawing.Size( _
      _clientArea.size.width, _
      _clientArea.size.height ) )
  end property
  
  sub _
    Window.refresh()
    
    onPaint()
  end sub
  
  sub _
    Window.onEnter()
  end sub
  
  sub _
    Window.onExit()
  end sub
  
  sub _
    Window.onPaint()
  end sub
end namespace

#endif
