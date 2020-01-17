#ifndef __FBFW_EVENTS_LISTENER__
#define __FBFW_EVENTS_LISTENER__

namespace Events
  /'
    A Listener is an abstraction that encapsulates all the data required
    to dispatch an event to its listeners.
    
    The 'handler' property encapsulates the event handler proper, while
    the 'receiver' property encapsulates the object that is going to
    receive the event (needed since handlers need to be static, and they
    don't get passed a 'this' pointer).
    The 'sender' property encapsulates the *instance* of the class that
    will raise the event.
    
    This structure is used internally by the events engine, and will be
    filled with the appropriate data when clients register a handler for
    an event (through the 'WithEvents.addHandler()' method), so there's no
    need to deal with it directly.
  '/
  type _
    Listener
    
    public:
      declare constructor( _
        byval as const Event ptr, _ 
        byref as EventHandler, _
        byval as Object ptr, _
        byval as Object ptr )
      declare destructor()
      
      declare property _
        handledEvent() byref as const Event
      declare property _
        handler() byref as EventHandler
      declare property _
        receiver() as Object ptr
      declare property _
        instance() as Object ptr
      
    private:
      declare constructor()
      
      as EventHandler _
        _handler
      as Object ptr _
        _receiver, _
        _instance
      as const Event ptr _
        _event
  end type
  
  constructor _
    Listener() export
  end constructor
  
  constructor _
    Listener( _
      byval anEvent as const Event ptr, _
      byref aHandler as EventHandler, _
      byval aReceiver as Object ptr, _
      byval anInstance as Object ptr )
    
    _event => anEvent
    _handler => aHandler
    _receiver => aReceiver
    _instance => anInstance
  end constructor
  
  destructor _
    Listener()
  end destructor
  
  property _
    Listener.handledEvent() _
    byref as const Event
    
    return( *_event )
  end property
  
  property _
    Listener.handler() _
    byref as EventHandler
    
    return( _handler )
  end property
  
  property _
    Listener.receiver() _
    as Object ptr
    
    return( _receiver )
  end property
  
  property _
    Listener.instance() _
    as Object ptr
    
    return( _instance )
  end property
end namespace

#endif
