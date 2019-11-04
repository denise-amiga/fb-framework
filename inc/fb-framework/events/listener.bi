#ifndef __FB_EVENTS_LISTENER__
#define __FB_EVENTS_LISTENER__

namespace Events
  /'
    A Listener is an abstraction that encapsulates all the data required
    to dispatch an event to its listeners.
    
    The 'handler' property encapsulates the event handler proper, while
    the 'receiver' property encapsulates the object that is going to
    receive the event. This allows us to implement both normal handlers
    (which are static functions) and virtual handlers (which need the
    'receiver' parameter to forward the event to the appropriate
    virtual member).
    
    This structure is used internally by the events engine, so there's no
    need to deal with it directly.
  '/
  type _
    Listener
    
    public:
      declare constructor( _
        byval as const Event ptr, _ 
        byref as EventHandler, _
        byval as Object ptr )
      declare destructor()
      
      declare property _
        handledEvent() byref as const Event
      declare property _
        handler() byref as EventHandler
      declare property _
        receiver() as Object ptr
      
    private:
      declare constructor()
      
      as EventHandler _
        _handler
      as Object ptr _
        _receiver
      as const Event ptr _
        _event
  end type
  
  constructor _
    Listener()
  end constructor
  
  constructor _
    Listener( _
      byval anEvent as const Event ptr, _
      byref aHandler as EventHandler, _
      byval aReceiver as Object ptr )
    
    _event => anEvent
    _handler => aHandler
    _receiver => aReceiver
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
end namespace

#endif
