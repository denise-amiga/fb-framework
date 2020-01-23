#include once "fbfw-drawing.bi"
#include once "fbfw-interaction.bi"

/'
  Example using the Interaction framework to control the
  mouse.
'/
using Drawing

var _
  disp => Display( new FBGFX.DisplayOps() )

with disp
  .init( 800, 600 )
  .clear( FbColor.fromRGBA( 255, 128, 64, 255 ) )
end with

var _
  keyboard => Interaction.FBGFX.KeyboardInput(), _
  mouse => Interaction.FBGFX.MouseInput()

dim as boolean _
  toggle => false

dim as Fb.Event _
  e

do
  '' Poll events
  do while( screenEvent( @e ) )
    keyboard.onEvent( @e )
    mouse.onEvent( @e )
  loop
  
  var _
    ballColor => FbColor.fromRGBA( 255, 0, 0 ), _
    squareColor => iif( toggle, _
      FbColor.fromRGBA( 255, 255, 0 ), _
      FbColor.fromRGBA( 0, 255, 0 ) )
  
  if( mouse.held( Fb.BUTTON_LEFT ) ) then
    ballColor => FbColor.fromRGBA( 0, 0, 255 )
  end if
  
  if( mouse.repeated( Fb.BUTTON_LEFT, 200.0 ) ) then
    toggle xor=> true
  end if
  
  '' Render frame
  with disp
    .startFrame()
    .clear()
    
    with disp.graphics
      .filledCircle( _
        mouse.X, mouse.Y, _
        25, ballColor )
      
      .filledRectangle( _
        mouse.X - 200 - 25, mouse.Y - 25, _
        mouse.X - 200 + 25, mouse.Y + 25, _
        squareColor )
    end with
    
    .endFrame()
  end with
loop until( _
  keyboard.pressed( Fb.SC_ESCAPE ) orElse _
  e.type = Fb.EVENT_WINDOW_CLOSE )
