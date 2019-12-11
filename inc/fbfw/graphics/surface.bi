#ifndef __FBFW_GRAPHICS_SURFACE__
#define __FBFW_GRAPHICS_SURFACE__

#include once "crt.bi"

namespace Graphics
  /'
    Encapsulates a surface for rendering
  '/
  type _
    Surface _
    extends Object
    
    public:
      declare constructor( _
        byval as integer, _
        byval as integer, _
        byval as Drawing.FbColor => rgba( 0, 0, 0, 0 ) )
      declare constructor( _
        byref as Surface )
      declare virtual destructor()
      
      declare operator _
        cast() as Fb.Image ptr
      
      declare property _
        width() as integer
      declare property _
        height() as integer
      declare property _
        pitch() as integer
      declare property _
        pixels() as Drawing.FbColor ptr
      
      declare sub _
        clear( _
          byval aColor as Drawing.FbColor => rgba( 0, 0, 0, 0 ) )
      declare function _
        clone() as Surface
      
    protected:
      declare constructor()
      
      declare sub _
        create( _
          byval as integer, _
          byval as integer, _
          byval as Drawing.FbColor => rgba( 0, 0, 0, 0 ) )
        
      as Fb.Image ptr _
        _surface
      
    private:
      declare operator _
        let( byref as Surface )
  end type
  
  constructor _
    Surface()
  end constructor
  
  constructor _
    Surface( _
      byval aWidth as integer, _
      byval aHeight as integer, _
      byval aBaseColor as Drawing.FbColor => rgba( 0, 0, 0, 0 ) )
    
    aWidth => iif( aWidth < 1, 1, aWidth )
    aHeight => iif( aHeight < 1, 1, aHeight )
    
    create( _
      aWidth, _
      aHeight, _
      aBaseColor )
  end constructor
  
  constructor _
    Surface( _
      byref rhs as Surface )
    
    create( _
      rhs.width, _
      rhs.height )
    
    memcpy( _
      cptr( ubyte ptr, pixels ), _
      cptr( ubyte ptr, rhs.pixels ), _
      height * pitch )
  end constructor
  
  destructor _
    Surface()
    
    imageDestroy( _surface )
  end destructor
  
  operator _
    Surface.let( _
      byref rhs as Surface )
  end operator
  
  operator _
    Surface.cast() _
    as Fb.Image ptr
    
    return( _surface )
  end operator
  
  property _
    Surface.width() _
    as integer
    
    return( _surface->width )
  end property
  
  property _
    Surface.height() _
    as integer
    
    return( _surface->height )
  end property
  
  property _
    Surface.pitch() _
    as integer
    
    return( _surface->pitch )
  end property
  
  property _
    Surface.pixels() _
    as Drawing.FbColor ptr
    
    return( pixelAreaOf( _surface ) )
  end property
  
  sub _
    Surface.create( _
      byval aWidth as integer, _
      byval aHeight as integer, _
      byval aBaseColor as Drawing.FbColor => rgba( 0, 0, 0, 0 ) )
    
    if( _surface <> 0 ) then
      imageDestroy( _surface )
    end if
    
    _surface => imageCreate( _
      aWidth, _
      aHeight, _
      aBaseColor, _
      32 )
  end sub
  
  sub _
    Surface.clear( _
      byval aColor as Drawing.FbColor => rgba( 0, 0, 0, 0 ) )
    
    dim as Drawing.FbColor ptr _
      px => pixels
    dim as integer _
      numPixels => _
        _surface->height * pitchInPixelsFor( _surface ) - 1
      
    for _
      i as integer => 0 _
      to numPixels - 1
      
      *px => aColor
      px +=> 1
    next
  end sub
  
  function _
    Surface.clone() _
    as Surface
    
    return( Surface( this ) )
  end function
end namespace

#endif
