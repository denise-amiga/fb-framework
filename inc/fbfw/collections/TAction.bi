#ifndef __FBFW_COLLECTIONS_ACTION__
#define __FBFW_COLLECTIONS_ACTION__

/'
  Template for Actions
'/
#define Action( TType ) _
  __T__##IAction##__##TType
#define ActionFunc( TType ) _
  __T__##ActionFunc##__##TType

#macro template_action( TType )
  #ifndef __T__##IAction##__##TType
    type _
      Action( of( TType ) ) _
      extends Object
      
      declare virtual destructor()
      
      declare abstract sub _
        invoke( _
          byval as TType ptr )
        
      as integer _
       indexOf
    end type
    
    destructor _
      Action( of( TType ) )() export
    end destructor
  #endif
  
  #ifndef __T__##ActionFunc##__##TType
    type as sub( _
      byval as integer, _
      byval as TType ptr, _
      byval as any ptr => 0 ) _
      __T__##ActionFunc##__##TType
  #endif
#endmacro

#endif
