#include once "fbfw-drawing.bi"
#include once "fbfw-interaction.bi"

#include once "../common/inc/color-wheel.bi"

using Drawing

var _
  disp => Display( _
    new FBGFX.DisplayOps() )

with disp
  .init( 800, 600 )
  .clear()
end with

var _
  aWheel => ColorWheel( _
    Drawing.Size( _
      300, 300 ) )

aWheel.location => Drawing.Point( _
  disp.width shr 1 - aWheel.width shr 1, _
  disp.height shr 1 - aWheel.height shr 1 )

var _
  mouse => Interaction.FBGFX.MouseInput()

dim as Fb.Event _
  e

do
  '' Poll events
  do while( screenEvent( @e ) )
    mouse.onEvent( @e )
  loop
  
  '' Render frame
  with disp
    .startFrame()
    .clear( cast( FbColor, FbColor.Thistle ) )
    
    aWheel.renderTo( .graphics )
    
    .endFrame()
  end with
loop until( e.type = Fb.EVENT_WINDOW_CLOSE )
