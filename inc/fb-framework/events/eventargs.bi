#ifndef __FB_EVENTS_EVENTARGS__
#define __FB_EVENTS_EVENTARGS__

namespace Events
  /'
    Represents an event that has no arguments. All events are derived
    from this class.
    
    Note that there's a public 'Me' member. This member is equivalent
    to 'this' and is needed to access the members of the class that
    registered the listener. There's no need to set it manually and can
    be left largely alone.
  '/
  type _
    EventArgs _
    extends Object
    
    public:
      declare constructor()
      declare virtual destructor()
      
      as any ptr _
        Me
  end type
  
  constructor _
    EventArgs()
  end constructor
  
  destructor _
    EventArgs()
  end destructor
end namespace

#endif
 