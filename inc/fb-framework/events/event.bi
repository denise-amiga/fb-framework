#ifndef __FB_EVENTS_EVENT__
#define __FB_EVENTS_EVENT__

namespace Events
  /'
    This structure encapsulates the info associated to an event.
    
    Note that the name property provided is just for convenience
    (to obtain a human-readable representation of the event; it's 
    not used to dispatch them), and to aid in debugging/code
    generation tools.
  '/
  type _
    Event
    
    public:
      declare constructor()
      declare constructor( _
        byref as const string )
      declare destructor()
      
      declare const operator _
        cast() as integer
      
      declare const property _
        name() as string
      declare const property _
        registered() as boolean
      declare const property _
        instance() as Object ptr
      
      declare function _
        withId( _
          byval as integer ) _
        as Event
      declare function _
        forInstance( _
          byval as Object ptr ) _
        byref as Event
      
    private:
      declare constructor( _
        byval as integer, _
        byref as const string )
      
      as string _
        _name
      as integer _
        _id
      as Object ptr _
        _instance
      as boolean _
        _registered
  end type
  
  constructor _
    Event()
    
    this.constructor( "<unknown>" )
  end constructor
  
  constructor _
    Event( _
      byref aName as const string )
    
    _name => aName
  end constructor
  
  /'
    This private constructor is used when registering an event
    for the first time. When an id for the event is assigned, the
    'registered' property is set to true so that the event won't
    be registered twice.
  '/
  constructor _
    Event( _
      byval anId as integer, _
      byref aName as const string )
    
    _id => anId
    _name => aName
    _registered => true
  end constructor
  
  destructor _
    Event()
  end destructor
  
  operator _
    Event.cast() _
    as integer
    
    return( _id )
  end operator
  
  property _
    Event.name() _
    as string
    
    return( _name )
  end property
  
  property _
    Event.registered() _
    as boolean
    
    return( _registered )
  end property
  
  property _
    Event.instance() _
    as Object ptr
    
    return( _instance )
  end property
  
  /'
    This factory method returns a copy of this event but with the
    specified id encapsulated into it. Used when registering events
    (see the implementation of the 'WithEvents.register()' method for
    details).
  '/
  function _
    Event.withId( _
      byval anId as integer ) _
    as Event
    
    return( Event( _
      anId, _
      _name ) )
  end function
  
  /'
    This method assigns the specified pointer to the 'instance' property
    of the 'Event' type. Required when you expose the event to the client
    code, so the dispatch mechanism can discriminate which instance is
    raising the event, so the appropriate handler can be invoked.
  '/
  function _
    Event.forInstance( _
      byval anInstance as Object ptr ) _
    byref as Event
    
    _instance => anInstance
    
    return( this )
  end function
end namespace

#endif
