#include once "collections.bi"
#include once "bi/person-type.bi"

/'
  Dictionary unit test
'/ 
template( Dictionary, _
  of( integer ), of( Person ) )
template( List, of( Person ) )

#include once "bi/person-predicates.bi"
#include once "bi/person-actions.bi"

scope
  var _
    aDictionary => Dictionary( _
      of( integer ), of( Person ) )(), _
    aList => List( of( Person ) )()
  
  for _
    items as integer => 1 _
    to 10
    
    var _
      aPerson => new Person( "Person" & items, items )
    
    aList.add( aPerson )
    
    /'
      Note the syntax here. We pass the Person instance to the List as-is, but
      we pass the instance to the Dictionary dereferenced. This is because the
      default semantics for all collections is to *own* objects passed to them
      as pointers, and *reference* objects passed to them byref.
      
      Hence, the list will take ownership of the instances and automatically
      destroy them if the list goes out of scope. 
    '/
    aDictionary.add( items, *aPerson )
  next
  
  aList.forEach( _
    PersonsBelowAge( 5 ), _
    ShowPerson() )
end scope

sleep()
