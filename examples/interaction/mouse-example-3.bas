#include once "fbfw-drawing.bi"
#include once "fbfw-interaction.bi"
#include once "fbfw-math-commons.bi"

#include once "../common/inc/fbgfx-commons.bi"
#include once "inc/my-rectangle.bi"

#define inMilliseconds( t ) _
  ( t ) * 1000.0

type as Drawing.Point _
  Point_

template( List, of( Point_ ) )

function _
  drawPoints( _
    byref g as Drawing.Graphics, _
    byref startingPoint as const Drawing.Point, _
    byref points as List( of( Point_ ) ), _
    byref pointColor as const Drawing.FbColor, _
    byref lineColor as const Drawing.FbColor ) _
  as Drawing.Point
  
  for _
    i as integer => 0 _
    to points.count - 1
    
    var _
      p => iif( i > 0, _
        *points.at( i ) + startingPoint, _
        startingPoint )
    
    g.filledCircle( _
      p.x, p.y, _
      8, pointColor )
  next
  
  for _
    i as integer => 0 _
    to points.count - 1
    
    if( i > 0 ) then
      var _
        p1 => *points.at( i ) + startingPoint, _
        p2 => iif( i - 1 = 0, _
          startingPoint, _
          *points.at( i - 1 ) + startingPoint )
      
      g.drawLine( _
        p1.x, p1.y, _
        p2.x, p2.y, _
        lineColor )
    end if
  next
  
  return( _
    startingPoint + _
    *points.at( points.count - 1 ) )
end function

using Drawing

var _
  disp => Display( _
    new FBGFX.DisplayOps( Fb.GFX_ALPHA_PRIMITIVES ) )

with disp
  .init( 800, 600 )
  .clear( _
    FbColor.fromRGBA( 0, 0, 0, 255 ), _
    cast( FbColor, FbColor.Transparent ) )
end with

var _
  keyboard => Interaction.FBGFX.KeyboardInput(), _
  mouse => Interaction.FBGFX.MouseInput()

var _
  points => List( of( Point_ ) )

var _
  background => createBackground( _
    FbColor.fromRGBA( 252, 252, 252, 255 ), _
    FbColor.fromRGBA( 191, 191, 191, 255 ), _
    disp.width, _
    disp.height )
  
dim as boolean _
  dropped, _
  done

dim as double _
  startTime, _
  interval => 25.0

dim as Fb.Event _
  e

do
  '' Poll events
  do while( screenEvent( @e ) )
    keyboard.onEvent( @e )
    mouse.onEvent( @e )
  loop
  
  if( mouse.pressed( Fb.BUTTON_LEFT ) ) then
    startTime => timer()
    
    with points
      .clear()
      .add( new Drawing.Point( _
        mouse.x, _
        mouse.y ) )
    end with
    
    done => false
  end if
  
  if( mouse.drag( Fb.BUTTON_LEFT ) ) then
    dim as double _
      elapsed => inMilliseconds( timer() - startTime ) 
      
      if( elapsed >= interval ) then
        points.add( new Drawing.Point( _
          mouse.x - points.at( 0 )->x, _
          mouse.y - points.at( 0 )->y ) )
        
        startTime => timer()
      end if
  end if
  
  if( mouse.drop( Fb.BUTTON_LEFT ) ) then
    points.add( new Drawing.Point( _
      mouse.x - points.at( 0 )->x, _
      mouse.y - points.at( 0 )->y ) )
    
    done => true
  end if
  
  '' Render and display frame
  with disp
    .startFrame()
    .graphics.drawSurface( _
      *background, 0, 0 )
    
    .textAt( _
      1, 1, str( mouse.x ) & ", " & mouse.y )
    
    if( done ) then
      .textAt( _
        2, 1, "Count: " & points.count )
      
      var _
        endPoint => drawPoints( _
          disp.graphics, _
          *points.at( 0 ), _
          points, _
          FbColor.Red, _
          FbColor.Black )
      
      for _
        i as integer => 1 _
        to 2
      
        endPoint => drawPoints( _
          .graphics, _
          endPoint, _
          points, _
          FbColor.Blue, _
          FbColor.DarkBlue )
      next
    end if
    
    .endFrame()
  end with
loop until( e.type = Fb.EVENT_WINDOW_CLOSE )

delete( background )
