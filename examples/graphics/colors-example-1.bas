#include once "fbfw-drawing.bi"

/'
  Example showing the four color models currently 
  implemented.
'/
using Drawing

enum ColorModel
  RGB
  HSV
  HSL
  HCY
end enum

sub _
  showModel( _
    byref aDisplay as Display, _
    byval pixels as ulong ptr, _
    byval aModel as ColorModel )
  
  dim as string _
    modelName => iif( _
      aModel = ColorModel.RGB, "RGB Color Model", iif( _
      aModel = ColorModel.HSV, "HSV Color Model", iif( _
      aModel = ColorModel.HSL, "HSL Color Model", iif( _
      aModel = ColorModel.HCY, "HCY Color Model", _
      "Unknown" ) ) ) )
    
  windowTitle( modelName )
  
  dim as integer _
    pitch => aDisplay.graphics.pitch
  var _
    px => aDisplay.graphics.pixels
  
  dim as single _
    xf => 255 / aDisplay.width, _
    yf => 255 / aDisplay.height
  
  with aDisplay
    .startFrame()
      for _
        y as integer => 0 _
        to aDisplay.height - 1
        
        for _
          x as integer => 0 _
          to aDisplay.width - 1
          
          dim as integer _
            fw => xf * x, _
            fh => yf * y
          
          pixel( px, x, y, pitch ) => iif( _
            aModel = ColorModel.RGB, FbColor.fromRGBA( _
              255, fw, fh, 255 ), iif( _
            aModel = ColorModel.HSV, FbColor.fromHSV( _
              fw, 255, fh, 255 ), iif( _
            aModel = ColorModel.HSL, FbColor.fromHSL( _
              fw, 255, fh, 255 ), iif( _
            aModel = ColorModel.HCY, FbColor.fromHCY( _
              fw, 255, fh, 255 ), _
            FbColor.Black ) ) ) )
        next
      next
    .endFrame()
  end with
end sub

var _
  disp => Display( _
    new FBGFX.DisplayOps( Fb.GFX_ALPHA_PRIMITIVES ) )

with disp
  .init( 800, 600 )
  .clear( FbColor.fromRGBA( 255, 0, 255, 255 ) )
end with

dim as ulong ptr _
  pixels => screenPtr()

for _
  model as ColorModel => ColorModel.RGB _
  to ColorModel.HCY
  
  showModel( _
    disp, _
    pixels, _
    model )
  
  sleep()
next
