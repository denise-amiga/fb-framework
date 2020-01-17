#ifndef __FBFW_INTERACTION_KEYBOARDINPUT__
#define __FBFW_INTERACTION_KEYBOARDINPUT__

namespace Interaction
  namespace FBGFX
    /'
      Represents the input received from the keyboard.
      
      There are four states that can be queried: pressed, released,
      held and repeated. All of them are:
      
      * Independent
        You don't need to query one to get the report for another. That is to
        say, you don't need to query 'pressed()' before querying 'released()':
        they will report their correct status when you query them individually.
      
      * Order-invariant
        Doesn't matter the order in which you place their queries in the code:
        
        pressed( scanCode )
        released( scanCode )
        held( scanCode )
        
        or
        
        held( scanCode )
        released( scanCode )
        pressed( scanCode )
        
        will net the same results, in the order you would expect. Said order, 
        should you query all of them for the same key, will also be invariant:
        
          pressed
          { held
            repeated } -> If you specify intervals; otherwise they'll get
          released        reported in the order in which you query them
      
      See the comments on the method definitions for specificities about each 
      one.
      
      TODO:
        - Implement key state pushing/popping from an internal stack (to make
          the abstraction self-contained).
    '/
    type _
      KeyboardInput _
      extends InputDevice
      
      public:
        declare constructor()
        declare constructor( _
          byval as integer )
        declare virtual destructor() override
        
        declare virtual sub _
          onEvent( _
            byval as any ptr ) override
          
        declare function _
          pressed( _
            byval as long ) _
          as boolean
        declare function _
          released( _
            byval as long ) _
          as boolean
        declare function _
          held( _
            byval as long, _
            byval as double => 0.0 ) _
          as boolean
        declare function _
          repeated( _
            byval as long, _
            byval as double => 0.0 ) _
          as boolean
        
      protected:
        enum _
          KeyState
            None
            Pressed =>             ( 1 shl 0 )
            AlreadyPressed =>      ( 1 shl 1 )
            Released =>            ( 1 shl 2 )
            AlreadyReleased =>     ( 1 shl 3 )
            Held =>                ( 1 shl 4 )
            HeldInitialized =>     ( 1 shl 5 )
            Repeated =>            ( 1 shl 6 )
            RepeatedInitialized => ( 1 shl 7 )
        end enum
        
        '' These will store the bitflags for the key states
        as ubyte _
          _state( any )
        
      private:
        /'
          Caches when a key started being held/repeated
        '/
        as double _
          _heldStartTime( any ), _
          _repeatedStartTime( any )
        
        /'
          The mutex for this instance
        '/
        as any ptr _
          _mutex
    end type
    
    constructor _
      KeyboardInput()
      
      this.constructor( 128 )
    end constructor
    
    constructor _
      KeyboardInput( _
        byval aNumberOfKeys as integer )
      
      dim as integer _
        keys => iif( aNumberOfKeys < 128, _
          128, aNumberOfKeys )
      
      redim _
        _state( 0 to keys - 1 )
      redim _
        _heldStartTime( 0 to keys - 1 )
      redim _
        _repeatedStartTime( 0 to keys - 1 )
      
      _mutex => mutexCreate()
    end constructor
    
    destructor _
      KeyboardInput()
      
      mutexDestroy( _mutex )
    end destructor
    
    sub _
      KeyboardInput.onEvent( _
        byval e as any ptr )
      
      mutexLock( _mutex )
        var _
          ev => cptr( Fb.Event ptr, e )
        
        select case as const( ev->type )
          case Fb.EVENT_KEY_PRESS
            _state( ev->scanCode ) or=> _
              ( KeyState.Pressed or KeyState.Held or KeyState.Repeated )
            _state( ev->scanCode ) => _
              _state( ev->scanCode ) and not KeyState.AlreadyPressed
            
          case Fb.EVENT_KEY_RELEASE
            _state( ev->scanCode ) or=> KeyState.Released
            _state( ev->scanCode ) => _
              _state( ev->scanCode ) and not KeyState.AlreadyReleased
            _state( ev->scanCode ) => _state( ev->scanCode ) and not _
              ( KeyState.Held or KeyState.HeldInitialized or _
                KeyState.Repeated or KeyState.RepeatedInitialized )
        end select
      mutexUnlock( _mutex )
    end sub
    
    /'
      Returns whether or not a key was pressed.
      
      'Pressed' in this context means that the method will return 'true'
      *once* upon a key press. If you press and hold the key, it will
      not report 'true' until you release the key and press it again.
    '/
    function _
      KeyboardInput.pressed( _
        byval scanCode as long ) _
      as boolean
      
      mutexLock( _mutex )
        dim as boolean _
          isPressed
        
        if( _
          cbool( _state( scanCode ) and KeyState.Pressed ) andAlso _
          not cbool( _state( scanCode ) and KeyState.AlreadyPressed ) ) then
          
          isPressed => true
          
          _state( scanCode ) or=> KeyState.AlreadyPressed
        end if
      mutexUnlock( _mutex )
      
      return( isPressed )
    end function
    
    /'
      Returns whether or not a key was released.
      
      'Released' means that a key has to be pressed and then released for
      this method to return 'true' once, just like the 'pressed()' method
      above.
    '/
    function _
      KeyboardInput.released( _
        byval scanCode as long ) _
      as boolean
      
      mutexLock( _mutex )
        dim as boolean _
          isReleased
        
        if( _
          cbool( _state( scanCode ) and KeyState.Released ) andAlso _
          not cbool( _state( scanCode ) and KeyState.AlreadyReleased ) ) then
          
          isReleased => true
          
          _state( scanCode ) or=> KeyState.AlreadyReleased
        end if
      mutexUnlock( _mutex )
      
      return( isReleased )
    end function
    
    /'
      Returns whether or not a key is being held.
      
      'Held' means that the key was pressed and is being held pressed, so the
      method behaves pretty much like a call to 'multiKey()', if the 'interval'
      parameter is unspecified.
      
      If an interval is indeed specified, then the method will report the 'held'
      status up to the specified interval, then it will stop reporting 'true'
      until the key is released and held again.
      
      Both this and the 'released()' method expect their intervals to be expressed
      in milliseconds.
    '/
    function _
      KeyboardInput.held( _
        byval scanCode as long, _
        byval interval as double => 0.0 ) _
      as boolean
      
      mutexLock( _mutex )
        dim as boolean _
          isHeld
        
        if( cbool( _state( scanCode ) and KeyState.Held ) ) then
          isHeld => true
          
          if( cbool( interval > 0.0 ) ) then
            if( not cbool( _state( scanCode ) and KeyState.HeldInitialized ) ) then
              _state( scanCode ) or=> KeyState.HeldInitialized
              _heldStartTime( scanCode ) => timer()
            else
              dim as double _
                elapsed => ( timer() - _heldStartTime( scanCode ) ) * 1000.0
              
              if( elapsed >= interval ) then
                isHeld => false
                
                _state( scanCode ) => _
                  _state( scanCode ) and not KeyState.Held
              end if
            end if
          end if
        end if
      mutexUnlock( _mutex )
      
      return( isHeld )
    end function
    
    /'
      Returns whether or not a key is being repeated.
      
      'Repeated' means that the method will intermittently report the 'true'
      status once 'interval' milliseconds have passed. It can be understood
      as the autofire functionality of some game controllers: you specify the
      speed of the repetition using the 'interval' parameter.
      
      Bear in mind, however, that the *first* repetition will be reported
      AFTER one interval has elapsed. In other words, the reported pattern is 
      [pause] [repeat] [pause] instead of [repeat] [pause] [repeat].
      
      If no interval is specified, the method behaves like a call to
      'multiKey()'.
    '/
    function _
      KeyboardInput.repeated( _
        byval scanCode as long, _
        byval interval as double => 0.0 ) _
      as boolean
      
      mutexLock( _mutex )
        dim as boolean _
          isRepeated
        
        if( cbool( _state( scanCode ) and KeyState.Repeated ) ) then
          if( cbool( interval > 0.0 ) ) then
            if( not cbool( _state( scanCode ) and KeyState.RepeatedInitialized ) ) then
              _repeatedStartTime( scanCode ) => timer()
              _state( scanCode ) or=> KeyState.RepeatedInitialized
            else
              dim as double _
                elapsed => ( timer() - _repeatedStartTime( scanCode ) ) * 1000.0
              
              if( elapsed >= interval ) then
                isRepeated => true
                
                _state( scanCode ) => _
                  _state( scanCode ) and not KeyState.RepeatedInitialized
              end if
            end if
          else
            isRepeated => true
          end if
        end if
      mutexUnlock( _mutex )
      
      return( isRepeated )
    end function
  end namespace
end namespace

#endif