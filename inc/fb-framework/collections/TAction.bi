#ifndef __FB_COLLECTIONS_ACTION__
#define __FB_COLLECTIONS_ACTION__

/'
  Template for Actions
'/
#define Action( TType ) _
  __T__##IAction##__##TType

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
      Action( of( TType ) )()
    end destructor
  #endif
#endmacro

#endif
