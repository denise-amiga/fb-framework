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

do
  '' Poll events
  dim as Fb.Event _
    e
  
  do while( screenEvent( @e ) )
    keyboard.onEvent( @e )
    mouse.onEvent( @e )
  loop
  
  dim as ulong _
    ballColor => rgb( 255, 0, 0 ), _
    squareColor => iif( toggle, _
      rgb( 255, 255, 0 ), rgb( 0, 255, 0 ) )
  
  if( mouse.held( Fb.BUTTON_LEFT ) ) then
    ballColor => rgb( 0, 0, 255 )
  end if
  
  if( mouse.repeated( Fb.BUTTON_LEFT, 200.0 ) ) then
    toggle xor=> true
  end if
  
  '' Render frame
  with disp
    .startFrame()
    .clear()
    
    circle _
      ( mouse.x, mouse.y ), _
      25, ballColor, , , , f
    
    line _
      ( mouse.x - 200 - 25, mouse.y - 25 ) - _
      ( mouse.x - 200 + 25, mouse.y + 25 ), _
      squareColor, bf
    
    .endFrame()
  end with
loop until( keyboard.pressed( Fb.SC_ESCAPE ) )
