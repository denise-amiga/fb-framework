#ifndef __FBFW_DEBUG_LOGGER__
#define __FBFW_DEBUG_LOGGER__

namespace Debug
  /'
    Simple yet very convenient abstraction to log strings to a file.
  '/
  type _
    Logger _
    extends Object
    
    public:
      declare constructor( _
        byref as const string )
      declare virtual destructor()
      
      declare virtual sub _
        write( _
          byref as const string )
        
    protected:
      declare constructor()
      
    private:
      declare constructor( _
        byref as Logger )
      declare operator _
        let( _
          byref as Logger )
        
      as string _
        _file
      as long _
        _handle
  end type
  
  constructor _
    Logger()
  end constructor
  
  constructor _
    Logger( _
      byref aFile as const string )
    
    _handle => freeFile()
    _file => aFile
    
    open _file _
      for output _
      as _handle
  end constructor
  
  constructor _
    Logger( _
      byref rhs as Logger )
  end constructor
  
  operator _
    Logger.let( _
      byref rhs as Logger )
  end operator
  
  destructor _
    Logger()
    
    close( _handle )
  end destructor
  
  sub _
    Logger.write( _
      byref aString as const string )
    
    ? #_handle, aString
  end sub
end namespace

#endif
