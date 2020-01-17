#ifndef __FBFW_WINDOWING_WINDOWMANAGER__
#define __FBFW_WINDOWING_WINDOWMANAGER__

namespace Windowing
  type _
    WindowManager _
    extends Events.WithEvents
    
    public:
      declare constructor( _
        byval as Graphics.Display ptr )
      declare virtual destructor() override
      
      declare sub _
        onEvent( _
          byval as any ptr )
        
    protected:
      declare virtual sub _
        initializeComponent() override
      declare virtual sub _
        onDisplayChanged()
      declare virtual sub _
        onUpdate()
      
    private:
      declare static sub _
        _display_displayChanged( _
          byref as Object, _
          byref as Events.EventArgs )
        
      as Interaction.FBGFX.KeyboardInput _
        _keyboard
      as Interaction.FBGFX.MouseInput _
        _mouse
      as Graphics.Display ptr _
        _display
      as any ptr _
        _mutex
  end type
  
  constructor _
    WindowManager( _
      byval aDisplay as Graphics.Display ptr )
    
    _mutex => mutexCreate()
    _display => aDisplay
    
    initializeComponent()
  end constructor
  
  destructor _
    WindowManager()
    
    mutexDestroy( _mutex )
  end destructor
  
  sub _
    WindowManager.initializeComponent()
    
    addHandler( _
      _display->displayChanged, _
      asHandler( _display_displayChanged ) )
  end sub
  
  sub _
    WindowManager._display_displayChanged( _
      byref sender as Object, _
      byref e as Events.EventArgs )
    
    cptr( WindowManager ptr, e.Me )->onDisplayChanged()
  end sub
  
  sub _
    WindowManager.onEvent( _
      byval p as any ptr )
    
    mutexLock( _mutex )
      _mouse.onEvent( p )
      _keyboard.onEvent( p )
      
      onUpdate()
    mutexUnlock( _mutex )
  end sub
  
  sub _
    WindowManager.onUpdate()
  
  end sub
  
  sub _
    WindowManager.onDisplayChanged()
    
  end sub
end namespace

#endif
