#ifndef __FBFW_GRAPHICS__
#define __FBFW_GRAPHICS__

#include once "fbgfx.bi"

#include once "fbfw-templates.bi"
#include once "fbfw-events.bi"
#include once "fbfw-drawing.bi"

/'
  Framework for working with graphics. Contains some commonly used functions
  and abstractions.
'/
namespace Graphics
  const _
    GfxNull => 0
  
  '' The conversion function for colors
  #define __cclr__( c ) culng( c )
  
  '' Masks for the color components
  #define __r_mask__ &h00ff0000
  #define __g_mask__ &h0000ff00
  #define __b_mask__ &h000000ff
  #define __a_mask__ &hff000000
  #define __rb_mask__ &h00ff00ff
  #define __ag_mask__ &hff00ff00
  
  '' The size of a Fb.Image buffer header, in pixels
  const as integer _
    ImageHeaderSize => _
      ( sizeOf( Fb.Image ) \ sizeOf( Drawing.fbColor ) )
end namespace

#ifndef Color_R
  #define Color_R( c ) _
    ( __cclr__( c ) shr 16 and 255 )
#endif

#ifndef Color_G
  #define Color_G( c ) _
    ( __cclr__( c ) shr 8 and 255 )
#endif

#ifndef Color_B
  #define Color_B( c ) _
    ( __cclr__( c ) and 255 )
#endif

#ifndef Color_A
  #define Color_A( c ) _
    ( __cclr__( c ) shr 24 )
#endif

#ifndef fbRGB
  #define fbRGB( r, g, b ) _
    ( ( __cclr__( r ) shl 16 ) or _
    ( __cclr__( g ) shl 8 ) or _
    __cclr__( b ) or _
    __a_msk__ )
#endif

#ifndef fbRGBA
  #define fbRGBA( r, g, b, a ) _
    ( ( __cclr__( r ) shl 16 ) or _
    ( __cclr__( g ) shl 8 ) or _
    __cclr__( b ) or _
    __cclr__( a ) shl 24 )
#endif

/'
  Gets a pointer to the pixel area of a 32-bit Fb.Image buffer
'/
#define pixelAreaOf( buffer ) _
  ( cptr( _
    Drawing.fbColor ptr, _
    buffer ) + Graphics.ImageHeaderSize )
  
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
  ( buffer->pitch \ sizeOf( Drawing.fbColor ) )

/'
  The src and dst parameters are expected to be 32-bit colors
'/
#define _
  op_blend( src, op ) _
    ( ( op * Color_A( src ) ) shr 8 )

#define _
  pixel_op( src, dst, op ) _
    ( ( ( _
    ( ( src ) and __rb_mask__ ) * op_blend( src, op ) ) + _
    ( ( dst ) and __rb_mask__ ) * ( 255 - op_blend( src, op ) ) ) and __ag_mask__ ) shr 8 or ( _
    ( ( ( src ) shr 8 ) and __rb_mask__ ) * op_blend( src, op ) + _
    ( ( ( dst ) shr 8 ) and __rb_mask__ ) * ( 255 - op_blend( src, op ) ) ) and __ag_mask__ )  

__include__( __FBFW_GRAPHICS_FOLDER__, fullscreenmodeinfo.bi )
__include__( __FBFW_GRAPHICS_FOLDER__, display-ops.bi )
__include__( __FBFW_GRAPHICS_FOLDER__, display.bi )
__include__( __FBFW_GRAPHICS_FOLDER__, surface.bi )
__include__( __FBFW_GRAPHICS_FOLDER__, display-ops-fbgfx.bi )
__include__( __FBFW_GRAPHICS_FOLDER__, renderer.bi )

#endif
