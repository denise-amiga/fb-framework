#include once "fbfw-collections.bi"
#include once "../common/inc/person.bi"

template( List, of( Person ) )

#include once "../common/inc/person-predicates.bi"

/'
  Example usage of predicates to select elements from collections
'/
scope
  var _
    aList => List( of( Person ) )
  
  with aList
    .add( new Person( "John", 34 ) )
    .add( new Person( "Mary", 27 ) )
    .add( new Person( "Jules", 24 ) )
  end with
  
  scope
    var _
      selected => aList.selectAll( PersonsBelowAge( 28 ) )
    
    ? "Persons whose age is under 28 years: "
    
    for _
      i as integer => 0 _
      to selected->count - 1
      
      ? *selected->at( i ).name & ", " & _
        *selected->at( i ).age
    next
  end scope
  
  ?
  ? "All people: "
  for _
    i as integer => 0 _
    to aList.count - 1
    
    ? *aList.at( i ).name & ", " & *aList.at( i ).age
  next
  
  ?
end scope

sleep()
