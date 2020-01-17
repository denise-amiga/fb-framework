#ifndef __FBFW_EVENTS_EVENTARGS__
#define __FBFW_EVENTS_EVENTARGS__

namespace Events
  /'
    Represents an event that has no arguments. All events are derived
    from this class.
    
    Note that there's a public 'Me' member. This member is equivalent
    to the 'this' pointer and is needed to access the members of the
    class that registered the listener. There's no need to set it
    manually, as it will be forwarded to the listener by the 'WithEvents'
    class.
  '/
  type _
    EventArgs _
    extends Object
    
    public:
      declare constructor()
      declare virtual destructor()
      
      declare static function _
        empty() as EventArgs
      
      as any ptr _
        Me
  end type
  
  constructor _
    EventArgs() export
  end constructor
  
  destructor _
    EventArgs() export
  end destructor
  
  function _
    EventArgs.empty() _
    as EventArgs export
    
    return( EventArgs() )
  end function
end namespace

#endif
 