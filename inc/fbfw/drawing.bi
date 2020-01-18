#ifndef __FBFW_DRAWING__
#define __FBFW_DRAWING__

#include once "fbgfx.bi"
#include once "fbfw-math-commons.bi"
#include once "fbfw-collections.bi"
#include once "fbfw-events.bi"

/'
  Framework that defines some common abstractions used in rendering. Used by
  almost every other drawing function.
'/
namespace Drawing
  /'
    Defines an alignment, generally expressed with respect to a bounding
    rectangle or some other anchor.
  '/
  enum _
    Alignment
    
    Left
    Center
    Right
  end enum
  
  /'
    Forward define the Rectangle and Size types (since they will not be
    defined yet when we declare the Point types).
  '/
  type as Rectangle _
    _Rectangle
  type as RectangleF _
    _RectangleF
  type as Size _
    _Size
  type as SizeF _
    _SizeF
end namespace

__include__( __FBFW_DRAWING_FOLDER__, point.bi )
__include__( __FBFW_DRAWING_FOLDER__, pointF.bi )
__include__( __FBFW_DRAWING_FOLDER__, size.bi )
__include__( __FBFW_DRAWING_FOLDER__, sizeF.bi )
__include__( __FBFW_DRAWING_FOLDER__, rectangle.bi )
__include__( __FBFW_DRAWING_FOLDER__, rectangleF.bi )
__include__( __FBFW_DRAWING_FOLDER__, region.bi )

/'
  Framework for working with graphics. Contains some commonly used functions
  and abstractions.
'/
namespace Drawing
  '' The size of a Fb.Image buffer header, in pixels
  const as integer _
    ImageHeaderSize => _
      ( sizeOf( Fb.Image ) \ sizeOf( ulong ) )
  
  '' The conversion function for colors
  #define __cvclr__( c ) culng( c )
  
  '' Masks for the color components
  #define __R_MASK__ &h00ff0000
  #define __G_MASK__ &h0000ff00
  #define __B_MASK__ &h000000ff
  #define __A_MASK__ &hff000000
  #define __RB_MASK__ &h00ff00ff
  #define __AG_MASK__ &hff00ff00
  
  #ifndef Color_R
    #define Color_R( c ) _
      ( __cvclr__( c ) shr 16 and 255 )
  #endif
  
  #ifndef Color_G
    #define Color_G( c ) _
      ( __cvclr__( c ) shr 8 and 255 )
  #endif
  
  #ifndef Color_B
    #define Color_B( c ) _
      ( __cvclr__( c ) and 255 )
  #endif
  
  #ifndef Color_A
    #define Color_A( c ) _
      ( __cvclr__( c ) shr 24 )
  #endif
  
  /'
    Gets a pointer to the pixel area of a 32-bit Fb.Image buffer
  '/
  #define pixelAreaOf( buffer ) _
    ( cptr( _
      ulong ptr, _
      buffer ) + Drawing.ImageHeaderSize )
    
  #define pMin( v, a ) _
    iif( ( v ) < ( a ), ( v ), ( a ) )
  #define pMax( v, a ) _
    iif( ( v ) > ( a ), ( v ), ( a ) )
  
  /'
    Fetches a pixel within a delimited area. Any pixel outside
    this area is treated as a transparent( &h00000000 ) pixel.
    Note that, if the pixel is indeed outside the area, you can't
    assign it a value, and trying to do so with this #define will
    result in a compile error.
  '/
  #define boundedPixelOf( buffer, x, y, w, h, pitch ) _
    iif( _
      x >= 0 andAlso _
      y >= 0 andAlso _
      x <= ( w ) - 1 andAlso _
      y <= ( h ) - 1, _
      buffer[ ( pitch ) * ( y ) + ( x ) ], 0 )
    
  /'
    Like the above but without bounds checking. Might be faster in some
    situations where bounding is not required. Note that it also needs
    the padding of the buffer, in pixels.
    
    Unlike the above, you CAN use it as a generic pixel get/set function:
    
    Set the pixel color
    pixel( buffer, x, y, pitch ) => rgba( 255, 0, 255, 255 )
    
    Get the pixel color
    clr => pixel( buffer, x, y, pitch )
  '/
  #define pixel( buffer, x, y, pitch ) _
    buffer[ ( pitch ) * ( y ) + ( x ) ]
  
  /'
    Get the address of a pixel. If the pixel is outside the specified
    bounds, it returns null.
  '/
  #define pixelAddress( buffer, x, y, w, h, pitch ) _
    iif( _
      x >= 0 andAlso _
      y >= 0 andAlso _
      x <= ( w ) - 1 andAlso _
      y <= ( h ) - 1, _
      @buffer[ ( pitch ) * ( y ) + ( x ) ], 0 )
  
  #define pitchInPixelsFor( buffer ) _
    ( buffer->pitch \ sizeOf( ulong ) )
  
  /'
    The src and dst parameters are expected to be 32-bit colors
  '/
  #define _
    op_blend( src, op ) _
      ( ( op * Color_A( src ) ) shr 8 )
  
  #define _
    pixel_op( src, dst, op ) _
      ( ( ( _
      ( ( src ) and __RB_MASK__ ) * op_blend( src, op ) ) + _
      ( ( dst ) and __RB_MASK__ ) * ( 255 - op_blend( src, op ) ) ) and __AG_MASK__ ) shr 8 or ( _
      ( ( ( src ) shr 8 ) and __RB_MASK__ ) * op_blend( src, op ) + _
      ( ( ( dst ) shr 8 ) and __RB_MASK__ ) * ( 255 - op_blend( src, op ) ) ) and __AG_MASK__  
end namespace

__include__( __FBFW_DRAWING_FOLDER__, fbcolor.bi )
__include__( __FBFW_DRAWING_FOLDER__, fullscreenmodeinfo.bi )
__include__( __FBFW_DRAWING_FOLDER__, surface.bi )
__include__( __FBFW_DRAWING_FOLDER__, graphics.bi )
__include__( __FBFW_DRAWING_FOLDER__, display-ops.bi )
__include__( __FBFW_DRAWING_FOLDER__, graphics-fbgfx.bi )
__include__( __FBFW_DRAWING_FOLDER__, display-ops-fbgfx.bi )
__include__( __FBFW_DRAWING_FOLDER__, display.bi )

#endif
