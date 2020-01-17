#ifndef __FBFW_INPUT_DEVICE__
#define __FBFW_INPUT_DEVICE__

namespace Interaction
  /'
    Abstracts an input device (keyboard, mouse, joystick, etc) that is handled
    through pulling events from a queue (a scheme commonly implemented by
    libraries such as SDL2 and SFML; and also FreeBasic through the 'screenEvent()'
    statement).
  '/
  type _
    InputDevice _
    extends Events.WithEvents
    
    public:
      declare virtual destructor() override
      
      /'
        Handles the events and sets internal state appropriately so we can
        query other methods individually. This method must be called before
        any other method/property (usually done from the main thread).
      '/
      declare abstract sub _
        onEvent( _
          byval as any ptr )
  end type
  
  destructor _
    InputDevice()
  end destructor
end namespace

#endif
