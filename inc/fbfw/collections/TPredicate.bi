#ifndef __FBFW_COLLECTIONS__PREDICATE__
#define __FBFW_COLLECTIONS__PREDICATE__

/'
  Template for Predicates
'/
#define Predicate( TType ) _
  __T__##IPredicate##__##TType
#define PredicateFunc( TType ) _
  __T__##PredicateFunc##__##TType

#macro template_predicate( TType )
  #ifndef __T__##IPredicate##__##TType
    type _
      Predicate( of( TType ) ) _
      extends Object
      
      declare virtual destructor()
      
      declare abstract function _
        eval( _
          byval as TType ptr ) _
        as boolean
      
      as integer _
        indexOf
    end type
    
    destructor _
      Predicate( of( TType ) )() export
    end destructor
  #endif
  
  #ifndef __T__##PredicateFunc##__##TType
    type as function( _
      byval as integer, _
      byval as TType ptr, _
      byval as any ptr => 0 ) as boolean _
      __T__##PredicateFunc##__##TType
  #endif
#endmacro

#endif
