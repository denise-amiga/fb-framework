#ifndef __FBFW_DRAWING_SURFACE__
#define __FBFW_DRAWING_SURFACE__

#include once "crt.bi"

namespace Drawing
  /'
    Encapsulates a surface for rendering
  '/
  type _
    Surface _
    extends Object
    
    public:
      declare constructor( _
        byval as integer, _
        byval as integer )
      declare constructor( _
        byval as integer, _
        byval as integer, _
        byref as const Drawing.FbColor )
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
        pitchInPixels() as integer
      declare property _
        pixels() as ulong ptr
      declare property _
        padding() as integer
      
      declare sub _
        clear()
      declare sub _
        clear( _
          byref as const Drawing.FbColor )
      declare function _
        clone() as Surface
      declare sub _
        renderTo( _
          byref as Surface, _
          byval as ubyte => 255, _
          byval as integer => 0, _
          byval as integer => 0 )
        
    protected:
      declare constructor()
      
      declare sub _
        create( _
          byval as integer, _
          byval as integer, _
          byref as const Drawing.FbColor )
        
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
      byval aHeight as integer )
    
    aWidth => iif( aWidth < 1, 1, aWidth )
    aHeight => iif( aHeight < 1, 1, aHeight )
    
    create( _
      aWidth, _
      aHeight, _
      FbColor.fromRGBA( 0, 0, 0, 0 ) )
  end constructor
  
  constructor _
    Surface( _
      byval aWidth as integer, _
      byval aHeight as integer, _
      byref aColor as const Drawing.FbColor )
    
    aWidth => iif( aWidth < 1, 1, aWidth )
    aHeight => iif( aHeight < 1, 1, aHeight )
    
    create( _
      aWidth, _
      aHeight, _
      aColor )
  end constructor
  
  constructor _
    Surface( _
      byref rhs as Surface )
    
    create( _
      rhs.width, _
      rhs.height, _
      Drawing.FbColor.fromRGBA( 0, 0, 0, 0 ) )
    
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
    Surface.pitchInPixels() _
    as integer
    
    return( pitchInPixelsFor( _surface ) )
  end property
  
  property _
    Surface.pixels() _
    as ulong ptr
    
    return( pixelAreaOf( _surface ) )
  end property
  
  property _
    Surface.padding() _
    as integer
    
    return( pitchInPixels - this.width )
  end property
  
  sub _
    Surface.create( _
      byval aWidth as integer, _
      byval aHeight as integer, _
      byref aBaseColor as const Drawing.FbColor )
    
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
    Surface.clear()
    
    dim as ulong ptr _
      px => pixels
    dim as integer _
      numPixels => _
        _surface->height * pitchInPixelsFor( _surface ) - 1
      
    for _
      i as integer => 0 _
      to numPixels - 1
      
      *px => 0
      px +=> 1
    next
  end sub
  
  sub _
    Surface.clear( _
      byref aColor as const Drawing.FbColor )
    
    dim as ulong ptr _
      px => pixels
    dim as ulong _
      c => aColor
    dim as integer _
      numPixels => _
        _surface->height * pitchInPixelsFor( _surface ) - 1
      
    for _
      i as integer => 0 _
      to numPixels - 1
      
      *px => c
      px +=> 1
    next
  end sub
  
  function _
    Surface.clone() _
    as Surface
    
    return( Surface( this ) )
  end function
  
  sub _
    Surface.renderTo( _
      byref destination as Surface, _
      byval opacity as ubyte => 255, _
      byval x as integer => 0, _
      byval y as integer => 0 )
    
    opacity => Math.iClamp( opacity, 0, 255 )
    
    dim as ulong ptr _
      src, dst
    
    dim as integer _
      dstStartX => Math.iMax( 0, x ), _
      dstStartY => Math.iMax( 0, y ), _
      srcStartX => Math.iMax( 0, -x ), _
      srcStartY => Math.iMax( 0, -y ), _
      srcEndX, srcEndY, _
      srcStride, dstStride
    
    '' Compute clipping values		
    srcEndX => _
      Math.iMin( _surface->width - 1, _
        ( ( destination.width - 1 ) - _
        ( x + _surface->width - 1 ) ) + _surface->width - 1 )
    srcEndY => _
      Math.iMin( _surface->height - 1, _
        ( ( destination.height - 1 ) - _
        ( y + _surface->height - 1 ) ) + _surface->height - 1 )
    
    '' Compute strides
    dstStride => _
      destination.pitchInPixels - ( srcEndX - srcStartX ) - 1
    srcStride => _
      padding + srcStartX + ( _surface->width - 1 - srcEndX )
    
    '' Fetch the position of the start of the pixel buffer
    '' for each surface.
    src => pixels
    dst => destination.pixels
    
    '' Offset the destination buffer to its starting position
    dst +=> _
      ( ( dstStartY * ( destination.pitchInPixels + _
        destination.padding ) ) + dstStartX )
    
    '' Offset the source buffer to its starting position
    src +=> ( ( srcStartY * pitchInPixels ) + srcStartX )
    
    /'
      Renders source buffer into destination buffer
    '/
    for _
      y as integer => srcStartY _
      to srcEndY
      
      for _
        x as integer => srcStartX _
        to srcEndX			
        
        '' Apply the blending function
        *dst => pixel_op( *src, *dst, opacity )
        
        '' Next pixel
        dst +=> 1
        src +=> 1
      next
      
      '' Add the stride to the end of each horizontal scanline
      dst +=> dstStride
      src +=> srcStride
    next
  end sub
end namespace

#endif
