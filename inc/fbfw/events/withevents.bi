#ifndef __FBFW_EVENTS_WITHEVENTS__
#define __FBFW_EVENTS_WITHEVENTS__

namespace Events
  /'
    Constant to represent 'No events are registered yet'. It has to be
    -1 because collections (such as lists) start indexing at 0. See
    the implementation for the 'WithEvents.register()' for more details.
  '/
  const as integer _
    NoEventsRegisteredYet => -1
  
  /'
    Now we're templating both a linked list of receivers and a list of those.
    Since standard Lists use integers to index their items, this integer will
    serve as an abstract handle to identify each event, that the class that
    encapsulates the list will use to dispatch the event to the list of
    receivers associated to that handle.
    
    This means we can have an open ended number of listeners for any particular
    event.
  '/
  template( _
    LinkedList, _
    of( Listener ) )
  template( _
    List, _
    of( LinkedList( of( Listener ) ) ) )
  
  /'
    This structure contains caching information for linked list nodes.
    Linked lists have an O(1) insertion and removal time, as long as
    you know the pointer to the appropriate node. So, the purpose of this
    structure is precisely that: to allow for quick removal of nodes.
  '/
  type _
    NodeCacheInfo
    
    /'
      Contains a pointer to a linked list node that will be cached upon
      adding a handler for the class instance.
    '/
    as LinkedListNode( of( Listener ) ) ptr _
      listenerNode
    
    /'
      There's no way we can forward reference this. So, we're going to
      settle for an 'any ptr' instead. This member contains a pointer
      to a linked list node that contains an instance of this structure.
      
      The typeOf() for this member is, technically: 
        'LINKEDLISTNODE( of( NODECACHEINFO ) ) PTR'
    '/
    as any ptr _
      cacheInfoNode
  end type
  
  /'
    And now we template both a LinkedList of the 'NodeCacheInfo' structure,
    and a Dictionary of them. Both of them will be used by the caching
    mechanism to quickly remove event handlers upon an object's destruction.
    See the implementation of the destructor for the 'WithEvents' class for
    more details on how this works.
  '/
  template( _
    LinkedList, _
    of( NodeCacheInfo ) )
  template( _
    Dictionary, _
    of( uinteger ), _
    of( NodeCacheInfo ) )
  
  /'
    This class represents an object that can raise events. Every class
    that derives from this will be able to register and raise events,
    and provides methods to add and remove handlers for them.
    
    The class interface has two layers: the public one is used to add
    and remove event handlers for each specific event type (which uses
    a VB.NET-like scheme detailed below), while the protected one is
    to be used internally and by derived classes to register and raise
    events from within the class.
    
    Note that, even though objects now become a little more 'heavy',
    this effectively eliminates the need for an 'EventManager' class
    of sorts and to poll it for updates, since this base class is
    now responsible for dispatching events to their listeners. All
    derived classes need to do is register the events they raise, 
    and expose the event handles they get to the client code through
    the 'forInstance()' method.
    
    In this scheme, the 'register()' method ensures that each event
    registered gets its own unique handle, and that handle is exposed
    to clients through read-only const properties.
    
    This also greatly simplifies the event registering mechanism, since
    events exposed can be registered on the primary constructors of classes, 
    which can then be instantiated without the need to inject a reference
    to an event manager and/or manually do the wiring with a specialized
    method or exposing internals (ie. classes that raise events are
    self-contained).
    
    Technically speaking, the class is implemented as a mixture of a
    Monostate and a vanilla class: the Monostate is used to keep track
    of registered events and their handlers, while a private list for each
    instance is maintained to record the event handlers associated with
    each instance, and removing them automatically when the instance is
    destroyed.
  '/
  type _
    WithEvents _
    extends Object
    
    public:
      declare virtual destructor()
    
      declare virtual sub _
        addHandler( _
          byref as const Event, _
          byref as EventHandler )
      declare virtual sub _
        removeHandler( _
          byref as const Event, _
          byref as EventHandler )
        
    protected:
      declare constructor()
      
      declare virtual sub _
        initializeComponent()
      
      declare sub _
        register( _
          byref as Event )
      declare sub _
        raiseEvent( _
          byref as const Event, _
          byref as EventArgs )
        
    private:
      /'
        A list of linked lists that contain all the events registered and their
        listeners. The list indexes into the events registered, and the linked
        list indexes the listeners for it.
      '/
      static as List( _
        of( LinkedList( of( Listener ) ) ) ) _
        _eventListeners
      
      /'
        A lookup dictionary that caches the linked list nodes for the above linked
        list of registered handlers for each event.
        It is indexed by the address of the listeners (since they are essentially
        static functions) and is used to remove handlers quickly and efficiently.
      '/
      static as Dictionary( _
        of( uinteger ), _
        of( NodeCacheInfo ) ) _
        _eventHandlers
      
      /'
        This integer contains the id for the next event to be registered.
        Upon registration, each event is assigned an id and this member
        is increased by 1. See the implementation of the 'register()'
        method for more details.
      '/
      static as integer _
        _eventId
      
      static as integer _
        _instances
      
      /'
        The mutex for this class. Since there will be only one instance of
        this base class, we need to mutex certain calls to make it thread
        safe.
      '/
      static as any ptr _
        _mutex
      
      static as boolean _
        _initialized
      
      /'
        A linked list containing the event handlers registered for each
        instance. When the instance gets destroyed, this list is traversed
        and 'removeHandler()' is called on each item.
      '/
      as LinkedList( _
        of( NodeCacheInfo ) ) ptr _
        _registeredListeners
  end type
  
  dim as List( _
    of( LinkedList( of( Listener ) ) ) ) _
    WithEvents._eventListeners => List( _
      of( LinkedList( of( Listener ) ) ) )( 1024 )
    
  dim as Dictionary( _
    of( uinteger ), _
    of( NodeCacheInfo ) ) _
    WithEvents._eventHandlers => Dictionary( _
      of( uinteger ), _
      of( NodeCacheInfo ) )()
    
  dim as integer _
    WithEvents._eventId => NoEventsRegisteredYet, _
    WithEvents._instances => 0
  dim as any ptr _
    WithEvents._mutex => 0
  dim as boolean _
    WithEvents._initialized => false
  
  constructor _
    WithEvents()
    
    _instances +=> 1
    
    if( _
      cbool( _instances = 1 ) andAlso _
      not _initialized ) then
      
      _mutex => mutexCreate()
      _initialized => true
    end if
    
    _registeredListeners => _
      new LinkedList( _
        of( NodeCacheInfo ) )()
  end constructor
  
  destructor _
    WithEvents()
    
    _instances -=> 1
    
    if( _instances = 0 ) then
      mutexDestroy( _mutex )
      _initialized => false
    end if
    
    /'
      Remove the event handlers that are associated with this instance.
    '/
    if( _registeredListeners <> 0 ) then
      do while( _registeredListeners->count > 0 )
        var _
          nodeInfo => _registeredListeners->last->item
        
        removeHandler( _
          nodeInfo->listenerNode->item->handledEvent, _
          nodeInfo->listenerNode->item->handler )
      loop
      
      '' And dispose of the list when finished
      delete( _registeredListeners )
    end if
  end destructor
  
  /'
    Registers an event.
    
    The registration mechanism works as follows: each time a class registers
    an event, it is assigned an unique id, that the rest of the code uses to
    identify it when adding and removing handlers.
    
    Since events are to be declared as static from within the class, this also
    means that the event only gets registered _once_, the first time a class
    that registers them is instantiated. The rest of the instances won't get
    the event registered again (since its id will not be set and its 'registered'
    property will be false)
    
    This means that the entire mechanism relies on events being _static_ so
    the above condition holds. The 'id' property of events act as an opaque 
    handle, that will be used to uniquely identify each one. Note that the id
    they will get assigned depends on the order in which they get registered
    (ie its not static). To be able to reference them, the client is expected to
    expose them through *read only* const properties.
    
    Note the double-checked lock, to avoid registering two different events to the
    same id if they're registered from different threads.
  '/
  sub _
    WithEvents.register( _
      byref anEvent as Event )
    
    if( not anEvent.registered ) then
      mutexLock( _mutex )
      
      if( not anEvent.registered ) then
        '' Create the list of event listeners for this event
        _eventListeners.add( _
          new LinkedList( of( Listener ) ) )
        
        /'
          Increment the id counter. This will provide a unique id for
          each event registered.
          
          Note that the '_eventId' was initially set to -1 (which
          corresponds to the 'NoEventsRegisteredYet' constant), so the
          first event id will be effectively 0. This is important since
          events are stored in a list (whose items always start indexing
          at 0).
        '/
        _eventId +=> 1
        
        /'
          And finally fill the rest of the event data.
          
          Note that this effectively assigns a new instance of the 'Event'
          structure to the variable that was passed to the method (which is
          passed 'byref' precisely for this reason). This way, the id for the
          event gets properly encapsulated and cannot be changed anymore.
          
          This has two desirable consequences: to be able to expose the event
          directly to the client code, without worrying about the id being
          changed (inadvertently or not), and to be able to implement a syntax
          akin to that of the VB.NET event handling scheme.
        '/
        anEvent => anEvent.withId( _eventId )
      end if
      
      mutexUnlock( _mutex )
    end if
  end sub
  
  /'
    Registers a listener for the specified event, using the provided
    callback as handler.
  '/
  sub _
    WithEvents.addHandler( _
      byref anEvent as const Event, _
      byref anEventHandler as EventHandler ) export
    
    mutexLock( _mutex )
      var _
        handlers => _eventListeners.at( anEvent )
      
      if( handlers <> 0 ) then
        var _
          aListener => new Listener( _
            @anEvent, _
            anEventHandler, _
            @this, _
            anEvent.instance )
        
        /'
          The caching mechanism for the added listeners is simple: upon
          adding an item to a linked list, the method returns a pointer
          to the linked list node where it was stored. This can be used
          to make lookups into the linked list in linear time, which we
          take advantage of here by caching it and using it when removing
          the handlers (to avoid having to iterate through the entire list
          of listeners to find the one we want).
          
          This entire mechanism keeps the addition and removal of listeners
          in amortized O(1) -constant time-, instead of O(n) -linear time-
        '/
        var _
          cachedNode => new NodeCacheInfo
        
        cachedNode->listenerNode => handlers->addLast( aListener )
        
        /'
          Note that the node is cached _by reference_ into the Dictionary
          so the collection will not attempt to destroy it upon removal.
        '/
        _eventHandlers.add( _
          cast( uinteger, anEventHandler ), _
          *cachedNode )
        
        /'
          And finally, we cache the linked list node **of the caching
          structure itself**, since we also have to remove the cached
          node upon destruction of the instance.
        '/
        cachedNode->cacheInfoNode => _
          _registeredListeners->addLast( cachedNode )
      end if
    mutexUnlock( _mutex )
  end sub
  
  /'
    Removes an event handler from the list of listeners.
    
    It uses the caching info provided by both the static Dictionary
    and the instance's own caching to seek and remove the associated
    event handlers for the instance.
  '/
  sub _
    WithEvents.removeHandler( _
      byref anEvent as const Event, _
      byref anEventHandler as EventHandler ) export
    
    mutexLock( _mutex )
      var _
        handlers => _
          _eventListeners.at( anEvent ), _
        cachedNode => _
          _eventHandlers.removeItem( _
            cast( uinteger, anEventHandler ) )
      
      if( _
        handlers <> 0 andAlso _
        cachedNode <> 0 ) then
        
        handlers->remove( cachedNode->listenerNode )
        
        _registeredListeners->remove( _
          cptr( LinkedListNode( of( NodeCacheInfo ) ) ptr, _
          cachedNode->cacheInfoNode ) )
      end if
    mutexUnlock( _mutex )
  end sub
  
  /'
    Notifies all listeners of an event and passes them the event data
    specified to process it.
    
    Note that this function also passes the receiver of the event that was
    provided when the listener was first registered through the 'addHandler()'
    method so you can reference the class that implements the event handler.
  '/
  sub _
    WithEvents.raiseEvent( _
      byref anEvent as const Event, _
      byref anEventArgs as EventArgs )
    
    mutexLock( _mutex )
      var _
        listeners => _eventListeners.at( anEvent )
      
      /'
        If there are listeners for the event, traverse the list and
        notify each one of them.
      '/
      if( listeners <> 0 ) then
        var _
          node => listeners->first
        
        for _
          i as integer => 0 _
          to listeners->count - 1
          
          var _
            listener => node->item
          
          if( listener->instance = @this ) then
            /'
              Set the receiver to the one that was passed when the event
              handler was added...
            '/
            anEventArgs.Me => listener->receiver
            
            '' ...and invoke the event handler.
            ( listener->handler )( this, anEventArgs )
          end if
          
          node => node->forward
        next
      end if
    mutexUnlock( _mutex )
  end sub
  
  sub _
    WithEvents.initializeComponent()
  
  end sub
end namespace

#endif
