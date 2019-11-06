/'
  A simple type for unit testing
'/
type _
  Person
  
  public:
    declare constructor()
    declare constructor( _
      byref as const string, _
      byval as integer )
    declare constructor( _
      byref as Person )
    declare operator _
      let( _
        byref as Person )
    declare destructor()
    
    declare operator _
      cast() as string
    
    as string _
      name
    as integer _
      age
end type

constructor _
  Person()
  
  name => "<unknown>"
  age => 0
end constructor

constructor _
  Person( _
    byref aName as const string, _
    byval anAge as integer )
  
  name => aName
  age => anAge
end constructor

constructor _
  Person( _
    byref rhs as Person )
  
  name => rhs.name
  age => rhs.age
end constructor

destructor _
  Person()
  
  ? "R.I.P. (" & name & ", " & age & ")"
end destructor

operator _
  Person.let( _
    byref rhs as Person )
  
  name => rhs.name
  age => rhs.age
end operator

operator _
  Person.cast() _
  as string
  
  return( name & ", " & age )
end operator

operator _
  =( _
    byref lhs as Person, _
    byref rhs as Person ) _
  as integer
  
  return( _
    lhs.name = rhs.name andAlso _
    lhs.age = rhs.age )
end operator

operator _
  <>( _
    byref lhs as Person, _
    byref rhs as Person ) _
  as integer
  
  return( _
    lhs.name <> rhs.name orElse _
    lhs.age <> rhs.age )
end operator

operator _
  <( _
    byref lhs as Person, _
    byref rhs as Person ) _
  as integer
  
  return( lhs.age < rhs.age )
end operator

operator _
  <=( _
    byref lhs as Person, _
    byref rhs as Person ) _
  as integer
  
  return( lhs.age <= rhs.age )
end operator

operator _
  >( _
    byref lhs as Person, _
    byref rhs as Person ) _
  as integer
  
  return( lhs.age > rhs.age )
end operator

operator _
  >=( _
    byref lhs as Person, _
    byref rhs as Person ) _
  as integer
  
  return( lhs.age >= rhs.age )
end operator
