#ifndef __FBFW_COLLECTIONS_TKEYS__
#define __FBFW_COLLECTIONS_TKEYS__

#define Key( TType ) _
  __T__##Key##__##TType

/'
  Keys for all FreeBasic standard data types
'/
type _
  Key( of( string ) )
  
  public:
    declare constructor()
    declare constructor( _
      byref as const string )
    declare constructor( _
      byref as Key( of( string ) ) )
    declare destructor()
    
    declare operator _
      let( _
        byref as string )
    declare operator _
      let( _
        byref as Key( of( string ) ) )
      
    declare function _
      getHashCode() as ulong
    
    as string _
      value
end type

constructor _
  Key( of( string ) )()
end constructor

constructor _
  Key( of( string ) )( _
    byref aKey as const string )
  
  value => aKey
end constructor

constructor _
  Key( of( string ) )( _
    byref rhs as Key( of( string ) ) )
  
  value => rhs.value
end constructor

destructor _
  Key( of( string ) )()
end destructor

operator _
  Key( of( string ) ).let( _
    byref rhs as string )
  
  value => rhs
end operator

operator _
  Key( of( string ) ).let( _
    byref rhs as Key( of( string ) ) )
  
  value => rhs.value
end operator

function _
  Key( of( string ) ).getHashCode() _
  as ulong
  
  dim as ulong _
    hash
  
  for _
    i as integer => 0 _
    to len( value ) - 1
    
    hash => ( hash shl 4 ) xor _
      ( hash shr 28 ) xor ( value )[ i ]
  next
  
  return( hash )
end function

operator _
  =( _
    byref lhs as Key( of( string ) ), _
    byref rhs as Key( of( string ) ) ) _
  as integer
  
  return( lhs.value = rhs.value )
end operator

#macro template_key( TType )
  #ifndef __T__##Key##__##TType
    type _
      Key( of( TType ) )
      
      public:
        declare constructor()
        declare constructor( _
          byref as const TType )
        declare constructor( _
          byref as Key( of( TType ) ) )
        declare destructor()
        
        declare operator _
          let( _
            byref as TType )
        declare operator _
          let( _
            byref as Key( of( TType ) ) )
          
        declare function _
          getHashCode() as ulong
        
        as TType _
          value
    end type
    
    constructor _
      Key( of( TType ) )()
    end constructor
    
    constructor _
      Key( of( TType ) )( _
        byref aValue as const TType )
      
      value => aValue
    end constructor
    
    constructor _
      Key( of( TType ) )( _
        byref aKey as Key( of( TType ) ) )
      
      value => aKey.value
    end constructor
    
    destructor _
      Key( of( TType ) )()
    end destructor
    
    operator _
      Key( of( TType ) ).let( _
        byref aValue as TType )
      
      value => aValue
    end operator
    
    operator _
      Key( of( TType ) ).let( _
        byref aKey as Key( of( TType ) ) )
      
      value => aKey.value
    end operator
    
    function _
      Key( of( TType ) ).getHashCode() _
      as ulong
      
      return( culng( value ) )
    end function
    
    operator _
      =( _
        byref lhs as Key( of( TType ) ), _
        byref rhs as Key( of( TType ) ) ) _
      as integer
      
      return( lhs.value = rhs.value )
    end operator
  #endif
#endmacro

#macro template_key_float( TType )
  #ifndef __T__##Key##__##TType
    type _
      Key( of( TType ) )
      
      public:
        declare constructor()
        declare constructor( _
          byref as const TType )
        declare constructor( _
          byref as Key( of( TType ) ) )
        declare destructor()
        
        declare operator _
          let( _
            byref as TType )
        declare operator _
          let( _
            byref as Key( of( TType ) ) )
          
        declare function _
          getHashCode() as ulong
        
        as TType _
          value
    end type
    
    constructor _
      Key( of( TType ) )()
    end constructor
    
    constructor _
      Key( of( TType ) )( _
        byref aValue as const TType )
      
      value => aValue
    end constructor
    
    constructor _
      Key( of( TType ) )( _
        byref aKey as Key( of( TType ) ) )
      
      value => aKey.value
    end constructor
    
    destructor _
      Key( of( TType ) )()
    end destructor
    
    operator _
      Key( of( TType ) ).let( _
        byref aValue as TType )
      
      value => aValue
    end operator
    
    operator _
      Key( of( TType ) ).let( _
        byref aKey as Key( of( TType ) ) )
      
      value => aKey.value
    end operator
    
    function _
      Key( of( TType ) ).getHashCode() _
      as ulong
      
      return( *cptr( ulong ptr, @value ) )
    end function
    
    operator _
      =( _
        byref lhs as Key( of( TType ) ), _
        byref rhs as Key( of( TType ) ) ) _
      as integer
      
      return( lhs.value = rhs.value )
    end operator
  #endif
#endmacro

template_key( byte )
template_key( ubyte )
template_key( short )
template_key( ushort )
template_key( long )
template_key( ulong )
template_key( integer )
template_key( uinteger )
template_key( boolean )

template_key_float( single )
template_key_float( double )

#endif
