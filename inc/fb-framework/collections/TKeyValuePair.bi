#ifndef __FB_COLLECTIONS__KEYVALUEPAIR__
#define __FB_COLLECTIONS__KEYVALUEPAIR__

/'
  Template for key-value pairs, to be used in keyed collections.
'/
#define KeyValuePair( TKey, TType ) _
  __T__##KeyValuePair##__##TKey##__##TType

#macro template_keyValuePair( TKey, TType )
  #ifndef __T__##KeyValuePair##__##TKey##__##TType
    type _
      KeyValuePair( _
        of( TKey ), of( TType ) )
      
      public:
        declare constructor()
        declare constructor( _
          byref as Key( of( TKey ) ), _
          byref as const TType )
        declare constructor( _
          byref as Key( of( TKey ) ), _
          byval as TType ptr )
        declare constructor( _
          byref as KeyValuePair( _
            of( TKey ), of( TType ) ) )
        declare destructor()
        
        declare operator _
          let( _
            byref as KeyValuePair( _
              of( TKey ), of( TType ) ) )
            
        as Key( of( TKey ) ) _
          _key
        as TType ptr _
          _value
        
      private:
        as boolean _
          _needsDisposing
    end type
    
    constructor _
      KeyValuePair( of( TKey ), of( TType ) )()
    end constructor
    
    constructor _
      KeyValuePair( of( TKey ), of( TType ) )( _
        byref aKey as Key( of( TKey ) ), _
        byval aValue as TType ptr )
      
      _key => aKey
      _value => aValue
      _needsDisposing => true
    end constructor
    
    constructor _
      KeyValuePair( of( TKey ), of( TType ) )( _
        byref aKey as Key( of( TKey ) ), _
        byref aValue as const TType )
      
      _key => aKey
      _value => cptr( TType ptr, @aValue )
      _needsDisposing => false
    end constructor
    
    constructor _
      KeyValuePair( of( TKey ), of( TType ) )( _
        byref rhs as KeyValuePair( of( TKey ), of( TType ) ) )
      
      _key => rhs._key
      _value => rhs._value
      _needsDisposing => rhs._needsDisposing
    end constructor
    
    destructor _
      KeyValuePair( of( TKey ), of( TType ) )()
      
      if( _
        _needsDisposing andAlso _
        _value <> 0 ) then
        
        delete( _value )
      end if
    end destructor
    
    operator _
      KeyValuePair( of( TKey ), of( TType ) ).let( _
        byref rhs as KeyValuePair( of( TKey ), of( TType ) ) )
      
      _key => rhs._key
      _value => rhs._value
      _needsDisposing => rhs._needsDisposing
    end operator
  #endif
#endmacro

#endif
