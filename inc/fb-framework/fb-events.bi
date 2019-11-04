#ifndef __FB_EVENTS__
#define __FB_EVENTS__

/'
  Framework for creating classes that can raise events.
  
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
#include once "events/eventargs.bi"

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

#include once "events/event.bi"
#include once "events/listener.bi"
#include once "events/withevents.bi"

/'
  Just syntactic sugar to upcast any kind of event handler to the
  appropriate type. Event handlers can have their own specific parameters, 
  but they need to be upcasted to an EventHander type when registered
  to avoid compiler warnings.
'/
#define asHandler( e )  _
  cast( Events.EventHandler, @e )

#endif
