#ifndef __FBFW_COLLECTIONS_PRIORITYQUEUE__
#define __FBFW_COLLECTIONS_PRIORITYQUEUE__

#macro template_priorityqueue( TCollection, TType... )
  templateFor( QueueElement )
  templateFor( PriorityQueue )
  
  template_predicate( __tcar__( TType ) )
  template_action( __tcar__( TType ) )
  template_collection( TCollection, __tcar__( TType ) )
  declare_auto_ptr( of( PriorityQueue( __tcar__( TType ) ) ) )
  
  /'
    Represents an element of the priority queue.
    
    There's no need to instantiate or extend this class, as it is
    used by the internal heap only.
  '/
  #ifndef __T__##QueueElement##__##TType##__ 
    type _
      QueueElement( of( TType ) )
      
      public:
        declare constructor( _
          byval as integer, _
          byval as TType ptr, _
          byval as boolean )
        declare destructor()
        
        declare property _
          priority() as integer
        declare property _
          value() as TType ptr
        
        declare function _
          detach() as TType ptr
        
      private:
        declare constructor()
        
        declare constructor( _
          byref as QueueElement( of( TType ) ) )
        declare operator let( _
          byref as QueueElement( of( TType ) ) )
        
        '' The priority of this element
        as integer _
          _priority
        
        '' The value associated with this element
        as TType ptr _
          _value
        
        as boolean _
          _needsDisposing
    end type
    
    constructor _
      QueueElement( of( TType ) )()
    end constructor
    
    constructor _
      QueueElement( of( TType ) )( _
        byval aPriority as integer, _
        byval aValue as TType ptr, _
        byval needsDisposing as boolean )
       
      _priority => aPriority
      _value => aValue
      _needsDisposing => needsDisposing
    end constructor
    
    constructor _
      QueueElement( of( TType ) )( _
        byref rhs as QueueElement( of( TType ) ) )
    end constructor
    
    operator _
      QueueElement( of( TType ) ).let( _
        byref rhs as QueueElement( of( TType ) ) )
    end operator
    
    destructor _
      QueueElement( of( TType ) )()
      
      if( _
        _needsDisposing andAlso _
        _value <> 0 ) then
        
        delete( _value )
      end if
    end destructor
    
    property _
      QueueElement( of( TType ) ).priority() _
      as integer
      
      return( _priority )
    end property
    
    property _
      QueueElement( of( TType ) ).value() _
      as TType ptr
      
      return( _value )
    end property
    
    function _
      QueueElement( of( TType ) ).detach() _
      as TType ptr
      
      var _
        element => _value
      
      _value => 0
      
      return( element )
    end function
    
    operator _
      <( _
        byref lhs as QueueElement( of( TType ) ), _
        byref rhs as QueueElement( of( TType ) ) ) _
      as integer
      
      return( lhs.priority < rhs.priority )
    end operator
    
    operator _
      >( _
        byref lhs as QueueElement( of( TType ) ), _
        byref rhs as QueueElement( of( TType ) ) ) _
      as integer
      
      return( lhs.priority > rhs.priority )
    end operator
  #endif
  
  /'
    Represents a strongly-typed priority queue (aka binary heap) 
  '/
  type _
    PriorityQueue( of( TType ) ) _
    extends Collection( _
      of( TCollection ), of( TType ) )
    
    public:
      declare constructor()
      declare constructor( _
        byval as integer )
      declare constructor( _
        byval as Collections.PriorityOrder )
      declare constructor( _
        byval as integer, _
        byval as Collections.PriorityOrder )
      declare virtual destructor() override
      
      declare property _
        size() as integer override
      declare property _
        count() as integer override
      declare property _
        top() as TType ptr
      
      declare function _
        clear() _
        byref as PriorityQueue( of( TType ) ) override
      declare function _
        enqueue( _
          byval as integer, _
          byval as TType ptr ) _
        byref as PriorityQueue( of( TType ) )
      declare function _
        enqueue( _
          byval as integer, _
          byref as const TType ) _
        byref as PriorityQueue( of( TType ) )
      declare function _
        dequeue() as TType ptr
      declare function _
        forEach( _
          byref as Action( of( TType ) ) ) _
        byref as PriorityQueue( of( TType ) ) override
      declare function _
        forEach( _
          byref as Predicate( of( TType ) ), _
          byref as Action( of( TType ) ) ) _
        byref as PriorityQueue( of( TType ) ) override
      
    private:
      declare sub _
        dispose()
      declare function _
        enqueueElement( _
          byval as QueueElement( of( TType ) ) ptr ) _
        byref as PriorityQueue( of( TType ) )
      declare sub _
        resize( _
          byval as uinteger )
        
      as QueueElement( of( TType ) ) ptr _
        _elements( any )
      as uinteger _
        _size, _
        _initialSize, _
        _lowerBound
      as integer _
        _count
      as Collections.PriorityOrder _
        _priorityOrder
  end type
  
  implement_auto_ptr( of( PriorityQueue( __tcar__( TType ) ) ) )
  
  /'
    Note that the default priority order is set to 'Descending'
    since this property is usually understood as 'the higher
    the value, the higher the priority'
  '/
  constructor _
    PriorityQueue( of( TType ) )()
    
    this.constructor( _
      32, Collections.PriorityOrder.Descending )
  end constructor
  
  constructor _
    PriorityQueue( of( TType ) )( _
      byval aSize as integer )
    
    this.constructor( _
      aSize, Collections.PriorityOrder.Descending )
  end constructor
  
  constructor _
    PriorityQueue( of( TType ) )( _
      byval aPriority as Collections.PriorityOrder )
    
    this.constructor( 32, aPriority )
  end constructor
  
  constructor _
    PriorityQueue( of( TType ) )( _
      byval aSize as integer, _
      byval aPriority as Collections.PriorityOrder )
    
    /'
      Primary constructor.
      
      Note that we're using a 1-based array instead of a more common
      0-based one. This makes a lot of things easier down the road,
      especially adding an element: since we're declaring the	element
      count as unsigned, leaving a bit of space at the root of the
      heap we don't have to check for underflow conditions during the
      sifting.
    '/
    _size => iif( aSize < 32, _
      32, aSize )
    _priorityOrder => aPriority
    
    redim _
      _elements( 1 to _size )
    
    _count => 0
    _initialSize => _size
    _lowerBound => 1
  end constructor
  
  destructor _
    PriorityQueue( of( TType ) )()
    
    dispose()
  end destructor
  
  sub _
    PriorityQueue( of( TType ) ).dispose()
    
    for _
      i as integer => 1 _
      to _size
      
      if( _elements( i ) <> 0 ) then
        delete( _elements( i ) )
        _elements( i ) => 0
      end if
    next
  end sub
  
  property _
    PriorityQueue( of( TType ) ).size() _
    as integer
    
    return( _size )
  end property
  
  property _
    PriorityQueue( of( TType ) ).count() _
    as integer
    
    return( _count )
  end property
  
  property _
    PriorityQueue( of( TType ) ).top() _
    as TType ptr
    
    /'
      Peeks the top value field of the root of the heap, without removing it.
      It will return a null pointer if the heap is empty.
    '/
    if( _count > 0 ) then
      return( _elements( 1 )->value )
    else
      return( 0 )
    end if
  end property
  
  function _
    PriorityQueue( of( TType ) ).clear() _
    byref as PriorityQueue( of( TType ) )
    
    dispose()
    
    _size => _initialSize
    
    redim _
      _elements( 1 to _size )
    
    _count => 0
    _lowerBound => 1
    
    return( this )
  end function
  
  /'
    Resizes the internal array used as the heap.
    
    The algorithm works like the ones from the Array and List 
    collections. See the implementation on the Array collections for
    details.
  '/
  sub _
    PriorityQueue( of( TType ) ).resize( _
      byval newSize as uinteger )
    
    newSize => iif( newSize < _initialSize, _
      _initialSize, _
      newSize )
    
    _size => newSize
    
    _lowerBound => _
      _size - _initialSize - ( _initialSize shr 1 )
    _lowerBound => iif( _lowerBound < _initialSize, _
      1, _lowerBound )
    
    redim preserve _
      _elements( 1 to _size )
  end sub
  
  /'
    Enqueues (adds) an element to the tail of the heap.
    
    Whenever an element is added to a binary heap, the heap has to be
    rebalanced (a process known as 'sifting') to leave it in a valid
    state. The procedure starts at the tail and proceeds towards the
    root.
  '/
  function _
    PriorityQueue( of( TType ) ).enqueueElement( _
      byval anElement as QueueElement( of( TType ) ) ptr ) _
    byref as PriorityQueue( of( TType ) )
    
    '' Increment the number of elements in the heap
    _count +=> 1
    
    '' Resize the internal heap if needed
    if( _count > _size - _initialSize shr 1 ) then
      resize( _size + _initialSize )
    end if
    
    '' Set the current element position to the tail of the heap
    dim as uinteger _
      elementPosition => _count
    
    _elements( elementPosition ) => anElement
    
    '' The parent position of this element
    dim as uinteger _
      parentPosition
    
    '' Flag to end the sifting loop if appropriate
    dim as boolean _
      done
    
    /'
      Sift the heap until the enqueued element reaches its correct
      position or it bubbles all the way to the root of the heap.
      
      The parent position of the considered element can be computed
      as the considered element position \ 2 in a 1-based array.
    '/
    do
      '' Assume that the element is at its correct place
      done => true
      
      '' Compute position of parent
      parentPosition => elementPosition shr 1
      
      /'
        If the element has a parent, see if we need to swap the considered 
        element with its parent, given the priority order.
      '/
      if( parentPosition > 0 ) then
        dim as boolean _
          needSwap => iif( _
            _priorityOrder = Collections.PriorityOrder.Ascending, _
              iif( _
                *_elements( elementPosition ) < _
                *_elements( parentPosition ), _
                true, false ), _
              iif( _
                *_elements( elementPosition ) > _
                *_elements( parentPosition ), _
                true, false ) )
        
        /'
          Swap the considered element with its parent and update the
          element's position to that of its parent to continue the
          sifting.
        '/
        if( needSwap ) then
          swap _
            _elements( elementPosition ), _
            _elements( parentPosition )
          
          elementPosition => parentPosition
          
          ''Sifting has not finished yet
          done => false
        end if
      end if
    loop until( done )
    
    return( this )
  end function
  
  function _
    PriorityQueue( of( TType ) ).enqueue( _
      byval aPriority as integer, _
      byval aValue as TType ptr ) _
    byref as PriorityQueue( of( TType ) )
    
    return( enqueueElement( _
      new QueueElement( of( TType ) )( _
        aPriority, _
        aValue, _
        true ) ) )
  end function
  
  function _
    PriorityQueue( of( TType ) ).enqueue( _
      byval aPriority as integer, _
      byref aValue as const TType ) _
    byref as PriorityQueue( of( TType ) )
    
    return( enqueueElement( _
      new QueueElement( of( TType ) )( _
        aPriority, _
        cptr( TType ptr, @aValue ), _
        false ) ) )
  end function
  
  /'
    Dequeues (removes) an element from the heap
    
    The heap has to be sifted also when removing elements, this time
    starting from the head (the root) element and proceeding towards
    the tail.
  '/
  function _
    PriorityQueue( of( TType ) ).dequeue() _
    as TType ptr
    
    dim as TType ptr _
      elementValue => 0
    
    if( _count > 0 ) then
      '' Fetch the value at the root of the heap
      elementValue => _elements( 1 )->detach()
      
      '' Delete the QueueElement associated with it
      delete( _elements( 1 ) )
      _elements( 1 ) => 0
      
      '' Then, bring the element on the tail of the heap to the root
      swap _
        _elements( 1 ), _
        _elements( _count )
      
      '' Decrement the element count to account for the removed element
      _count -=> 1
      
      '' Resize the internal heap if needed
      if( _count < _lowerBound ) then
        resize( _size - _initialSize )
      end if
      
      /'
        Here, the element at the root of the heap is successively checked
        against its two siblings to swap their positions if necessary.
        
        If there are still elements remaining in the heap, we need to reorder
        them to account for the removal of it's previous root element. The
        sifting direction depends on how the class was instantiated (in 
        'Ascending' or 'Descending' priority order).
      
        The current element position is set at the root of the heap to start
        the sifting.
      '/
      dim as uinteger _
        elementPosition => 1
      
      '' The new position the element could potentially take
      dim as uinteger _
        newPosition
      
      '' Flag to end the sifting loop if appropriate
      dim as boolean _
        done
      
      do while( _
        _count > 0 andAlso _
        not done )
        
        ''Assume the element is at the correct position already
        done => true
        
        '' Compute the positions of the two siblings of the element
        dim as uinteger _
          child1Position => elementPosition shl 1, _
          child2Position => child1Position + 1
        
        '' Check if the element has one or two siblings
        if( child1Position <= _count ) then
          if( child2Position <= _count ) then
            /'
              The element has two siblings, see which of the two we need to swap
              according to the desired priority order, and record its position.
            '/
            newPosition => iif( _
              _priorityOrder = Collections.PriorityOrder.Ascending, _
              iif( _
                *_elements( child1Position ) < _
                *_elements( child2Position ), _
                child1Position, _
                child2Position ), _
              iif( _
                *_elements( child1Position ) > _
                *_elements( child2Position ), _
                child1Position, _
                child2Position ) )
          else
            '' Only one sibling left, always record its position
            newPosition => child1Position
          end if
          
          '' Check to see if we need to swap the element with its sibling
          dim as boolean _
            needSwap => iif( _
              _priorityOrder = Collections.PriorityOrder.Ascending, _
              iif( _
                *_elements( elementPosition ) > _
                *_elements( newPosition ), _
                true, _
                false ), _
              iif( _
                *_elements( elementPosition ) < _
                *_elements( newPosition ), _
                true, _
                false ) )
          
          /'
            If needed, swap the considered element's position with the new position computed
            above, and set the current element position to the new one to continue the sifting
            from there.
          '/
          if( needSwap ) then
            swap _
              _elements( elementPosition ), _
              _elements( newPosition )
            
            elementPosition => newPosition
            
            '' Sifting is not done yet
            done => false
          end if
        end if
      loop
    end if
    
    return( elementValue )
  end function
  
  function _
    PriorityQueue( of( TType ) ).forEach( _
      byref anAction as Action( of( TType ) ) ) _
    byref as PriorityQueue( of( TType ) )
    
    for _
      i as integer => 1 _
      to _count
      
      anAction.invoke( _elements( i )->value )
    next
    
    return( this )
  end function
  
  function _
    PriorityQueue( of( TType ) ).forEach( _
      byref aPredicate as Predicate( of( TType ) ), _
      byref anAction as Action( of( TType ) ) ) _
    byref as PriorityQueue( of( TType ) )
    
    for _
      i as integer => 1 _
      to count
      
      if( aPredicate.eval( _elements( i )->value ) ) then
        anAction.invoke( _elements( i )->value )
      end if
    next
    
    return( this )
  end function
  
  operator _
    =( _
      byref lhs as PriorityQueue( of( TType ) ), _
      byref rhs as PriorityQueue( of( TType ) ) ) _
    as integer
    
    return( @lhs = @rhs )
  end operator
  
  operator _
    <>( _
      byref lhs as PriorityQueue( of( TType ) ), _
      byref rhs as PriorityQueue( of( TType ) ) ) _
    as integer
    
    return( @lhs <> @rhs )
  end operator
#endmacro

#endif
