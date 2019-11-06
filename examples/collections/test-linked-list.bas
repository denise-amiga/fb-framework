#include once "collections.bi"
#include once "bi/person-type.bi"

/'
  Linked list unit test
'/
template( LinkedList, of( Person ) )

#include once "bi/person-predicates.bi"
#include once "bi/person-actions.bi"

'scope
  var _
    p1 => Person( "Person 1", 1 ), _
    p2 => Person( "Person 2", 2 )
  
  var _
    aLinkedList => LinkedList( of( Person ) )()
  
  with aLinkedList
    .addFirst( new Person( "Paul Doe", 37 ) )
    .addFirst( new Person( "Janet Cabral", 31 ) )
    .addFirst( new Person( "Shaiel Lindt Cabral", 10 ) )
    .addFirst( p1 )
    .addFirst( p2 )
  
    .removefirst()
  end with
  
  aLinkedList.forEach( _
    PersonsBelowAge( 20 ), _
    SetAgeTo( -4 ) )
  
  /'
    And this is how one iterates a LinkedList from first to last node. To
    iterate the list backwards, the code is similar:
    
    aNode => aLinkedList.last
    
    for _
      item as integer => 0 _
      to aLinkedList.count - 1
      
      /' ... '/
      
      aNode => aNode->backward
    next
    
  '/
  var _
    aNode => aLinkedList.first
  
  for _
    item as integer => 0 _
    to aLinkedList.count - 1
    
    ? cast( Person, *aNode->item )
    
    aNode => aNode->forward
  next
  
  aLinkedList.clear()
'end scope

sleep()
