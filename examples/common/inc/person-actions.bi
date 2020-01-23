/'
  Some actions to test
'/
type _
  SetAgeTo _
  extends Action( of( Person ) )
  
  public:
    declare constructor( _
      byval as integer )
    declare destructor() override
    
    declare sub _
      invoke( _
        byval as Person ptr ) override
      
  private:
    declare constructor()
    
    as integer _
      _age
end type

constructor _
  SetAgeTo()
end constructor

constructor _
  SetAgeTo( _
    byval aValue as integer )
  
  _age => aValue
end constructor

destructor _
  SetAgeTo()
end destructor

sub _
  SetAgeTo.invoke( _
    byval aPerson as Person ptr )
  
  aPerson->age => _age
end sub

type _
  ShowPerson _
  extends Action( of( Person ) )
  
  declare constructor()
  declare destructor() override
  
  declare sub _
    invoke( _
      byval as Person ptr ) override
end type

constructor _
  ShowPerson()
end constructor

destructor _
  ShowPerson()
end destructor

sub _
  ShowPerson.invoke( _
    byval aPerson as Person ptr )
  
  ? *aPerson
end sub
