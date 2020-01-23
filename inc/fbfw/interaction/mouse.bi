#ifndef __FBFW_INTERACTION_MOUSEINPUT__
#define __FBFW_INTERACTION_MOUSEINPUT__

namespace Interaction
  namespace FBGFX
    /'
      Represents input from a mouse or pointing device.
    '/
    type _
      MouseInput _
      extends InputDevice
      
      public:
        declare constructor()
        declare constructor( _
          byval as integer )
        declare virtual destructor() override
        
        declare property _
          MouseEnter() _
          byref as const Events.Event
        declare property _
          MouseLeave() _
          byref as const Events.Event
        
        declare property _
          X() as integer
        declare property _
          Y() as integer
        declare property _
          deltaX() as integer
        declare property _
          deltaY() as integer
        declare property _
          startX() as integer
        declare property _
          startY() as integer
        declare property _
          horizontalWheel() as integer
        declare property _
          verticalWheel() as integer
        
        declare virtual sub _
          onEvent( _
            byval as any ptr ) override
          
        declare function _
          pressed( _
            byval as integer ) _
          as boolean
        declare function _
          released( _
            byval as integer ) _
          as boolean
        declare function _
          held( _
            byval as integer, _
            byval as double => 0.0 ) _
          as boolean
        declare function _
          repeated( _
            byval as integer, _
            byval as double => 0.0 ) _
          as boolean
        declare function _
          drag( _
            byval as integer ) _
          as boolean
        declare function _
          drop( _
            byval as integer ) _
          as boolean
        
      protected:
        enum _
          ButtonState
            None
            Pressed             => ( 1 shl 0 )
            AlreadyPressed      => ( 1 shl 1 )
            Released            => ( 1 shl 2 )
            AlreadyReleased     => ( 1 shl 3 )
            Held                => ( 1 shl 4 )
            HeldInitialized     => ( 1 shl 5 )
            Repeated            => ( 1 shl 6 )
            RepeatedInitialized => ( 1 shl 7 )
        end enum
        
        '' The bitflags for the button states
        as ubyte _
          _state( any )
        
        as integer _
          _x, _y, _
          _sx, _sy, _
          _dx, _dy, _
          _hWheel, _
          _vWheel
        
      private:
        static as Events.Event _
          _EvMouseEnter, _
          _EvMouseLeave
        
        /'
          Caches when a button started being held/repeated
        '/
        as double _
          _heldStartTime( any ), _
          _repeatedStartTime( any )
        
        /'
          The mutex for this instance
        '/
        as any ptr _
          _mutex
        
        as boolean _
          _pressed, _
          _dragging, _
          _dropped
    end type
    
    dim as Events.Event _
      MouseInput._EvMouseEnter => _
        Events.Event( "MouseEnter" ), _
      MouseInput._EvMouseLeave => _
        Events.Event( "MouseExit" )
      
    constructor _
      MouseInput()
      
      this.constructor( 8 ) 
    end constructor
    
    constructor _
      MouseInput( _
        byval buttons as integer )
      
      register( _EvMouseEnter )
      register( _EvMouseLeave )
      
      _mutex => mutexCreate()
      
      redim _
        _state( 0 to buttons - 1 )
      redim _
        _heldStartTime( 0 to buttons - 1 )
      redim _
        _repeatedStartTime( 0 to buttons - 1 )
    end constructor
    
    destructor _
      MouseInput()
      
      mutexDestroy( _mutex )
    end destructor
    
    property _
      MouseInput.MouseEnter() _
      byref as const Events.Event
      
      return( _EvMouseEnter.forInstance( @this ) )
    end property
    
    property _
      MouseInput.MouseLeave() _
      byref as const Events.Event
      
      return( _EvMouseLeave.forInstance( @this ) )
    end property
    
    property _
      MouseInput.X() _
      as integer
      
      return( _x )
    end property
    
    property _
      MouseInput.Y() _
      as integer
      
      return( _y )
    end property
    
    property _
      MouseInput.deltaX() _
      as integer
      
      return( _dx )
    end property
    
    property _
      MouseInput.deltaY() _
      as integer
      
      return( _dy )
    end property
    
    property _
      MouseInput.startX() _
      as integer
      
      return( _sx )
    end property
    
    property _
      MouseInput.startY() _
      as integer
      
      return( _sy )
    end property
    
    property _
      MouseInput.horizontalWheel() _
      as integer
      
      return( _hWheel )
    end property
    
    property _
      MouseInput.verticalWheel() _
      as integer
      
      return( _vWheel )
    end property
    
    /'
      Handles the events and sets internal state appropriately so we can
      query the other methods individually. This method must be called
      before any other method/property (usually done from the main thread).
    '/
    sub _
      MouseInput.onEvent( _
        byval e as any ptr )
      
      mutexLock( _mutex )
        var _
          ev => cptr( Fb.Event ptr, e )
        
        select case as const( ev->type )
          case Fb.EVENT_MOUSE_MOVE
            _x => ev->x
            _y => ev->y
            
            if( _pressed ) then
              _dx => _x - _sx
              _dy => _y - _sy
              
              _dragging => true
              _dropped => false
            end if
            
          case Fb.EVENT_MOUSE_BUTTON_PRESS
            _state( ev->button ) or=> _
              ( ButtonState.Pressed or ButtonState.Held or ButtonState.Repeated )
            _state( ev->button ) => _
              _state( ev->button ) and not ButtonState.AlreadyPressed
            
            _dx => 0
            _dy => 0
            _sx => _x
            _sy => _y
            _pressed => true
            _dragging => false
            
          case Fb.EVENT_MOUSE_BUTTON_RELEASE
            _state( ev->button ) or=> ButtonState.Released
            _state( ev->button ) => _
              _state( ev->button ) and not ButtonState.AlreadyReleased
            _state( ev->button ) => _state( ev->button ) and not _
              ( ButtonState.Held or ButtonState.HeldInitialized or _
                ButtonState.Repeated or ButtonState.RepeatedInitialized )
            
            _pressed => false
            
            if( _dx <> 0 andAlso _dy <> 0 ) then
              _dropped => true
            else
              _dropped => false
            end if
            
          case _
            Fb.EVENT_MOUSE_WHEEL, _
            Fb.EVENT_MOUSE_HWHEEL
            
            _hWheel => ev->w
            _vWheel => ev->z
          
          case Fb.EVENT_MOUSE_ENTER
            raiseEvent( _
              MouseEnter, Events.EventArgs() )
            
          case Fb.EVENT_MOUSE_EXIT
            raiseEvent( _
              MouseLeave, Events.EventArgs() )
        end select
      mutexUnlock( _mutex )
    end sub
    
    function _
      MouseInput.pressed( _
        byval aButton as integer ) _
      as boolean
      
      mutexLock( _mutex )
        dim as boolean _
          isPressed
        
        if( _
          cbool( _state( aButton ) and ButtonState.Pressed ) andAlso _
          not cbool( _state( aButton ) and ButtonState.AlreadyPressed ) ) then
          
          isPressed => true
          
          _state( aButton ) or=> ButtonState.AlreadyPressed
        end if
      mutexUnlock( _mutex )
      
      return( isPressed )
    end function
    
    function _
      MouseInput.released( _
        byval aButton as integer ) _
      as boolean
      
      mutexLock( _mutex )
        dim as boolean _
          isReleased
        
        if( _
          cbool( _state( aButton ) and ButtonState.Released ) andAlso _
          not cbool( _state( aButton ) and ButtonState.AlreadyReleased ) ) then
          
          isReleased => true
          
          _state( aButton ) or=> ButtonState.AlreadyReleased
        end if
      mutexUnlock( _mutex )
      
      return( isReleased )
    end function
    
    function _
      MouseInput.held( _
        byval aButton as integer, _
        byval interval as double => 0.0 ) _
      as boolean
      
      mutexLock( _mutex )
        dim as boolean _
          isHeld
        
        if( cbool( _state( aButton ) and ButtonState.Held ) ) then
          isHeld => true
          
          if( cbool( interval > 0.0 ) ) then
            if( not cbool( _state( aButton ) and ButtonState.HeldInitialized ) ) then
              _state( aButton ) or=> ButtonState.HeldInitialized
              _heldStartTime( aButton ) => timer()
            else
              dim as double _
                elapsed => ( timer() - _heldStartTime( aButton ) ) * 1000.0
              
              if( elapsed >= interval ) then
                isHeld => false
                
                _state( aButton ) => _
                  _state( aButton ) and not ButtonState.Held
              end if
            end if
          end if
        end if
      mutexUnlock( _mutex )
      
      return( isHeld )
    end function
    
    function _
      MouseInput.repeated( _
        byval aButton as integer, _
        byval interval as double => 0.0 ) _
      as boolean
      
      mutexLock( _mutex )
        dim as boolean _
          isRepeated
        
        if( cbool( _state( aButton ) and ButtonState.Repeated ) ) then
          if( cbool( interval > 0.0 ) ) then
            if( not cbool( _state( aButton ) and ButtonState.RepeatedInitialized ) ) then
              _repeatedStartTime( aButton ) => timer()
              _state( aButton ) or=> ButtonState.RepeatedInitialized
            else
              dim as double _
                elapsed => ( timer() - _repeatedStartTime( aButton ) ) * 1000.0
              
              if( elapsed >= interval ) then
                isRepeated => true
                
                _state( aButton ) => _
                  _state( aButton ) and not ButtonState.RepeatedInitialized
              end if
            end if
          else
            isRepeated => true
          end if
        end if
      mutexUnlock( _mutex )
      
      return( isRepeated )
    end function
    
    function _
      MouseInput.drag( _
        byval aButton as integer ) _
      as boolean
      
      return( _
        held( aButton ) andAlso _
        _dragging )
    end function
    
    function _
      MouseInput.drop( _
        byval aButton as integer ) _
      as boolean
      
      return( _
        released( aButton ) andAlso _
        _dropped )
    end function
  end namespace
end namespace

#endif
