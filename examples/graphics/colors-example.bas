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
  
  with aDisplay
    .clear()
    .startFrame()
      for _
        y as integer => 0 _
        to aDisplay.height - 1
        
        for _
          x as integer => 0 _
          to aDisplay.width - 1
          
          dim as integer _
            fw => ( 255 / aDisplay.width ) * x, _
            fh => ( 255 / aDisplay.height ) * y
          
          pixels[ ( y * aDisplay.width ) + x ] => iif( _
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
  .clear( FbColor.Black )
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
