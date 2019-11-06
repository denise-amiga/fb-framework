/'
  Some predicates to test
'/
type _
  PersonsBelowAge _
  extends Predicate( of( Person ) )
  
  public:
    declare constructor( _
      byval as integer )
    declare destructor() override
    
    declare function _
      eval( _
        byval as Person ptr ) _
      as boolean override
    
  private:
    declare constructor()
    
    as integer _
      _age
end type

constructor _
  PersonsBelowAge()
end constructor

constructor _
  PersonsBelowAge( _
    byval anAge as integer )
  
  _age => iif( anAge < 1, 1, anAge )
end constructor

destructor _
  PersonsBelowAge()
end destructor

function _
  PersonsBelowAge.eval( _
    byval aPerson as Person ptr ) _
  as boolean
  
  return( aPerson->age < _age )
end function
