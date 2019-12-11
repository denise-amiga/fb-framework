#ifndef __FBFW_DRAWING__
#define __FBFW_DRAWING__

#include once "fbfw-math-commons.bi"

/'
  Framework that defines some common abstractions used in rendering. Used by
  almost every other drawing function.
'/
namespace Drawing
  /'
    Constants for the standard colors that the FB text emulation uses
  '/
  enum _
    Colors
    
    Black => rgb( 0, 0, 0 )
    Blue => rgb( 0, 0, 175 )
    Green => rgb( 19, 161, 14 )
    Cyan => rgb( 0, 168, 175 )
    Red => rgb( 197, 15, 31 )
    Violet => rgb( 136, 23, 152 )
    Yellow => rgb( 193, 156, 0 )
    Gray => rgb( 178, 165, 178 )
    DarkGray => rgb( 118, 118, 118 )
    LightBlue => rgb( 59, 120, 255 )
    LightGreen => rgb( 22, 198, 12 )
    LightCyan => rgb( 97, 214, 214 )
    LightRed => rgb( 213, 72, 86 )
    LightViolet => rgb( 180, 0, 158 )
    LighYellow => rgb( 255, 255, 80 )
    White => rgb( 242, 242, 242 )
  end enum
  
  '' Abstracts a color value
  type as ulong _
    FbColor
  
  /'
    Defines an alignment, generally expressed with respect to a bounding
    rectangle or some other anchor.
  '/
  enum _
    Alignment
    
    Left
    Center
    Right
  end enum
  
  /'
    Forward define the Rectangle and Size types (since they will not be
    defined yet when we declare the Point types).
  '/
  type as Rectangle _
    _Rectangle
  type as RectangleF _
    _RectangleF
  type as Size _
    _Size
  type as SizeF _
    _SizeF
end namespace

__include__( __FBFW_DRAWING_FOLDER__, point.bi )
__include__( __FBFW_DRAWING_FOLDER__, pointF.bi )
__include__( __FBFW_DRAWING_FOLDER__, size.bi )
__include__( __FBFW_DRAWING_FOLDER__, sizeF.bi )
__include__( __FBFW_DRAWING_FOLDER__, rectangle.bi )
__include__( __FBFW_DRAWING_FOLDER__, rectangleF.bi )

#endif
