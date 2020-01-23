#ifndef __FBFW_COLLECTIONS_LIST__
#define __FBFW_COLLECTIONS_LIST__

#macro template_list( TCollection, TType... )
  templateFor( ListElement )
  templateFor( List )
  
  template_predicate( __tcar__( TType ) )
  template_action( __tcar__( TType ) )
  template_collection( TCollection, __tcar__( TType ) )
  declare_auto_ptr( of( List( __tcar__( TType ) ) ) )
  
  /'
    Represents an element in an array-like list
  '/
  #ifndef __T__##ListElement##__##TType##__
    type _
      ListElement( of( TType ) )
      
      public:
        declare constructor( _
          byval as TType ptr, _
          byval as boolean, _
          byval as sub( _
            byval as TType ptr ) )
        declare destructor()
        
        as TType ptr _
          _item
        
      private:
        declare constructor()
        declare constructor( _
          byref as ListElement( of( TType ) ) )
        declare operator _
          let( _
            byref as ListElement( of( TType ) ) )
          
        as boolean _
          _needsDisposing
        as sub( _
          byval as TType ptr ) _
        _disposeCallback
    end type
    
    constructor _
      ListElement( of( TType ) )()
    end constructor
    
    constructor _
      ListElement( of( TType ) )( _
        byval anItem as TType ptr, _
        byval aNeedsDisposing as boolean, _
        byval aDisposeCallback as sub( _
          byval as TType ptr ) )
        
      _item => anItem
      _needsDisposing => aNeedsDisposing
      _disposeCallback => aDisposeCallback
    end constructor
    
    constructor _
      ListElement( of( TType ) )( _
        byref rhs as ListElement( of( TType ) ) )
    end constructor
    
    destructor _
      ListElement( of( TType ) )()
      
      if( _needsDisposing ) then
        if( _disposeCallback <> 0 ) then
          _disposeCallback( _item )
        else
          delete( _item )
        end if
      end if
    end destructor
    
    operator _
      ListElement( of( TType ) ).let( _
        byref rhs as ListElement( of( TType ) ) )
    end operator
    
    operator _
      =( _
        byref lhs as ListElement( of( TType ) ), _
        byref rhs as ListElement( of( TType ) ) ) _
      as integer
      
      return( lhs._item = rhs._item )
    end operator
  #endif
  
  /'
    Represents a strongly-typed array-like list.
    
    It dynamically grows or shrinks to accomodate the amount of entries 
    put into it. However, there is some extra space allocated, to avoid 
    having to resize the array every time an item is added or removed 
    from it.
    
    So, the list grows or shrinks by an amount of elements equal to the 
    initial size given (also called the 'capacity').
  '/
  type _
    List( of( TType ) ) _
    extends Collection( _
      of( TCollection ), of( TType ) )
    
    public:
      declare constructor()
      declare constructor( _
        byval as integer )
      declare constructor( _
        byval as sub( _
          byval as TType ptr ) )
      declare constructor( _
        byval as integer, _
        byval as sub( _
          byval as TType ptr ) )
      declare virtual destructor() override
      
      declare property _
        size() as integer override
      declare property _
        count() as integer override
      declare property _
        at( _
          byval as integer ) _
        as TType ptr
      declare property _
        item( _
          byval as integer ) _
        byref as TType
      declare property _
        elements() _
        as ListElement( of( TType ) ) ptr ptr
      
      declare function _
        clear() _
        byref as List( of( TType ) ) override
      declare function _
        contains( _
          byref as const TType ) _
        as boolean
      declare function _
        containsItem( _
          byref as TType ) _
        as boolean
      declare function _
        indexOf( _
          byref as const TType ) _
        as integer
      declare function _
        add( _
          byval as TType ptr, _
          byref as const TType ) _
        byref as List( of( TType ) )
      declare function _
        add( _
          byref as const TType ) _
        byref as List( of( TType ) )
      declare function _
        add( _
          byval as TType ptr ) _
        byref as List( of( TType ) )
      declare function _
        addRange( _
          byref as List( of( TType ) ) ) _
        byref as List( of( TType ) )
      declare function _
        insert( _
          byval as TType ptr, _
          byref as const TType, _
          byval as integer ) _
        byref as List( of( TType ) )
      declare function _
        insert( _
          byref as const TType, _
          byval as integer ) _
        byref as List( of( TType ) )
      declare function _
        insert( _
          byval as TType ptr, _
          byval as integer ) _
        byref as List( of( TType ) )
      declare function _
        insertRange( _
          byref as List( of( TType ) ), _
          byval as integer ) _
        byref as List( of( TType ) )
      declare function _
        remove( _
          byref as const TType ) _
        byref as List( of( TType ) )
      declare function _
        removeAt( _
          byval as integer ) _
        byref as List( of( TType ) )
      declare function _
        removeRange( _
          byval as integer, _
          byval as integer ) _
        byref as List( of( TType ) )
      
      declare function _
        forEach( _
          byref as Action( of( TType ) ) ) _
        byref as List( of( TType ) ) override
      declare function _
        forEach( _
          byref as ActionFunc( of( TType ) ), _
          byval as any ptr => 0 ) _
        byref as List( of( TType ) ) override
      declare function _
        forEach( _
          byref as Predicate( of( TType ) ), _
          byref as Action( of( TType ) ) ) _
        byref as List( of( TType ) ) override
      declare function _
        forEach( _
          byref as PredicateFunc( of( TType ) ), _
          byref as ActionFunc( of( TType ) ), _
          byval as any ptr => 0, _
          byval as any ptr => 0 ) _
        byref as List( of( TType ) ) override
      
      declare function _
        selectFirst( _
          byref as Predicate( of( TType ) ) ) _
        as TType ptr
      declare function _
        selectFirst( _
          byref as PredicateFunc( of( TType ) ), _
          byval as any ptr => 0 ) _
        as TType ptr
      declare function _
        selectLast( _
          byref as Predicate( of( TType ) ) ) _
        as TType ptr
      declare function _
        selectLast( _
          byref as PredicateFunc( of( TType ) ), _
          byval as any ptr => 0 ) _
        as TType ptr
      declare function _
        selectAll( _
          byref as Predicate( of( TType ) ) ) _
        as Auto_ptr( of( List( of( TType ) ) ) )
      declare function _
        selectAll( _
          byref as PredicateFunc( of( TType ) ), _
          byval as any ptr => 0 ) _
        as Auto_ptr( of( List( of( TType ) ) ) )
      
    private:
      declare constructor( _
        byref as List( of( TType ) ) )
      declare operator _
        let( _
          byref as List( of( TType ) ) )
        
      declare sub _
        dispose()
      
      declare function _
        addElement( _
          byval as TType ptr, _
          byval as boolean ) _
        byref as List( of( TType ) )
      declare function _
        insertElement( _
          byval as TType ptr, _
          byval as integer, _
          byval as boolean ) _
        byref as List( of( TType ) )
      declare sub _
        resize( _
          byval as integer )
        
      declare function _
        selectOne( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byval as Predicate( of( TType ) ) ptr ) _
        as TType ptr
      declare function _
        selectOne( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as PredicateFunc( of( TType ) ), _
          byval as any ptr => 0 ) _
        as TType ptr
      declare function _
        selectMany( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byval as Predicate( of( TType ) ) ptr ) _
        as Auto_ptr( of( List( of( TType ) ) ) )
      declare function _
        selectMany( _
          byval as integer, _
          byval as integer, _
          byval as integer, _
          byref as PredicateFunc( of( TType ) ), _
          byval as any ptr => 0 ) _
        as Auto_ptr( of( List( of( TType ) ) ) )
      
      as ListElement( of( TType ) ) ptr _
        _elements( any )
      as integer _
        _count, _
        _size, _
        _initialSize, _
        _lowerBound
      
      as sub( _
        byval as TType ptr ) _
      _disposeCallback
  end type
  
  implement_auto_ptr( of( List( __tcar__( TType ) ) ) )
  
  constructor _
    List( of( TType ) )()
    
    this.constructor( 32, 0 )
  end constructor
  
  constructor _
    List( of( TType ) )( _
      byval aSize as integer )
    
    this.constructor( aSize, 0 )
  end constructor
  
  constructor _
    List( of( TType ) )( _
      byval aDisposeCallback as sub( _
        byval as TType ptr ) )
      
    this.constructor( 32, aDisposeCallback )
  end constructor
  
  constructor _
    List( of( TType ) )( _
      byval aSize as integer, _
      byval aDisposeCallback as sub( _
        byval as TType ptr ) )
      
    _size => iif( aSize < 16, 16, aSize )
    
    _initialSize => _size
    _count => 0
    _lowerBound => 0
    
    redim _
      _elements( 0 to _size - 1 )
    
    _disposeCallback => aDisposeCallback
  end constructor
  
  constructor _
    List( of( TType ) )( _
      byref rhs as List( of( TType ) ) )
  end constructor
  
  operator _
    List( of( TType ) ).let( _
      byref rhs as List( of( TType ) ) )
  end operator
  
  destructor _
    List( of( TType ) )()
    
    dispose()
  end destructor
  
  sub _
    List( of( TType ) ).dispose()
    
    for _
      i as integer => 0 _
      to _size - 1
      
      if( _elements( i ) <> 0 ) then
        delete( _elements( i ) )
        _elements( i ) => 0
      end if
    next
  end sub
  
  /'
    Resizes the internal array.
    
    The algorithm works like the one of the Array collection. See the
    implementation there for details.
  '/
  sub _
    List( of( TType ) ).resize( _
      byval newSize as integer )
    
    newSize => iif( _
      newSize < _initialSize, _
      _initialSize, newSize )
    
    _size => newSize
    
    _lowerBound => _
      _size - _initialSize - ( _initialSize shr 1 )
    _lowerBound => iif( _
      _lowerBound < _initialSize, _
      0, _lowerBound )
    
    redim preserve _
      _elements( 0 to _size - 1 )
  end sub
  
  property _
    List( of( TType ) ).size() _
    as integer
    
    return( _size )
  end property
  
  property _
    List( of( TType ) ).count() _
    as integer
    
    return( _count )
  end property
  
  /'
    Returns the value associated with the specified index
  '/
  property _
    List( of( TType ) ).at( _
      byval index as integer ) _
    as TType ptr 
    
    return( _elements( index )->_item )
  end property
  
  property _
    List( of( TType ) ).item( _
      byval index as integer ) _
    byref as TType
    
    return( *( _elements( index )->_item ) )
  end property
  
  property _
    List( of( TType ) ).elements() _
    as ListElement( of( TType ) ) ptr ptr
    
    return( @_elements( 0 ) )
  end property
  
  function _
    List( of( TType ) ).contains( _
      byref anItem as const TType ) _
    as boolean
    
    return( cbool( indexOf( anItem ) > 0 ) )
  end function
  
  function _
    List( of( TType ) ).containsItem( _
      byref anItem as TType ) _
    as boolean
    
    dim as boolean _
      found => false
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( @anItem = _elements( i )->_item ) then
        found => true
        exit for
      end if
    next
    
    return( found )
  end function
  
  function _
    List( of( TType ) ).indexOf( _
      byref anItem as const TType ) _
    as integer
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( cptr( TType ptr, @anItem ) = _elements( i )->_item ) then
        return( i )
      end if
    next
    
    return( -1 )
  end function
  
  function _
    List( of( TType ) ).clear() _
    byref as List( of( TType ) )
    
    dispose()
    
    _size => _initialSize
    _count => 0
    _lowerBound => 0
    
    redim _
      _elements( 0 to _size - 1 )
    
    return( this )
  end function
  
  function _
    List( of( TType ) ).addElement( _
      byval anItem as TType ptr, _
      byval needsDisposing as boolean ) _
    byref as List( of( TType ) )
    
    _count +=> 1
    
    if( _count > ( _size - _initialSize shr 1 ) ) then
      '' Resize the internal array if it's necessary
      resize( _size + _initialSize )
    end if
    
    '' And add the element to the end of the list
    _elements( _count - 1 ) => _
      new ListElement( of( TType ) )( _
        anItem, _
        needsDisposing, _
        _disposeCallback )
      
    return( this )
  end function
  
  /'
    Inserts an element at the specified index.
  '/
  function _
    List( of( TType ) ).insertElement( _
      byval anElement as TType ptr, _
      byval index as integer, _
      byval needsDisposing as boolean ) _
    byref as List( of( TType ) )
    
    if( _count < 1 ) then
      '' List is empty, simply add the element and be done with it
      addElement( _
        anElement, _
        needsDisposing )
    else
      '' If list is not empty, insert the element
      if( index > _count - 1 ) then
        '' If index is out of range, add it at the end of the list
        addElement( _
          anElement, _
          needsDisposing )
      else
        '' If not, add it at the requested place
        _count +=> 1
        
        if( _count > ( _size - _initialSize shr 1 ) ) then
          '' Resize the internal array if it's necessary
          resize( _size + _initialSize )
        end if
        
        '' Move the items to make room for the inserted one
        if( index < _count - 1 ) then
          for _
            i as integer => _count - 1 _
            to index step -1
            
            _elements( i ) => _elements( i - 1 )
          next
        end if
        
        '' And add the item at the requested position
        _elements( index ) => _
          new ListElement( of( TType ) )( _
            anElement, _
            needsDisposing, _
            _disposeCallback )
      end if
    end if
    
    return( this )
  end function
  
  function _
    List( of( TType ) ).add( _
      byval anItem as TType ptr, _
      byref aValue as const TType ) _
    byref as List( of( TType ) )
    
    *anItem => aValue
    
    return( addElement( _
      anItem, _
      true ) )
  end function
  
  function _
    List( of( TType ) ).add( _
      byref anItem as const TType ) _
    byref as List( of( TType ) )
    
    return( addElement( _
      cptr( TType ptr, @anItem ), _
      false ) )
  end function
  
  function _
    List( of( TType ) ).add( _
      byval anItem as TType ptr ) _
    byref as List( of( TType ) )
    
    return( addElement( _
      anItem, _
      true ) )
  end function
  
  function _
    List( of( TType ) ).addRange( _
      byref aList as List( of( TType ) ) ) _
    byref as List( of( TType ) )
    
    for _
      i as integer => 0 _
      to aList.count - 1
      
      add( *aList.at( i ) )
    next
    
    return( this )
  end function
  
  function _
    List( of( TType ) ).insert( _
      byval anItem as TType ptr, _
      byref aValue as const TType, _
      byval anIndex as integer ) _
    byref as List( of( TType ) )
    
    *anItem => aValue
    
    return( insertElement( _
      anItem, _
      anIndex, _
      true ) )
  end function
  
  function _
    List( of( TType ) ).insert( _
      byref anItem as const TType, _
      byval anIndex as integer ) _
    byref as List( of( TType ) )
    
    return( insertElement( _
      cptr( TType ptr, @anItem ), _
      anIndex, _
      false ) )
  end function
  
  function _
    List( of( TType ) ).insert( _
      byval anItem as TType ptr, _
      byval anIndex as integer ) _
    byref as List( of( TType ) )
    
    return( insertElement( _
      anItem, _
      anIndex, _
      true ) )
  end function
  
  function _
    List( of( TType ) ).insertRange( _
      byref aList as List( of( TType ) ), _
      byval anIndex as integer ) _
    byref as List( of( TType ) )
    
    for _
      i as integer => aList.count - 1 _
      to 0 step -1
      
      insert( _
        *aList.at( i ), _
        anIndex )
    next
    
    return( this )
  end function
  
  /'
    Removes the specified element
  '/
  function _
    List( of( TType ) ).remove( _
      byref anItem as const TType ) _
    byref as List( of( TType ) )
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( cptr( TType ptr, @anItem ) = _elements( i )->_item ) then
        removeAt( i )
        exit for
      end if
    next
    
    return( this )
  end function
  
  /'
    Removes the element at the specified index.
  '/
  function _
    List( of( TType ) ).removeAt( _
      byval index as integer ) _
    byref as List( of( TType ) )
    
    if( _count > 0 ) then
      dim as ListElement( of( TType ) ) ptr _
        element => _elements( index )
      
      /'
        Removes element and adjust the others to fill the blanks
        if needed.
      '/
      if( index < _count - 1 ) then
        for _
          i as integer => index _
          to _count - 1
          
          _elements( i ) => _elements( i + 1 )
        next
      end if
      
      delete( element )
      _count -=> 1
      
      '' Resize the list if needed
      if( _count <= _lowerBound ) then
        resize( _size - _initialSize )
      end if 
    end if
    
    return( this )
  end function
  
  function _
    List( of( TType ) ).removeRange( _
      byval anIndex as integer, _
      byval aCount as integer ) _
    byref as List( of( TType ) )
    
    for _
      i as integer => 0 _
      to aCount - 1
      
      removeAt( anIndex )
    next
    
    return( this )
  end function
  
  function _
    List( of( TType ) ).forEach( _
      byref anAction as Action( of( TType ) ) ) _
    byref as List( of( TType ) )
    
    for _
      i as integer => 0 _
      to _count - 1
      
      anAction.indexOf => i
      anAction.invoke( _elements( i )->_item )
    next
    
    return( this )
  end function
  
  function _
    List( of( TType ) ).forEach( _
      byref anActionFunc as ActionFunc( of( TType ) ), _
      byval anActionParam as any ptr => 0 ) _
    byref as List( of( TType ) )
    
    for _
      i as integer => 0 _
      to _count - 1
      
      anActionFunc( i, _elements( i )->_item, anActionParam )
    next
    
    return( this )
  end function
  
  function _
    List( of( TType ) ).forEach( _
      byref aPredicate as Predicate( of( TType ) ), _
      byref anAction as Action( of( TType ) ) ) _
    byref as List( of( TType ) )
    
    for _
      i as integer => 0 _
      to _count - 1
      
      aPredicate.indexOf => i
      
      if( aPredicate.eval( _elements( i )->_item ) ) then
        anAction.indexOf => i
        anAction.invoke( _elements( i )->_item )
      end if
    next
    
    return( this )
  end function
  
  function _
    List( of( TType ) ).forEach( _
      byref aPredicateFunc as PredicateFunc( of( TType ) ), _
      byref anActionFunc as ActionFunc( of( TType ) ), _
      byval aPredicateParam as any ptr => 0, _
      byval anActionParam as any ptr => 0 ) _
    byref as List( of( TType ) )
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( aPredicateFunc( _
        i, _
        _elements( i )->_item, _
        aPredicateParam ) ) then
        
        anActionFunc( i, _elements( i )->_item, anActionParam )
      end if
    next
    
    return( this )
  end function
  
  function _
    List( of( TType ) ).selectOne( _
      byval first as integer, _
      byval last as integer, _
      byval inc as integer, _
      byval aPredicate as Predicate( of( TType ) ) ptr ) _
    as TType ptr
    
    dim as TType ptr _
      result
    
    for _
      i as integer => first _
      to last step inc
      
      aPredicate->indexOf => i
      
      if( aPredicate->eval( _elements( i )->_item ) ) then
        result => _elements( i )->_item
        exit for
      end if
    next
    
    return( result )
  end function
  
  function _
    List( of( TType ) ).selectOne( _
      byval first as integer, _
      byval last as integer, _
      byval inc as integer, _
      byref aPredicate as PredicateFunc( of( TType ) ), _
      byval aParam as any ptr => 0 ) _
    as TType ptr
    
    dim as TType ptr _
      result
    
    for _
      i as integer => first _
      to last step inc
      
      if( aPredicate( i, _elements( i )->_item, aParam ) ) then
        result => _elements( i )->_item
        exit for
      end if
    next
    
    return( result )
  end function
  
  function _
    List( of( TType ) ).selectMany( _
      byval first as integer, _
      byval last as integer, _
      byval inc as integer, _
      byval aPredicate as Predicate( of( TType ) ) ptr ) _
    as Auto_ptr( of( List( of( TType ) ) ) )
    
    var _
      result => new List( of( TType ) )
    
    for _
      i as integer => first _
      to last step inc
      
      aPredicate->indexOf => i
      
      if( aPredicate->eval( _elements( i )->_item ) ) then
        result->add( *_elements( i )->_item )
      end if
    next
    
    return( Auto_ptr( of( List( of( TType ) ) ) )( result ) )
  end function
  
  function _
    List( of( TType ) ).selectMany( _
      byval first as integer, _
      byval last as integer, _
      byval inc as integer, _
      byref aPredicate as PredicateFunc( of( TType ) ), _
      byval aParam as any ptr => 0 ) _
    as Auto_ptr( of( List( of( TType ) ) ) )
    
    var _
      result => new List( of( TType ) )
    
    for _
      i as integer => first _
      to last step inc
      
      if( aPredicate( i, _elements( i )->_item, aParam ) ) then
        result->add( *_elements( i )->_item )
      end if
    next
    
    return( Auto_ptr( of( List( of( TType ) ) ) )( result ) )
  end function
  
  function _
    List( of( TType ) ).selectFirst( _
      byref aPredicate as Predicate( of( TType ) ) ) _
    as TType ptr
    
    return( selectOne( 0, _count - 1, 1, @aPredicate ) )
  end function
  
  function _
    List( of( TType ) ).selectFirst( _
      byref aPredicate as PredicateFunc( of( TType ) ), _
      byval aParam as any ptr => 0 ) _
    as TType ptr
    
    return( selectOne( 0, _count - 1, 1, aPredicate, aParam ) )
  end function
  
  function _
    List( of( TType ) ).selectLast( _
      byref aPredicate as Predicate( of( TType ) ) ) _
    as TType ptr
    
    return( selectOne( _count - 1, 0, -1, @aPredicate ) )
  end function
  
  function _
    List( of( TType ) ).selectLast( _
      byref aPredicate as PredicateFunc( of( TType ) ), _
      byval aParam as any ptr => 0 ) _
    as TType ptr
    
    return( selectOne( _count - 1, 0, -1, aPredicate, aParam ) )
  end function
  
  function _
    List( of( TType ) ).selectAll( _
      byref aPredicate as Predicate( of( TType ) ) ) _
    as Auto_ptr( of( List( of( TType ) ) ) )
    
    return( selectMany( 0, _count - 1, 1, @aPredicate ) )
  end function
  
  function _
    List( of( TType ) ).selectAll( _
      byref aPredicate as PredicateFunc( of( TType ) ), _
      byval aParam as any ptr => 0 ) _
    as Auto_ptr( of( List( of( TType ) ) ) )
    
    return( selectMany( 0, _count - 1, 1, aPredicate, aParam ) )
  end function
  
  operator _
    =( _
      byref lhs as List( of( TType ) ), _
      byref rhs as List( of( TType ) ) ) _
    as integer
    
    return( @lhs = @rhs )
  end operator
  
  operator _
    <>( _
      byref lhs as List( of( TType ) ), _
      byref rhs as List( of( TType ) ) ) _
    as integer
    
    return( @lhs <> @rhs )
  end operator
#endmacro

#endif
