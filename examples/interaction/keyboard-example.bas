#include once "fbfw-drawing.bi"
#include once "fbfw-interaction.bi"

/'
  Example using the Interaction framework to control the
  keyboard.
'/
using Drawing

var _
  disp => Display( _
    new FBGFX.DisplayOps( Fb.GFX_ALPHA_PRIMITIVES ) )

with disp
  .init( 800, 600 )
  .clear( FbColor.fromRGBA( 255, 128, 64, 255 ) )
end with

dim as integer _
  x => disp.width \ 2, _
  y => disp.height \ 2, _
  radius => 10, _
  speed => 3

var _
  keyboard => Interaction.FBGFX.KeyboardInput()

dim as boolean _
  done

do
  '' Poll events
  dim as Fb.Event _
    e
  
  do while( screenEvent( @e ) )
    keyboard.onEvent( @e )
  loop

  '' Handle some keypresses
  if( keyboard.repeated( Fb.SC_UP, 200.0 ) ) then
    y => Math.iMax( 0, y - 50 )
	end if
		
  if( keyboard.pressed( Fb.SC_DOWN ) ) then
    y => Math.iMin( disp.height, y + 50 ) 
  end if
  
  if( keyboard.released( Fb.SC_LEFT ) ) then
    x => Math.iWrap( x - 50, 0, disp.width )
	end if
  
  if( keyboard.held( Fb.SC_RIGHT, 500.0 ) ) then
    x => Math.iWrap( x + speed, 0, disp.width )
  end if
  
  '' Render frame
  with disp
    .startFrame()
    .clear()
    
    circle _
      ( x, y ), _
      radius, rgb( 255, 255, 255 ), , , , f
    .endFrame()
  end with
  
  sleep( 1, 1 )
loop until( keyboard.pressed( Fb.SC_ESCAPE ) )
