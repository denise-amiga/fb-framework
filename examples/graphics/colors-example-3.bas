#include once "fbfw-drawing.bi"

using Drawing

#define mix( c1, c2, x ) _
  ( ( c2 - c1 ) * x + c1 )

var _
  disp => Display( _
    new FBGFX.DisplayOps() )

with disp
  .init( 800, 600 )
  .clear()
end with

var _
  c1 => HCYAColor( 22, 255, 223, 255 ), _
  c2 => HCYAColor( 234, 128, 0, 255 )

with disp
  .startFrame()
  
  with .graphics
    var _
      px => .pixels
    dim as integer _
      pitch => .pitch
    dim as single _
      blendFactor => 1.0 / .bounds.width
    
    for _
      y as integer => 0 _
      to .bounds.height - 1
      
      for _
        x as integer => 0 _
        to .bounds.width - 1
        
        var _
          c => HCYAColor( _
            mix( c1.H, c2.H, blendFactor * x ), _
            mix( c1.C, c2.C, blendFactor * x ), _
            mix( c1.Y, c2.Y, blendFactor * x ), _
            255 )
          
        pixel( px, x, y, pitch ) => _
          FbColor.fromHCY( c )
      next
    next
  end with
  
  .endFrame()
end with

sleep()
