#ifndef __FBFW_EXAMPLES_COMMON__
#define __FBFW_EXAMPLES_COMMON__

#include once "fbfw-drawing.bi"
#include once "fbfw-math-commons.bi"

#define mix( c1, c2, x ) _
  ( ( c2 - c1 ) * x + c1 )

function _
  createBackground( _
    byref c1 as const Drawing.FbColor, _
    byref c2 as const Drawing.FbColor, _
    byval w as integer, _
    byval h as integer ) _
  as Drawing.Surface ptr
  
  dim as single _
    centerX => w / 2, _
    centerY => h / 2, _
    maxValue => sqr( centerX ^ 2 + centerY ^ 2 )
  
  var _
    s => new Drawing.Surface( w, h )
  
  dim as integer _
    pitch => s->pitchInPixels
  dim as ulong ptr _
    px => s->pixels
  
  for _
    y as integer => 0 _
    to h - 1
  	
  	for _
  	  x as integer => 0 to _
  	  w - 1
  		
  		dim as single _
  		  v => sqr( _
  		    ( centerX - x ) * ( centerX - x ) + _
  		    ( centerY - y ) * ( centerY - y ) ) _
  		    / ( maxValue + 1 )
  		
  		pixel( _
  		  px, x, y, pitch ) => c1.mixColor( c2, v )
  	next
  next
  
  return( s )
end function

#endif
