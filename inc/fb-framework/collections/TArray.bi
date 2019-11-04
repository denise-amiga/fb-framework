#ifndef __FB_COLLECTIONS_ARRAY__
#define __FB_COLLECTIONS_ARRAY__

#macro template_array( TCollection, TType... )
  templateFor( Array )
  
  template_predicate( __tcar__( TType ) )
  template_action( __tcar__( TType ) )
  
  template_collection( TCollection, __tcar__( TType ) )
  declare_auto_ptr( of( Array( __tcar__( TType ) ) ) )
  
  /'
    Represents a strongly typed dynamic array.
    
    Notice that, to be able to template it, the templated type *MUST*
    implement a default constructor, a copy constructor and the
    assignment operator. Primarily meant for standard data types and
    POD structures.
    
    TODO:
      - Implement multi-dimensional Arrays by using a variadic macro.
        I'm not too sure of the usefulness of this, though.
  '/
  type _
    Array( of( TType ) ) _
    extends Collection( _
      of( TCollection ), of( TType ) )
    
    public:
      declare constructor()
      declare constructor( _
        byval as integer )
      declare virtual destructor() override
      
      declare property _
        count() as integer override
      declare property _
        size() as integer override
      declare property _
        at( _
          byval as integer ) _
        byref as TType
      declare property _
        elements() as TType ptr
      
      declare function _
        add( _
          byref as TType ) _
        byref as Array( of( TType ) )
      declare function _
        remove( _
          byval as integer ) _
        byref as Array( of( TType ) )
      declare function _
        insert( _
          byref as TType, _
          byval as integer ) _
        byref as Array( of( TType ) )
      declare function _
        clear() _
        byref as Array( of( TType ) ) override
      
      declare function _
        findAll( _
          byref as Predicate( of( TType ) ) ) _
        as Array( of( TType ) )
      declare function _
        forEach( _
          byref as Action( of( TType ) ) ) _
        byref as Array( of( TType ) ) override
      declare function _
        forEach( _
          byref as Predicate( of( TType ) ), _
          byref as Action( of( TType ) ) ) _
        byref as Array( of( TType ) ) override
      
    protected:
      declare sub _
        resize( _
          byval as integer )
        
    private:
      as TType _
        _array( any )
      as integer _
        _initialSize, _
        _count, _
        _size, _
        _lowerbound
  end type
  
  implement_auto_ptr( of( Array( __tcar__( TType ) ) ) )
  
  constructor _
    Array( of( TType ) )()
    
    this.constructor( 16 )
  end constructor
  
  constructor _
    Array( of( TType ) )( _
      byval aSize as integer )
    
    _size => iif( _
      aSize < 16, 16, aSize )
    
    _initialSize => _size
    _count => 0
    _lowerBound => 0
    
    redim _
      _array( 0 to _size - 1 )
  end constructor
  
  destructor _
    Array( of( TType ) )()
  end destructor
  
  property _
    Array( of( TType ) ).count() _
    as integer
    
    return( _count )
  end property
  
  property _
    Array( of( TType ) ).size() _
    as integer
    
    return( _size )
  end property
  
  property _
    Array( of( TType ) ).at( _
      byval index as integer ) _
    byref as TType
    
    return( _array( index ) )
  end property
  
  property _
    Array( of( TType ) ).elements() _
    as TType ptr
    
    return( @_array( 0 ) )
  end property
  
  /'
    Resizes the internal array.
    
    The algorithm works like this:
    When the array is instantiated, the initial size is recorded, and
    it's used to determine when the array is to be resized, and by how
    much. In this case, the array grows every time the number of items
    exceed the initial value by half, and shrinks every time that the
    previous size is exceeded, also by half.
    
    This way, there is a 'window', centered around the current item count. 
    Hence, most of the resizing will happen during bulk addition or deletion
    operations, not when there's a relatively balanced number of them. 
    
    The array would never resize below the initial size requested.
    
    TODO:
      - The algorithm is the same as the one used for Lists. Perhaps
        both can use the same function, to improve code size.
  '/
  sub _
    Array( of( TType ) ).resize( _
      byval aNewSize as integer )
      
      aNewSize => iif( _
        aNewSize < _initialSize, _
        _initialSize, _
        aNewSize )
      
      _size => aNewSize
      
      _lowerBound => _
        _size - _initialSize - ( _initialSize shr 1 )
      
      _lowerBound => iif( _
        _lowerBound < _initialSize, _
        0, _
        _lowerBound )
      
      redim preserve _
        _array( 0 to _size - 1 )
  end sub
  
  /'
    Clears the array
  '/
  function _
    Array( of( TType ) ).clear() _
    byref as Array( of( TType ) )
    
    _size => _initialSize
    _count => 0
    _lowerBound => 0
    
    redim _
      _array( 0 to _size - 1 )
    
    return( this )
  end function
  
  /'
    Adds an element to the array
  '/
  function _
    Array( of( TType ) ).add( _
      byref anElement as TType ) _
    byref as Array( of( TType ) )
    
    _count +=> 1
    
    if( _count > _size - _initialSize shr 1 ) then
      '' Resize the internal array if it's necessary
      resize( _size + _initialSize )
    end if
    
    '' And add the element to the end of the array
    _array( _count - 1 ) => anElement
    
    return( this )
  end function
  
  /'
    Removes an element from the array and adjust the others to fill the blanks
    if needed.
  '/
  function _
    Array( of( TType ) ).remove( _
      byval index as integer ) _
    byref as Array( of( TType ) )
    
    if( index < _count - 1 ) then
      for _
        i as integer => index _
        to _count - 1
        
        _array( i ) => _array( i + 1 )
      next
    end if
    
    _count -=> 1
    
    '' Resize the array if needed
    if( _count <= _lowerBound ) then
      resize( _size - _initialSize )
    end if 
    
    return( this )
  end function
  
  /'
    Inserts an element into the array at the specified index.
  '/
  function _
    Array( of( TType ) ).insert( _
      byref anElement as TType, _
      byval index as integer ) _
    byref as Array( of( TType ) )
    
    if( _count < 1 ) then
      '' If the array is empty, simply add the element.
      return( add( anElement ) )
    else
      '' List is not empty
      if( index >= _count - 1 ) then
        /'
          If index is out of range or at the end of the array, add
          the element as-is.
        '/
        return( add( anElement ) )
      else
        '' If not, add it at the requested place
        _count +=> 1
        
        if( _count > ( _size - _initialSize shr 1 ) ) then
          '' Resize the internal array if needed
          resize( _size + _initialSize )
        end if
        
        '' Move the items to make room for the inserted one
        if( index < _count - 1 ) then
          for _
            i as integer => _count - 1 _
            to index step -1
            
            _array( i ) => _array( i - 1 )
          next
        end if
        
        '' And add the item at the requested position
        _array( index ) => anElement
      end if
    end if
    
    return( this )
  end function
  
  /'
    Returns an array with all the elements that satisfy the specified
    predicate.
  '/
  function _
    Array( of( TType ) ).findAll( _
      byref aPredicate as Predicate( of( TType ) ) ) _
    as Array( of( TType ) )
    
    var _
      result => Array( of( TType ) )
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( aPredicate.eval( @_array( i ) ) ) then
        result.add( _array( i ) )
      end if
    next
    
    return( result )
  end function
  
  /'
    Invokes the specified action on each of the elements of the array
  '/
  function _
    Array( of( TType ) ).forEach( _
      byref anAction as Action( of( TType ) ) ) _
    byref as Array( of( TType ) )
    
    dim as integer _
      index => 0
    
    do while( index < _count )
      anAction.indexOf => index
      anAction.invoke( @_array( index ) )
      index +=> 1
    loop
    
    return( this )
  end function
  
  /'
    Invokes the specified action on each of the elements of the array if
    they satisfy the specified predicate.
  '/
  function _
    Array( of( TType ) ).forEach( _
      byref aPredicate as Predicate( of( TType ) ), _
      byref anAction as Action( of( TType ) ) ) _
    byref as Array( of( TType ) )
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( aPredicate.eval( @_array( i ) ) ) then
        anAction.invoke( @_array( i ) )
      end if
    next
    
    return( this )
  end function
  
  operator _
    =( _
      byref lhs as Array( of( TType ) ), _
      byref rhs as Array( of( TType ) ) ) _
    as integer
    
    return( @lhs = @rhs )
  end operator
#endmacro

#endif
