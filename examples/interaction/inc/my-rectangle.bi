#ifndef __MYRECTANGLE__
#define __MYRECTANGLE__

type _
  MyRectangle
  
  public:
    declare constructor( _
      byref as Drawing.Point, _
      byref as Drawing.Point, _
      byref as Drawing.FbColor )
    declare destructor()
    
    declare sub _
      render( _
        byref as Drawing.Graphics )
    
  private:
    declare constructor()
    
    as Drawing.Rectangle _
      _rect
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
  
  _rect => Drawing.Rectangle( _
    aStartPoint, _ 
    Drawing.Size( _
      abs( anEndPoint.x - aStartPoint.x ), _
      abs( anEndPoint.y - aStartPoint.y ) ) )
    
  _color => aColor
end constructor

destructor _
  MyRectangle()
end destructor

sub _
  MyRectangle.render( _
    byref g as Drawing.Graphics )
  
  g.filledRectangle( _
    _rect.location.x, _rect.location.y, _
    _rect.location.x + _rect.width - 1, _
    _rect.location.y + _rect.height - 1, _
    _color )
  'line _
  '  ( _rect.location.x, _rect.location.y ) - _
  '  ( _rect.location.x + _rect.width - 1, _
  '    _rect.location.y + _rect.height - 1 ), _
  '  _color, bf
end sub

#endif
