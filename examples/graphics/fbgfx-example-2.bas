#include once "fbfw-drawing.bi"

using Drawing

var _
  disp => Display( _
    new FBGFX.DisplayOps( Fb.GFX_ALPHA_PRIMITIVES ) )

with disp
  .init( 800, 600 )
  .clear( FbColor.fromRGBA( 255, 128, 64, 255 ) )
end with

with disp
  .startFrame()
    .clear()
    .textAt( _
      0, 0, _
      str( .rows ) & "x" & .columns, _
      FbColor.Black )
    .textAt( _
      0, 1, _
      "This is a test", _
      FbColor.Black )
  .endFrame()
end with

sleep()
