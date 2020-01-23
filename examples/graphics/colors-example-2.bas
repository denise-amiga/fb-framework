#include once "fbfw-drawing.bi"
#include once "../common/inc/fbgfx-commons.bi"

using Drawing

var _
  disp => Display( _
    new FBGFX.DisplayOps( Fb.GFX_ALPHA_PRIMITIVES ) )

with disp
  .init( 800, 600 )
  .clear()
end with

var _
  inner => FbColor.fromRGBA( 255, 0, 255, 255 ), _
  outer => FbColor.fromRGBA( 255, 0, 0, 255 ), _
  b => createBackground( _
    inner, outer, _
    disp.width, disp.height )

with disp
  .startFrame()
  
  with .graphics
    .drawSurface( _
      *b, 0, 0 )
  end with
  
  .endFrame()
end with

sleep()

delete( b )
