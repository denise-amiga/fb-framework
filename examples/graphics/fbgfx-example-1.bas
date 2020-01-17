#include once "fbfw-drawing.bi"

using Drawing

var _
  disp => Display( _
    new FBGFX.DisplayOps( Fb.GFX_ALPHA_PRIMITIVES ) )

with disp
  .init( 800, 600 )
  .clear( FbColor.Black )
end with

with disp
  .startFrame()
    .clear()
    .textAt( _
      0, 0, _
      str( .rows ) & "x" & .columns, _
      FbColor.White )
    .textAt( _
      0, 1, _
      "This is a test", _
      FbColor.White )
  .endFrame()
end with

sleep()
