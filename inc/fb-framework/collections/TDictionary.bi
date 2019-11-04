#ifndef __FB_COLLECTIONS_DICTIONARY__
#define __FB_COLLECTIONS_DICTIONARY__

#macro template_dictionary( TCollection, TKey, TType... )
  templateFor( Dictionary )
  
  template_predicate( __tcar__( TType ) )
  template_action( __tcar__( TType ) )
  template_keyValuePair( _
    of( TKey ), __tcar__( TType ) )
  template_action( of( KeyValuePair( _
    of( TKey ), __tcar__( TType ) ) ) ) 
  template_predicate( of( KeyValuePair( _
    of( TKey ), __tcar__( TType ) ) ) )
  
  /'
    Note the use of this macro instead of 'template'. Doing so will
    avoid creating a recursive macro, which isn't allowed.
  '/ 
  template_type_non_keyed( LinkedList, of( KeyValuePair( _
    of( TKey ), __tcar__( TType ) ) ) )
  
  template_collection( ofKey( Dictionary, _
    of( TKey ) ), __tcar__( TType ) )
  
  /'
    Represents a strongly-typed dictionary of key-value pairs
  '/
  type _
    Dictionary( of( TKey ), of( TType ) ) _
    extends Collection( _
      ofKey( Dictionary, of( TKey ) ), _
      __tcar__( TType ) )
    
    public:
      declare constructor()
      declare constructor( _
        byval as integer )
      declare virtual destructor() override
      
      declare property _
        size() as integer override
      declare property _
        count() as integer override
      
      declare function _
        containsKey( _
          byref as TKey ) _
        as boolean
      declare function _
        add( _
          byref as TKey, _
          byval as TType ptr ) _
        byref as Dictionary( _
          of( TKey ), of( TType ) )
      declare function _
        add( _
          byref as TKey, _
          byref as const TType ) _
        byref as Dictionary( _
          of( TKey ), of( TType ) )
      declare function _
        remove( _
          byref as TKey ) _
        byref as Dictionary( _
          of( TKey ), of( TType ) )
      declare function _
        removeItem( _
          byref as TKey ) _
        as TType ptr
      declare function _
        clear() _
        byref as Dictionary( _
          of( TKey ), of( TType ) ) override
      declare function _
        find( _
          byref as TKey ) _
        as TType ptr
      
      declare function _
        findEntry( _
          byref as TKey ) _
        as KeyValuePair( _
          of( TKey ), of( TType ) ) ptr
      declare function _
        findBucket( _
          byref as TKey ) _
        as LinkedList( of( KeyValuePair( _
          of( TKey ), of( TType ) ) ) ) ptr
        
      declare function _
        forEach( _
          byref as Action( of( TType ) ) ) _
        byref as Dictionary( _
          of( TKey ), of( TType ) ) override
      declare function _
        forEach( _
          byref as Predicate( of( TType ) ), _
          byref as Action( of( TType ) ) ) _
        byref as Dictionary( _
          of( TKey ), of( TType ) ) override
      
    private:
      declare constructor( _
        byref as Dictionary( _
          of( TKey ), of( TType ) ) )
      declare operator _
        let( _
          byref as Dictionary( _
            of( TKey ), of( TType ) ) )
          
      declare sub _
        dispose( _
          byval as integer, _
          byval as LinkedList( of( KeyValuePair( _
            of( TKey ), of( TType ) ) ) ) ptr ptr ) 
      declare sub _
        setResizeThresholds( _
          byval as integer, _
          byval as single, _
          byval as single )
      declare sub _
        addEntry( _
          byval as KeyValuePair( _
            of( TKey ), of( TType ) ) ptr, _
          byval as LinkedList( of( KeyValuePair( _
            of( TKey ), of( TType ) ) ) ) ptr ptr, _
          byval as integer )
      declare function _
        removeEntry( _
          byref aKey as TKey ) _
        byref as Dictionary( _
          of( TKey ), of( TType ) )
      declare sub _
        rehash( _
          byval as integer )
        
      as LinkedList( of( KeyValuePair( _
        of( TKey ), of( TType ) ) ) ) ptr ptr _
          _hashTable
      as integer _
        _count, _
        _size, _
        _initialSize, _
        _maxThreshold, _
        _minThreshold
  end type
  
  constructor _
    Dictionary( of( TKey ), of( TType ) )()
    
    this.constructor( 256 )
  end constructor
  
  constructor _
    Dictionary( of( TKey ), of( TType ) )( _
      byval aSize as integer )
    
    _initialSize => iif( aSize < 8, 8, aSize )
    _size => _initialSize
    
    _hashTable => callocate( _
      _size, _
      sizeOf( LinkedList( of( KeyValuePair( _
        of( TKey ), of( TType ) ) ) ) ptr ) )
      
    setResizeThresholds( _
      _initialSize, 0.55, 0.85 )
  end constructor
  
  constructor _
    Dictionary( of( TKey ), of( TType ) )( _
      byref rhs as Dictionary( _
        of( TKey ), of( TType ) ) )
  end constructor
  
  operator _
    Dictionary( of( TKey ), of( TType ) ).let( _
      byref rhs as Dictionary( _
        of( TKey ), of( TType ) ) )
  end operator
  
  destructor _
    Dictionary( of( TKey ), of( TType ) )()
    
    dispose( _size, _hashTable )
    deallocate( _hashTable )
  end destructor
  
  property _
    Dictionary( of( TKey ), of( TType ) ).count() _
    as integer
    
    return( _count )
  end property
  
  property _
    Dictionary( of( TKey ), of( TType ) ).size() _
    as integer
    
    return( _size )
  end property
  
  '' Disposes all the elements of the internal hash table
  sub _
    Dictionary( of( TKey ), of( TType ) ).dispose( _
      byval aSize as integer, _
      byval aHashTable as LinkedList( of( KeyValuePair( _
        of( TKey ), of( TType ) ) ) ) ptr ptr )
      
    for _
      i as integer => 0 _
      to aSize - 1
      
      delete( aHashTable[ i ] )
    next
  end sub
  
  /'
    Sets the resize thresholds on rehashings, expressed in 
    normalized percentages of the previous size (the 'lower'
    parameter) and the current size (the 'upper' parameter). 
    Since the hash table always grows and shrinks by a fixed 
    factor of 2, the previous size is computed by dividing the
    current size by 2.
    
    The factors used in the code are 0.55 for the lower threshold
    and 0.85 for the higher threshold. This maintains the load of
    the table at around 0.50, that is, near-optimal. Doing this
    helps to keep rehashings to a minimum, and at the same time
    maintains a fast access time and a reasonable memory
    footprint.
    
    As it is currently tailored, it slightly favors additions over
    removals, but they should take about the same time, nonetheless.
  '/
  sub _
    Dictionary( of( TKey ), of( TType ) ).setResizeThresholds( _
      byval newSize as integer, _
      byval lower as single, _
      byval upper as single )
    
    '' Don't let the new size fall below the initial size
    newSize => iif( _
      newSize < _initialSize, _
	    _initialSize, _
	    newSize )
    
    '' Compute previous size
    dim as integer _
      previousSize => newSize shr 1
    
	  '' If the previous size is below the initial size, set it to 0
    previousSize => iif( _
	    previousSize < _initialSize, _
	    0, _
	    previousSize )
    
    '' Calculate the lower and upper thresholds in number of entries
    _minThreshold => int( previousSize * lower )
    _maxThreshold => int( newSize * upper )
  end sub
  
  /'
    Rehashes the internal hash table to the specified size. Used
    when the size of the table changes to keep all key-value pairs
    up to date.
  '/
  sub _
    Dictionary( of( TKey ), of( TType ) ).rehash( _
      byval newSize as integer )
    
    setResizeThresholds( newSize, 0.55, 0.85 )
    
    dim as LinkedList( of( KeyValuePair( _
      of( TKey ), of( TType ) ) ) ) ptr ptr _
      newTable => callocate( _
        newSize, _
        sizeOf( LinkedList( of( KeyValuePair( _
          of( TKey ), of( TType ) ) ) ) ptr ) )
        
    _count => 0
    
    for _
      i as integer => 0 _
      to _size - 1
      
      var _
        aBucket => _hashTable[ i ]
      
      if( aBucket <> 0 ) then
        var _
          aNode => aBucket->first
        
        do while( aNode <> 0 )
          addEntry( _
            aNode->item, _
            newTable, _
            newSize )
          
          aNode->item => 0
          aNode => aNode->forward
        loop
      end if
    next
    
    dispose( _size, _hashTable )
    deallocate( _hashTable )
    
    _size => newSize
    _hashTable => newTable
  end sub
  
  function _
    Dictionary( of( TKey ), of( TType ) ).clear() _
    byref as Dictionary( _
      of( TKey ), of( TType ) )
    
    dispose( _size, _hashTable )
    
    _size => _initialSize
    _count => 0
    
    setResizeThresholds( _
      _initialSize, 0.55, 0.85 )
    
    return( this )
  end function
  
  '' Returns whether or not the dictionary contains the specified key
  function _
    Dictionary( of( TKey ), of( TType ) ).containsKey( _
      byref aKey as TKey ) _
    as boolean
    
    return( cbool( _
      findEntry( aKey ) <> 0 ) )
  end function
  
  '' Finds a bucket in the internal hash table
  function _
    Dictionary( of( TKey ), of( TType ) ).findBucket( _
      byref aKey as TKey ) _
    as LinkedList( of( KeyValuePair( _
      of( TKey ), of( TType ) ) ) ) ptr
    
    return( _hashTable[ Key( _
      of( TKey ) )( aKey ).getHashCode() mod _size ] )
  end function
  
  '' Find a key-value pair in the internal hash table
  function _
    Dictionary( of( TKey ), of( TType ) ).findEntry( _
      byref aKey as TKey ) _
    as KeyValuePair( _
      of( TKey ), of( TType ) ) ptr
    
    dim as KeyValuePair( _
      of( TKey ), of( TType ) ) ptr _
        entry => 0
      
    var _
      aBucket => findBucket( aKey )
    
    if( aBucket <> 0 ) then
      var _
        aNode => aBucket->last
      
      do while( aNode <> 0 )
        if( aNode->item->_key = aKey ) then
          entry => aNode->item
          exit do
        end if
        
        aNode => aNode->backward
      loop
    end if
    
    return( entry )
  end function
  
  '' Finds a value within the dictionary, using the specified key
  function _
    Dictionary( of( TKey ), of( TType ) ).find( _
      byref aKey as TKey ) _
    as TType ptr
    
    var _
      anEntry => findEntry( aKey )
    
    return( iif( anEntry <> 0, anEntry->_value, 0 ) )
  end function
  
  '' Adds a key-value pair to the specified hash table
  sub _
    Dictionary( of( TKey ), of( TType ) ).addEntry( _
      byval anEntry as KeyValuePair( _
        of( TKey ), of( TType ) ) ptr, _
      byval aHashTable as LinkedList( _
        of( KeyValuePair( _
          of( TKey ), of( TType ) ) ) ) ptr ptr, _
      byval aSize as integer )
    
    dim as ulong _
      bucketNumber => _
        anEntry->_key.getHashCode() mod aSize
      
    if( aHashTable[ bucketNumber ] = 0 ) then
      aHashTable[ bucketNumber ] => _
        new LinkedList( of( KeyValuePair( _
          of( TKey ), of( TType ) ) ) )
        
      aHashTable[ bucketNumber ]->addLast( _
        anEntry )
    else
      aHashTable[ bucketNumber ]->addLast( _
        anEntry )
    end if
    
    _count +=> 1
  end sub
  
  /'
    Adds a value to the dictionary, using the specified key
  '/
  function _
    Dictionary( of( TKey ), of( TType ) ).add( _
      byref aKey as TKey, _
      byref aValue as const TType ) _
    byref as Dictionary( _
      of( TKey ), of( TType ) )
    
    addEntry( new KeyValuePair( _
      of( TKey ), of( TType ) )( _
        aKey, _
        aValue ), _
      _hashTable, _
      _size )
    
    if( _count > _maxThreshold ) then
      rehash( _size shl 1  )
    end if
    
    return( this )
  end function
  
  function _
    Dictionary( of( TKey ), of( TType ) ).add( _
      byref aKey as TKey, _
      byval aValue as TType ptr ) _
    byref as Dictionary( _
      of( TKey ), of( TType ) )
    
    addEntry( new KeyValuePair( _
      of( TKey ), of( TType ) )( _
        aKey, _
        aValue ), _
      _hashTable, _
      _size )
    
    if( _count > _maxThreshold ) then
      rehash( _size shl 1  )
    end if
    
    return( this )
  end function
  
  /'
    Removes a key-value pair from the internal hash table
  '/
  function _
    Dictionary( of( TKey ), of( TType ) ).removeEntry( _
      byref aKey as TKey ) _
    byref as Dictionary( _
      of( TKey ), of( TType ) )
    
    var _
      aBucket => findBucket( aKey )
    
    if( aBucket <> 0 ) then
      var _
        aNode => aBucket->last
      
      do while( aNode <> 0 )
        if( aNode->item->_key = aKey ) then
          aBucket->remove( aNode )
          
          _count -=> 1
          
          if( _count < _minThreshold ) then
            rehash( _size shr 1 )
          end if
          
          exit do
        end if
        
        aNode => aNode->backward
      loop
    end if
    
    return( this )
  end function
  
  /'
    Removes a key-value pair from the internal hash table.
    
    Returns the item that was associated with the pair, or
    a null pointer if the item was not found.
  '/
  function _
    Dictionary( of( TKey ), of( TType ) ).removeItem( _
      byref aKey as TKey ) _
    as TType ptr
    
    var _
      aBucket => findBucket( aKey )
    
    dim as TType ptr _
      item
    
    if( aBucket <> 0 ) then
      var _
        aNode => aBucket->last
      
      do while( aNode <> 0 )
        if( aNode->item->_key = aKey ) then
          var _
            entry => aBucket->removeItem( aNode )
          
          item => entry->_value
          entry->_value => 0
          
          delete( entry )
          
          _count -=> 1
          
          if( _count < _minThreshold ) then
            rehash( _size shr 1 )
          end if
          
          exit do
        end if
        
        aNode => aNode->backward
      loop
    end if
    
    return( item )
  end function
  
  /'
    Removes an entry from the dictionary using the specified key
  '/
  function _
    Dictionary( of( TKey ), of( TType ) ).remove( _
      byref aKey as TKey ) _
    byref as Dictionary( _
      of( TKey ), of( TType ) )
    
    return( removeEntry( aKey ) )
  end function
  
  function _
    Dictionary( of( TKey ), of( TType ) ).forEach( _
      byref anAction as Action( of( TType ) ) ) _
    byref as Dictionary( _
      of( TKey ), of( TType ) )
    
    for _
      i as integer => 0 _
      to _size - 1
      
      if( _hashTable[ i ] <> 0 ) then
        var _
          n => _hashTable[ i ]->first
        
        for _
          j as integer => 0 _
          to _hashTable[ i ]->count - 1
          
          anAction.invoke( n->item->_value )
        next
      end if
    next
    
    return( this )
  end function
  
  function _
    Dictionary( of( TKey ), of( TType ) ).forEach( _
      byref aPredicate as Predicate( of( TType ) ), _
      byref anAction as Action( of( TType ) ) ) _
    byref as Dictionary( _
      of( TKey ), of( TType ) )
    
    for _
      i as integer => 0 _
      to _size - 1
      
      if( _hashTable[ i ] <> 0 ) then
        var _
          n => _hashTable[ i ]->first
        
        for _
          j as integer => 0 _
          to _hashTable[ i ]->count - 1
          
          if( aPredicate.eval( n->item->_value ) ) then
            anAction.invoke( n->item->_value )
          end if
        next
      end if
    next
    
    return( this )
  end function
  
  operator _
    =( _
      byref lhs as Dictionary( of( TKey ), of( TType ) ), _
      byref rhs as Dictionary( of( TKey ), of( TType ) ) ) _
    as integer
    
    return( @lhs = @rhs )
  end operator
#endmacro

#endif
