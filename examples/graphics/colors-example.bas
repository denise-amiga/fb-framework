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
  .endFrame()
end with

dim as ulong ptr _
  scr => screenPtr()

disp.startFrame()
  for _
    y as integer => 0 _
    to disp.height - 1
    
    for _
      x as integer => 0 _
      to disp.width - 1
      
      scr[ ( y * disp.width ) + x ] => FbColor.fromHCY( _
        ( 255 / disp.width ) * x, _
        255, _
        ( 255 / disp.height ) * y, _
        255 )
    next
  next
disp.endFrame()

sleep()
