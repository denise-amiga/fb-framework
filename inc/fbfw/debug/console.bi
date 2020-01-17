#ifndef __FBFW_DEBUG_CONSOLE__
#define __FBFW_DEBUG_CONSOLE__

namespace Debug
  /'
    Simple yet very convenient abstraction to output to the console.
    
    The class is laid out as a Monostate, so it can be globally
    accessed throughout the entire app without needing to pass the
    instance around.
  '/
  type _
    Console _
    extends Object
    
    public:
      declare constructor()
      declare virtual destructor()
      
      declare virtual sub _
        write( _
          byref as const string )
        
    protected:
      declare property _
        opened() as boolean
      
    private:
      declare constructor( _
        byref as Console )
      declare operator _
        let( _
          byref as Console )
        
      static as integer _
        _instances
      static as long _
        _handle
  end type
  
  dim as integer _
    Console._instances => 0
  dim as long _
    Console._handle => 0
  
  constructor _
    Console()
    
    if( not opened ) then
      _handle => freeFile()
      
      open cons _
        for output _
        as _handle
    end if
    
    _instances +=> 1
  end constructor
  
  constructor _
    Console( _
      byref rhs as Console )
  end constructor
  
  operator _
    Console.let( _
      byref rhs as Console )
  end operator
  
  destructor _
    Console()
    
    _instances -=> 1
    
    if( _instances <= 0 ) then
      close( _handle )
    end if
  end destructor
  
  property _
    Console.opened() _
    as boolean
    
    return( cbool( _instances > 0 ) )
  end property
  
  sub _
    Console.write( _
      byref aString as const string )
    
    if( opened ) then
      ? #_handle, aString
    end if
  end sub
end namespace

#endif
