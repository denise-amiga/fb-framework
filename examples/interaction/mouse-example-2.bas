#include once "fbfw-drawing.bi"
#include once "fbfw-interaction.bi"

/'
  Example using the Interaction framework to draw rectangles to
  the screen.
'/
type _
  MyRectangle
  
  public:
    declare constructor( _
      byref as Drawing.Point, _
      byref as Drawing.Point, _
      byref as Drawing.FbColor )
    declare destructor()
    
    declare sub _
      render()
    
  private:
    declare constructor()
    
    as Drawing.Point _
      _topLeft
    as Drawing.Size _
      _size
    as Drawing.FbColor _
      _color => Drawing.FbColor.Black
end type

constructor _
  MyRectangle()
end constructor

constructor _
  MyRectangle( _
    byref aStartPoint as Drawing.Point, _
    byref anEndPoint as Drawing.Point, _
    byref aColor as Drawing.FbColor )
  
  if( anEndPoint.x < aStartPoint.x ) then
    swap anEndPoint.x, aStartPoint.x
  end if
  
  if( anEndPoint.y < aStartPoint.y ) then
    swap anEndPoint.y, aStartPoint.y
  end if
  
  _topLeft => aStartPoint
  _size => Drawing.Size( _
    abs( anEndPoint.x - aStartPoint.x ), _
    abs( anEndPoint.y - aStartPoint.y ) )
  _color => aColor
end constructor

destructor _
  MyRectangle()
end destructor

sub _
  MyRectangle.render()
  
  line _
    ( _topLeft.x, _topLeft.y ) - _
    ( _topLeft.x + _size.width - 1, _
      _topLeft.y + _size.height - 1 ), _
    _color, bf
end sub

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

dim as Drawing.Point _
  startPoint, _
  endPoint
dim as boolean _
  drawingMode => false

do
  '' Poll events
  dim as Fb.Event _
    e
  
  do while( screenEvent( @e ) )
    keyboard.onEvent( @e )
    mouse.onEvent( @e )
  loop
  
  if( mouse.held( Fb.BUTTON_LEFT ) ) then
    endPoint => Drawing.Point( mouse.x, mouse.y )
  end if
  
  if( mouse.pressed( Fb.BUTTON_LEFT ) ) then
    drawingMode => true
    startPoint => Drawing.Point( mouse.x, mouse.y )
  end if
  
  if( mouse.released( Fb.BUTTON_LEFT ) ) then
    drawingMode => false
    
    rectangles.add( _
      new MyRectangle( _
        startPoint, _
        endPoint, _
        FbColor.fromRGBA( _
          rnd() * 255, _
          rnd() * 255, _
          rnd() * 255, _
          128 ) ) )
  end if
  
  '' Render frame
  with disp
    .startFrame()
    .clear()
    
    for _
      i as integer => 0 _
      to rectangles.count - 1
      
      rectangles.at( i )->render()
    next
    
    if( drawingMode ) then
      line _
        ( startPoint.x, startPoint.y ) - _
        ( endPoint.x, endPoint.y ), _
        rgba( 255, 255, 255, 255 ), b
    end if
    
    .endFrame()
  end with
loop until( keyboard.pressed( Fb.SC_ESCAPE ) )
