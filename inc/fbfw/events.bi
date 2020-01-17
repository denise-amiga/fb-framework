#ifndef __FBFW_EVENTS__
#define __FBFW_EVENTS__

/'
  Framework for creating classes that can raise events.
  
  11/29/2019
    Added multi-threading capability.
    
  11/06/2019
    Revamped the event system so it's properly encapsulated now, and can
    correctly dispatch events to the right listeners without requiring the
    client code to manually discriminate the correct sender, and without
    an additional LUT.
    
    The solution is somewhat of a compromise, though: the class that exposes
    the event needs to do so through the 'forInstance()' method, and pass a
    pointer to itself to it. That way, the handler for the event can be
    correctly paired with its receiver when the 'addHandler()' method is
    called.
  
  10/28/2019
    Some refactoring to simplify the registering and unregistering of
    events and handlers. All derived classes have to do now is 'register()'
    their events (and of course expose them). Event handler removal for
    each individual instance is handled automatically by the 'WithEvents'
    base class upon destruction of the instance.
    
    Improved the caching mechanism for the 'WithEvents' base class. All
    operations (registering, adding and removing handlers, and raising
    events) are amortized O(1) now.
  
  10/26/2019
    Revamped it to implement a more efficient and memory friendly static
    storage.
  
  10/23/2019
    Initial version.
'/
#include once "fbfw-collections.bi"

#if __FB_OUT_EXE__
  #undef export
  #define export
#endif

__include__( __FBFW_EVENTS_FOLDER__, eventargs.bi )

namespace Events
  /'
    This type encapsulates an event handler function. All event handlers
    need to have this signature (or a covariant one).
  '/
  type as sub( _
    byref as Object, _
    byref as EventArgs ) _
    EventHandler
end namespace

__include__( __FBFW_EVENTS_FOLDER__, event.bi )
__include__( __FBFW_EVENTS_FOLDER__, listener.bi )
__include__( __FBFW_EVENTS_FOLDER__, withevents.bi )

/'
  Just syntactic sugar to upcast any kind of event handler to the
  appropriate type. Event handlers can have their own specific parameters, 
  but they need to be upcasted to an EventHander type when registered
  to avoid compiler warnings.
'/
#define asHandler( e )  _
  cast( Events.EventHandler, @e )

#endif
