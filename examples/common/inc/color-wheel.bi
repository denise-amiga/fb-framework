#ifndef __FBFW_EXAMPLES_COLORWHEEL__
#define __FBFW_EXAMPLES_COLORWHEEL__

#include once "fbfw-drawing.bi"
#include once "fbfw-math-commons.bi"

#include once "../common/inc/fbgfx-commons.bi"

type _
  ColorWheel
  
  public:
    declare constructor( _
      byref as Drawing.Size )
    declare constructor( _
      byref as Drawing.Point, _
      byref as Drawing.Size )
    declare destructor()
    
    declare property _
      location() byref as Drawing.Point
    declare property _
      location( _
        byref as Drawing.Point )
    declare property _
      width() as integer
    declare property _
      height() as integer
    
    declare sub _
      renderTo( _
        byref as Drawing.Graphics )
  
  private:
    declare constructor()
    
    as Drawing.Surface ptr _
      _surface
    as Drawing.Point _
      _location
end type

constructor _
  ColorWheel()
end constructor

constructor _
  ColorWheel( _
    byref aSize as Drawing.Size )
  
  this.constructor( _
    Drawing.Point( 0, 0 ), _
    aSize )
end constructor

constructor _
  ColorWheel( _
    byref aLocation as Drawing.Point, _
    byref aSize as Drawing.Size )
  
  _location => aLocation
  _surface => _
    Drawing.Graphics.createSurface( _
      aSize.width, aSize.height )
end constructor

destructor _
  ColorWheel()
  
  delete( _surface )
end destructor

property _
  ColorWheel.location() _
  byref as Drawing.Point
  
  return( _location )
end property

property _
  ColorWheel.location( _
    byref value as Drawing.Point )
  
  _location => value
end property

property _
  ColorWheel.width() _
  as integer
  
  return( _surface->width )
end property

property _
  ColorWheel.height() _
  as integer
  
  return( _surface->height )
end property

sub _
  ColorWheel.renderTo( _
    byref g as Drawing.Graphics )
  
  var _
    center => Drawing.Point( _
      _surface->width / 2, _
      _surface->height / 2 )
  dim as integer _
    outerRadius => Math.iMin( _
      center.x, center.y ), _
    innerRadius => outerRadius * 0.8, _
    innerLength => innerRadius * 1.3, _
    halfInnerLength => innerLength shr 1
  
  var _
    px => _surface->pixels
  dim as integer _
    pitch => _surface->pitchInPixels
  
  dim as single _
    angFactor => 255 / 360.0
  
  for _
    y as integer => 0 _
    to _surface->height - 1
    
    for _
      x as integer => 0 _
      to _surface->width - 1
      
      dim as integer _
        d => ( ( center.x - x ) ^ 2 + ( center.y - y ) ^ 2 )
      
      if( _
        d >= ( innerRadius ^ 2 ) andAlso _
        d <= ( outerRadius ^ 2 ) ) then
        
        dim as single _
          ang => Math.toDegrees( _
            atan2( ( center.y - y ), ( center.x - x ) ) )
        var _
          c => Drawing.HCYAColor( _
            angFactor * ( ang + 180 ), _
            255, _
            128, _
            255 )
          
        pixel( px, x, y, pitch ) => _
          Drawing.FbColor.fromHCY( c )
      end if 
    next
  next
  
  dim as single _
    lengthFactor => 255 / innerLength
  dim as integer _
    offsetX => center.x - halfInnerLength, _
    offsetY => center.y - halfInnerLength
  
  for _
    y as integer => center.y - halfInnerLength _
    to center.y + halfInnerLength
    
    for _
      x as integer => center.x - halfInnerLength _
      to center.x + halfInnerLength
      
      var _
        c => Drawing.HCYAColor( _
          255, _
          lengthFactor * ( x - offsetX ), _
          255 - ( lengthFactor * ( y - offsetY ) ), _
          255 )
        
      pixel( px, x, y, pitch ) => _
        Drawing.FbColor.fromHCY( c )
    next
  next
  
  g.drawSurface( _
    *_surface, _
    _location.x, _location.y )
end sub

#endif
