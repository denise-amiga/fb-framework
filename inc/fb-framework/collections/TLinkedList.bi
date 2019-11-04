#ifndef __FB_COLLECTIONS_LINKED_LIST__
#define __FB_COLLECTIONS_LINKED_LIST__

#macro template_linkedlist( TCollection, TType... )
  templateFor( LinkedListNode )
  templateFor( LinkedList )
  
  template_predicate( __tcar__( TType ) )
  template_action( __tcar__( TType ) )
  template_collection( TCollection, __tcar__( TType ) )
  declare_auto_ptr( of( LinkedList( __tcar__( TType ) ) ) )
  
  /'
    Represents a node for the Linked List class
  '/
  #ifndef __T__##LinkedListNode##__##TType##__
    type _
      LinkedListNode( of( TType ) )
      
      public:
        declare constructor( _
          byval as TType ptr, _
          byval as boolean )
        
        declare destructor()
        
        '' The item associated with this node
        as TType ptr _
          item
        
        as LinkedListNode( of( TType ) ) ptr _
          forward, _
          backward
        
      private:
        declare constructor()
        declare constructor( _
          byref as LinkedListNode( of( TType ) ) )
        declare operator _
          let( _
            byref as LinkedListNode( of( TType ) ) )
            
        as boolean _
          _needsDisposing
    end type
    
    constructor _
      LinkedListNode( of( TType ) )()
    end constructor
    
    constructor _
      LinkedListNode( of( TType ) )( _
        byval anItem as TType ptr, _
        byval needsDisposing as boolean )
      
      item => anItem
      _needsDisposing => needsDisposing
    end constructor
    
    constructor _
      LinkedListNode( of( TType ) )( _
        byref rhs as LinkedListNode( of( TType ) ) )
    end constructor
    
    destructor _
      LinkedListNode( of( TType ) )()
      
      if( _
        _needsDisposing andAlso _
        item <> 0 ) then
        
        delete( item )
      end if
    end destructor
    
    operator _
      LinkedListNode( of( TType ) ).let( _
        byref rhs as LinkedListNode( of( TType ) ) )
    end operator
    
    operator _
      =( _
        byref lhs as LinkedListNode( of( TType ) ), _
        byref rhs as LinkedListNode( of( TType ) ) ) _
      as integer
      
      return( lhs.item = rhs.item )
    end operator
  #endif
  
  /'
    Represents a strongly-typed doubly-linked list.
    
    It allows for insertion/removal of elements either from the head of 
    the list or from the tail, and also allows first-to-last or last-to-first
    traversal. Thus, it can be used both as a queue/heap or as a stack, by 
    using the appropriate methods to add/remove elements from it.
  '/
  type _
    LinkedList( of( TType ) ) _
    extends Collection( _
      of( TCollection ), of( TType ) )
    
    public:
      declare constructor()
      declare virtual destructor() override
      
      declare property _
        size() as integer override
      declare property _
        count() as integer override
      declare property _
        first() _
        as LinkedListNode( of( TType ) ) ptr
      declare property _
        last() _
        as LinkedListNode( of( TType ) ) ptr
      declare property _
        at( _
          byval as integer ) _
        as TType ptr
      
      declare function _
        contains( _
          byref as const TType ) _
        as boolean
      declare function _
        contains( _
          byval as TType ptr ) _
        as boolean
      declare function _
        findNode( _
          byref as const TType ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        findNode( _
          byval as TType ptr ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        addBefore( _
          byval as LinkedListNode( of( TType ) ) ptr, _
          byval as TType ptr ) _
        as LinkedListNode( of( TType ) ) ptr 
      declare function _
        addBefore( _
          byval as LinkedListNode( of( TType ) ) ptr, _
          byref as const TType ) _
        as LinkedListNode( of( TType ) ) ptr 
      declare function _
        addAfter( _
          byval as LinkedListNode( of( TType ) ) ptr, _
          byval as TType ptr ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        addAfter( _
          byval as LinkedListNode( of( TType ) ) ptr, _
          byref as const TType ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        addFirst( _
          byval as TType ptr ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        addFirst( _
          byref as const TType ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        addLast( _
          byval as TType ptr ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        addLast( _
          byref as const TType ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        remove( _
          byval as LinkedListNode( of( TType ) ) ptr ) _
        byref as LinkedList( of( TType ) )
      declare function _
        removeItem( _
          byval as LinkedListNode( of( TType ) ) ptr ) _
        as TType ptr
      declare function _
        removeFirst() _
        byref as LinkedList( of( TType ) )
      declare function _
        removeFirstItem() _
        as TType ptr
      declare function _
        removeLast() _
        byref as LinkedList( of( TType ) )
      declare function _
        removeLastItem() _
        as TType ptr
      declare function _
        clear() _
        byref as LinkedList( of( TType ) ) override
      
      declare function _
        forEach( _
          byref as Action( of( TType ) ) ) _
        byref as LinkedList( of( TType ) ) override
      declare function _
        forEach( _
          byref as Predicate( of( TType ) ), _
          byref as Action( of( TType ) ) ) _
        byref as LinkedList( of( TType ) ) override
      
    private:
      declare constructor( _
        byref as LinkedList( of( TType ) ) )
      declare operator _
        let( _
          byref as LinkedList( of( TType ) ) )
      declare sub _
        dispose()
      
      declare function _
        addElementBefore( _
          byval as LinkedListNode( of( TType ) ) ptr, _
          byval as TType ptr, _
          byval as boolean ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        addElementAfter( _
          byval as LinkedListNode( of( TType ) ) ptr, _
          byval as TType ptr, _
          byval as boolean ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        addElementFirst( _
          byval as TType ptr, _
          byval as boolean ) _
        as LinkedListNode( of( TType ) ) ptr
      declare function _
        addElementLast( _
          byval as TType ptr, _
          byval as boolean ) _
        as LinkedListNode( of( TType ) ) ptr
      
      as LinkedListNode( of( TType ) ) ptr _
        _last, _
        _first
      as integer _
        _count
  end type
  
  implement_auto_ptr( of( LinkedList( __tcar__( TType ) ) ) )
  
  constructor _
    LinkedList( of( TType ) )()
  end constructor
  
  constructor _
    LinkedList( of( TType ) )( _
      byref rhs as LinkedList( of( TType ) ) )
  end constructor
  
  operator _
    LinkedList( of( TType ) ).let( _
      byref rhs as LinkedList( of( TType ) ) )
  end operator
  
  destructor _
    LinkedList( of( TType ) )()
    
    '' Dispose of all linked list nodes
    dispose()
  end destructor
  
  sub _
    LinkedList( of( TType ) ).dispose()
    
    do while( _count > 0 )
      remove( _last )
    loop
  end sub
  
  property _
    LinkedList( of( TType ) ).size() _
    as integer
    
    return( _count )
  end property
  
  property _
    LinkedList( of( TType ) ).count() _
    as integer
    
    return( _count )
  end property
  
  /'
    Returns the first node in the list
  '/
  property _
    LinkedList( of( TType ) ).first() _
    as LinkedListNode( of( TType ) ) ptr
    
    return( _first )
  end property
  
  /'
    Returns the last node in the list
  '/
  property _
    LinkedList( of( TType ) ).last() _
    as LinkedListNode( of( TType ) ) ptr
    
    return( _last )
  end property
  
  /'
    Returns the value associated at the specified index
  '/
  property _
    LinkedList( of( TType ) ).at( _
      byval index as integer ) _
    as TType ptr
    
    var _
      n => _first
    
    dim as LinkedListNode( of( TType ) ) ptr _
      node
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( i = index ) then
        node => n
        exit for
      end if
    next
    
    return( node->item )  
  end property
  
  function _
    LinkedList( of( TType ) ).contains( _
      byref anItem as const TType ) _
    as boolean
    
    return( findNode( anItem ) <> 0 )
  end function
  
  function _
    LinkedList( of( TType ) ).contains( _
      byval anItem as TType ptr ) _
    as boolean
    
    return( findNode( anItem ) <> 0 )
  end function
  
  /'
    Returns the node in the Linked List that contains the specified
    reference, if it exists. Otherwise returns a null pointer.
  '/
  function _
    LinkedList( of( TType ) ).findNode( _
      byref anItem as const TType ) _
    as LinkedListNode( of( TType ) ) ptr
    
    dim as LinkedListNode( of( TType ) ) ptr _
      result
    
    var _
      node => _first
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( cptr( TType ptr, @anItem ) = node->item ) then
        result => node
        exit for
      end if
      
      node => node->forward
    next
    
    return( result )
  end function
  
  function _
    LinkedList( of( TType ) ).findNode( _
      byval anItem as TType ptr ) _
    as LinkedListNode( of( TType ) ) ptr
    
    dim as LinkedListNode( of( TType ) ) ptr _
      result
    
    var _
      node => _first
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( anItem = node->item ) then
        result => node
        exit for
      end if
      
      node => node->forward
    next
    
    return( result )
  end function
  
  /'
    Clears the list
  '/
  function _
    LinkedList( of( TType ) ).clear() _
    byref as LinkedList( of( TType ) )
    
    dispose()
    
    _count => 0
    _first => 0
    _last => _first
    
    return( this )
  end function
  
  /'
    Inserts an item before the specified node.
  '/
  function _
    LinkedList( of( TType ) ).addElementBefore( _
      byval aNode as LinkedListNode( of( TType ) ) ptr, _
      byval anItem as TType ptr, _
      byval needsDisposing as boolean ) _
    as LinkedListNode( of( TType ) ) ptr
  
    var _
      newNode => new LinkedListNode( of( TType ) )( _
        anItem, _
        needsDisposing )
      
    newNode->backward => aNode->backward
    newNode->forward => aNode
    
    if( aNode->backward = 0 ) then
      _first => newNode
    else
      aNode->backward->forward => newNode
    end if
    
    _count +=> 1
    aNode->backward => newNode
    
    return( newNode )
  end function
  
  function _
    LinkedList( of( TType ) ).addBefore( _
      byval aNode as LinkedListNode( of( TType ) ) ptr, _
      byval anItem as TType ptr ) _
    as LinkedListNode( of( TType ) ) ptr
    
    return( addElementBefore( _
      aNode, _
      anItem, _
      true ) )
  end function
  
  function _
    LinkedList( of( TType ) ).addBefore( _
      byval aNode as LinkedListNode( of( TType ) ) ptr, _
      byref anItem as const TType ) _
    as LinkedListNode( of( TType ) ) ptr
    
    return( addElementBefore( _
      aNode, _
      cptr( TType ptr, @anItem ), _
      false ) )
  end function
  
  /'
    Inserts an item after the specified node.
  '/
  function _
    LinkedList( of( TType ) ).addElementAfter( _
      byval aNode as LinkedListNode( of( TType ) ) ptr, _
      byval anItem as TType ptr, _
      byval needsDisposing as boolean ) _
    as LinkedListNode( of( TType ) ) ptr
    
    var _
      newNode => new LinkedListNode( of( TType ) )( _
        anItem, _
        needsDisposing )
      
    newNode->backward => aNode
    newNode->forward => aNode->forward
    
    if( aNode->forward = 0 ) then
      _last => newNode
    else
      aNode->forward->backward => newNode
    end if
    
    _count +=> 1
    aNode->forward => newNode
    
    return( newNode )
  end function
  
  function _
    LinkedList( of( TType ) ).addAfter( _
      byval aNode as LinkedListNode( of( TType ) ) ptr, _
      byval anItem as TType ptr ) _
    as LinkedListNode( of( TType ) ) ptr
    
    return( addElementAfter( _
      aNode, _
      anItem, _
      true ) )
  end function
  
  function _
    LinkedList( of( TType ) ).addAfter( _
      byval aNode as LinkedListNode( of( TType ) ) ptr, _
      byref anItem as const TType ) _
    as LinkedListNode( of( TType ) ) ptr
    
    return( addElementAfter( _
      aNode, _
      cptr( TType ptr, @anItem ), _
      false ) )
  end function
  
  /'
    Inserts an item at the beginning of the list.
  '/
  function _
    LinkedList( of( TType ) ).addElementFirst( _
      byval anItem as TType ptr, _
      byval needsDisposing as boolean ) _
    as LinkedListNode( of( TType ) ) ptr
    
    if( _first = 0 ) then
      var _
        newNode => new LinkedListNode( of( TType ) )( _
          anItem, _
          needsDisposing )
        
      _first => newNode
      _last => newNode
      
      newNode->backward => 0
      newNode->forward => 0
      
      _count +=> 1
      
      return( newNode )
    end if
    
    return( addElementBefore( _
      _first, _
      anItem, _
      needsDisposing ) )
  end function
  
  function _
    LinkedList( of( TType ) ).addFirst( _
      byval anItem as TType ptr ) _
    as LinkedListNode( of( TType ) ) ptr
    
    return( addElementFirst( _
      anItem, _
      true ) )
  end function
  
  function _
    LinkedList( of( TType ) ).addFirst( _
      byref anItem as const TType ) _
    as LinkedListNode( of( TType ) ) ptr
    
    return( addElementFirst( _
      cptr( TType ptr, @anItem ), _
      false ) )
  end function
  
  /'
    Inserts an item at the end of the list.
  '/
  function _
    LinkedList( of( TType ) ).addElementLast( _
      byval anItem as TType ptr, _
      byval needsDisposing as boolean ) _
    as LinkedListNode( of( TType ) ) ptr
    
    if( _last = 0 ) then
      return( addElementFirst( _
        anItem, _
        needsDisposing ) )
    end if
    
    return( addElementAfter( _
      _last, _
      anItem, _
      needsDisposing ) )
  end function
  
  function _
    LinkedList( of( TType ) ).addLast( _
      byval anItem as TType ptr ) _
    as LinkedListNode( of( TType ) ) ptr
    
    return( addElementLast( _
      anItem, _
      true ) )
  end function
  
  function _
    LinkedList( of( TType ) ).addLast( _
      byref anItem as const TType ) _
    as LinkedListNode( of( TType ) ) ptr
    
    '#print "Added by reference"
    return( addElementLast( _
      cptr( TType ptr, @anItem ), _
      false ) )
  end function
  
  /'
    Removes the specified node from the list
  '/
  function _
    LinkedList( of( TType ) ).remove( _
      byval node as LinkedListNode( of( TType ) ) ptr ) _
    byref as LinkedList( of( TType ) )
    
    if( _
      node <> 0 andAlso _
      _count > 0 ) then
      
      if( node->backward = 0 ) then
        _first => node->forward
      else
        node->backward->forward => node->forward
      end if
      
      if( node->forward = 0 ) then
        _last => node->backward
      else
        node->forward->backward => node->backward
      end if
      
      _count -=> 1
      
      delete( node )
    end if
    
    return( this )
  end function
  
  function _
    LinkedList( of( TType ) ).removeItem( _
      byval node as LinkedListNode( of( TType ) ) ptr ) _
    as TType ptr
    
    dim as TType ptr _
      result
    
    if( _
      node <> 0 andAlso _
      _count > 0 ) then
      
      if( node->backward = 0 ) then
        _first => node->forward
      else
        node->backward->forward => node->forward
      end if
      
      if( node->forward = 0 ) then
        _last => node->backward
      else
        node->forward->backward => node->backward
      end if
      
      _count -=> 1
      
      result => node->item
      node->item => 0
      
      delete( node )
    end if
    
    return( result )
  end function
  
  /'
    Removes the first node on the list
  '/
  function _
    LinkedList( of( TType ) ).removeFirst() _
    byref as LinkedList( of( TType ) )
    
    return( remove( _first ) )
  end function
  
  function _
    LinkedList( of( TType ) ).removeFirstItem() _
    as TType ptr
    
    return( removeItem( _first ) )
  end function
  
  /'
    Removes the last node in the list
  '/
  function _
    LinkedList( of( TType ) ).removeLast() _
    byref as LinkedList( of( TType ) )
    
    return( remove( _last ) )
  end function
  
  function _
    LinkedList( of( TType ) ).removeLastItem() _
    as TType ptr
    
    return( removeItem( _last ) )
  end function
  
  function _
    LinkedList( of( TType ) ).forEach( _
      byref anAction as Action( of( TType ) ) ) _
    byref as LinkedList( of( TType ) )
    
    var _
      n => _first
    
    for _
      i as integer => 0 _
      to _count - 1
      
      anAction.invoke( n->item )
      n => n->forward
    next
    
    return( this )
  end function
  
  function _
    LinkedList( of( TType ) ).forEach( _
      byref aPredicate as Predicate( of( TType ) ), _
      byref anAction as Action( of( TType ) ) ) _
    byref as LinkedList( of( TType ) )
    
    var _
      n => _first
    
    for _
      i as integer => 0 _
      to _count - 1
      
      if( aPredicate.eval( n->item ) ) then
        anAction.invoke( n->item )
      end if
      
      n => n->forward
    next
    
    return( this )
  end function
  
  operator _
    =( _
      byref lhs as LinkedList( of( TType ) ), _
      byref rhs as LinkedList( of( TType ) ) ) _
    as integer
    
    return( @lhs = @rhs )
  end operator
#endmacro

#endif
