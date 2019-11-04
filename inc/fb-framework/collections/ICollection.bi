#ifndef __FB_COLLECTIONS_ICOLLECTION__
#define __FB_COLLECTIONS_ICOLLECTION__

/'
  This one is required for keyed collections. Mangles the name of the
  template appropriately so that the base class for a keyed collection
  can be properly templated.
'/
#define ofKey( TTemplate, TKey ) _
  TTemplate##__##TKey

#define Collection( TCollection, TType ) _
  __T__##I##TCollection##__##TType

#macro template_collection( TCollection, TType... )
  #ifndef __T__##I##TCollection##__##TType
    /'
      Base class for Collections
    '/
    type _
      Collection( _
        of( TCollection ), _
        of( TType ) ) _
      extends Object
      
      declare virtual destructor()
      
      declare virtual property _
        size() as integer
      declare virtual property _
        count() as integer
      
      declare virtual function _
        clear() _
        byref as Collection( of( TCollection ), of( TType ) )
      declare virtual function _
        forEach( _
          byref as Action( of( TType ) ) ) _
        byref as Collection( of( TCollection ), of( TType ) )
      declare virtual function _
        forEach( _
          byref as Predicate( of( TType ) ), _
          byref as Action( of( TType ) ) ) _
        byref as Collection( of( TCollection ), of( TType ) )
    end type
    
    destructor _
      Collection( of( TCollection ), of( TType ) )()
    end destructor
    
    property _
      Collection( of( TCollection ), of( TType ) ).size() _
      as integer
      
      return( count )
    end property
    
    property _
      Collection( of( TCollection ), of( TType ) ).count() _
      as integer
      
      return( 0 )
    end property
    
    function _
      Collection( of( TCollection ), of( TType ) ).clear() _
      byref as Collection( of( TCollection ), of( TType ) )
      
      return( this )
    end function
    
    function _
      Collection( of( TCollection ), of( TType ) ).forEach( _
        byref anAction as Action( of( TType ) ) ) _
      byref as Collection( of( TCollection ), of( TType ) )
      
      return( this )
    end function
    
    function _
      Collection( of( TCollection ), of( TType ) ).forEach( _
        byref aPredicate as Predicate( of( TType ) ), _
        byref anAction as Action( of( TType ) ) ) _
      byref as Collection( of( TCollection ), of( TType ) )
      
      return( this )
    end function
  #endif
#endmacro

#endif
