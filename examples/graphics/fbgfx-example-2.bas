#include once "fbfw-graphics.bi"

using Graphics

var _
  disp => Display( _
    new FBGFX.DisplayOps( Fb.GFX_ALPHA_PRIMITIVES ) )

with disp
  .init( 800, 600 )
  .clear( rgba( 255, 128, 64, 255 ) )
end with

with disp
  .startFrame()
    .clear()
    .textAt( _
      0, 0, _
      str( .rows ) & "x" & .columns, _
      Drawing.Colors.Black )
    .textAt( _
      0, 1, _
      "This is a test", _
      Drawing.Colors.Black )
  .endFrame()
end with

sleep()
