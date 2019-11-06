#include once "collections.bi"
#include once "bi/person-type.bi"

function _
  personsBelowAge( _
    byval aPerson as Person ptr, _
    byval anAge as integer ) _
  as boolean
  
  return( cbool( aPerson->age < anAge ) )
end function

template( List, of( Person ) )

function _
  selectFrom( _
    byref aList as List( of( Person ) ), _
    byval aPredicate as function( _
      byval as Person ptr, _
      byval as integer ) _
        as boolean, _
    byval anAge as integer ) _
  as auto_ptr( of( List( of( Person ) ) ) )
  
  var _
    selected => new List( of( Person ) )
  
  for _
    i as integer => 0 _
    to aList.count - 1
    
    if( aPredicate( _
      aList.at( i ), _
      anAge ) ) then
      
      selected->add( *aList.at( i ) )
    end if
  next
  
  return( auto_ptr( _
    of( List( of( Person ) ) ) )( selected ) )
end function

/'
  Another usage case for predicates, but using a function instead
  of a class.
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
      selected => selectFrom( _
        aList, _
        @personsBelowAge, _
        28 )
    
    ? "Persons whose age is under 28 years: "
    
    for _
      i as integer => 0 _
      to selected->count - 1
      
      ? selected->at( i )->name & ", " & _
        selected->at( i )->age
    next
  end scope
  
  ?
  ? "All people: "
  for _
    i as integer => 0 _
    to aList.count - 1
    
    ? aList.at( i )->name & ", " & aList.at( i )->age
  next
  
  ?
end scope

sleep()
