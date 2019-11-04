#ifndef __FB_EVENTS_EVENT__
#define __FB_EVENTS_EVENT__

namespace Events
  /'
    This structure encapsulates the info associated to an event.
    
    Note that the name provided is just for convenience (to obtain a 
    human-readable representation of the event; it's not used to 
    dispatch them), and to aid in debugging/code generation tools.
  '/
  type _
    Event
    
    public:
      declare constructor()
      declare constructor( _
        byval as integer, _
        byref as const string )
      declare constructor( _
        byref as const string )
      declare destructor()
      
      declare const operator _
        cast() as integer
      
      declare const property _
        name() as string
      declare const property _
        registered() as boolean
      
    private:
      as string _
        _name
      as integer _
        _id
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
    Note that this is the only constructor that sets the 'registered' property
    to 'true'. This is because this constructor in-cooperates with the 'WithEvents'
    class to encapsulate unique ids into each event. See the comments for the
    'WithEvents.register()' method for more details.
    
    ** IMPORTANT NOTE **
      This constructor is meant to be called FROM WITHIN THE 'WITHEVENTS' CLASS
      ONLY. Since FreeBasic doesn't support 'Friend' access control at the time of
      this writing (10/28/2019), it needs to be declared as part of the public
      interface.
      
      IF YOU INSTANTIATE THE STRUCTURE USING THIS CONSTRUCTOR AND REGISTER THE
      EVENT, YOU WILL GET WEIRD BEHAVIOR AND/OR CRASHES. *ALWAYS* USE ONE OF THE
      ABOVE CONSTRUCTORS TO PROVIDE THE INITIAL INSTANCE OF THE EVENT.
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
    Event.cast() as integer
    
    return( _id )
  end operator
  
  property _
    Event.name() as string
    
    return( _name )
  end property
  
  property _
    Event.registered() as boolean
    
    return( _registered )
  end property
end namespace

#endif
