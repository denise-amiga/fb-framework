#include once "fbfw-drawing.bi"
#include once "fbfw-interaction.bi"
#include once "inc/my-rectangle.bi"

/'
  Example using the Interaction framework to draw rectangles to
  the screen.
'/
template( List, of( MyRectangle ) )

using Drawing

var _
  disp => Display( _
    new FBGFX.DisplayOps( Fb.GFX_ALPHA_PRIMITIVES ) )

with disp
  .init( 800, 600 )
  .clear( FbColor.fromRGBA( 255, 128, 64, 255 ) )
end with

var _
  keyboard => Interaction.FBGFX.KeyboardInput(), _
  mouse => Interaction.FBGFX.MouseInput(), _
  rectangles => List( of( MyRectangle ) )()  

dim as boolean _
  drawingMode => false

dim as Fb.Event _
  e

do
  '' Poll events
  do while( screenEvent( @e ) )
    keyboard.onEvent( @e )
    mouse.onEvent( @e )
  loop
  
  if( mouse.drag( Fb.BUTTON_LEFT ) ) then
    drawingMode => true
  end if
  
  if( mouse.drop( Fb.BUTTON_LEFT ) ) then
    rectangles.add( _
      new MyRectangle( _
        Drawing.Point( _
          mouse.startX, mouse.startY ), _
        Drawing.Point( _
          mouse.X, mouse.Y ), _
        FbColor.fromRGBA( _
          rnd() * 255, _
          rnd() * 255, _
          rnd() * 255, _
          128 ) ) )
    
    drawingMode => false
  end if
  
  '' Render frame
  with disp
    .startFrame()
    .clear()
    
    for _
      i as integer => 0 _
      to rectangles.count - 1
      
      rectangles.at( i )->render( _
        disp.graphics )
    next
    
    if( drawingMode ) then
      with disp.graphics
        .drawRectangle( _
          mouse.startX, mouse.startY, _
          mouse.X, mouse.Y, _
          cast( FbColor, FbColor.White ) )
      end with
    end if
    
    .endFrame()
  end with
loop until( _
  keyboard.pressed( Fb.SC_ESCAPE ) orElse _
  e.type = Fb.EVENT_WINDOW_CLOSE )
