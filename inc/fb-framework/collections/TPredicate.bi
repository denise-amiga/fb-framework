#ifndef __FB_COLLECTIONS__PREDICATE__
#define __FB_COLLECTIONS__PREDICATE__

/'
  Template for Predicates
'/
#define Predicate( TType ) _
  __T__##IPredicate##__##TType

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
    end type
    
    destructor _
      Predicate( of( TType ) )()
    end destructor
  #endif
#endmacro

#endif
