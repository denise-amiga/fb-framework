#ifndef __FBFW_RENDERER__
#define __FBFW_RENDERER__

namespace Graphics
  type _
    Renderer _
    extends Object
    
    public:
      declare constructor( _
        byref as Surface )
      declare virtual destructor()
      
    protected:
      declare constructor()
      
      as Surface ptr _
        _surface
  end type
  
  constructor _
    Renderer()
  end constructor
  
  constructor _
    Renderer( _
      byref aSurface as Surface )
    
    _surface => @aSurface
  end constructor
  
  destructor _
    Renderer()
  end destructor
end namespace

#endif
