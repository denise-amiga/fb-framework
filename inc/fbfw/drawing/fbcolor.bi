#ifndef __FBFW_DRAWING_COLOR__
#define __FBFW_DRAWING_COLOR__

#include once "color-spaces.bi"

namespace Drawing
  type _
    _ccFloat
    
    as double _
      x, y, z, w
  end type
  
  /'
    Represents a color in RGBA space.
    
    Can also convert to and from HSL, HSV and HCY color spaces.
  '/
  type _
    FbColor
    
    public:
      declare constructor( _
        byref as const FbColor )
      declare destructor()
      
      declare static function _
        fromColor( _
          byval as ulong ) _
        as FbColor
      declare static function _
        fromRGBA( _
          byval as ubyte, _
          byval as ubyte, _
          byval as ubyte, _
          byval as ubyte => 255 ) _
        as FbColor
      declare static function _
        fromHSV( _
          byval as ubyte, _
          byval as ubyte, _
          byval as ubyte, _
          byval as ubyte => 255 ) _
        as FbColor
      declare static function _
        fromHSV( _
          byref as HSVAColor ) _
        as FbColor
      declare static function _
        fromHSL( _
          byval as ubyte, _
          byval as ubyte, _
          byval as ubyte, _
          byval as ubyte => 255 ) _
        as FbColor
      declare static function _
        fromHSL( _
          byref as HSLAColor ) _
        as FbColor
      declare static function _
        fromHCY( _
          byval as ubyte, _
          byval as ubyte, _
          byval as ubyte, _
          byval as ubyte => 255 ) _
        as FbColor
      declare static function _
        fromHCY( _
          byref as HCYAColor ) _
        as FbColor
      
      declare const operator _
        cast() as ulong
      
      declare const property _
        R() as ubyte
      declare const property _
        G() as ubyte
      declare const property _
        B() as ubyte
      declare const property _
        A() as ubyte
      
      declare const function _
        toHSV() as HSVAColor
      declare const function _
        toHSL() as HSLAColor
      declare const function _
        toHCY() as HCYAColor
      
      declare const function _
        mix( _
          byref as FbColor, _
          byval as double ) _
        as FbColor
      declare const function _
        mixColor( _
          byref as const FbColor, _
          byval as double ) _
        as FbColor
      declare const function _
        mixAlpha( _
          byval as ubyte, _
          byval as double ) _
        as FbColor
      
      declare static function _
        AliceBlue() byref as const FbColor
      declare static function _
        AntiqueWhite() byref as const FbColor
      declare static function _
        Aqua() byref as const FbColor
      declare static function _
        Aquamarine() byref as const FbColor
      declare static function _
        Azure() byref as const FbColor
      declare static function _
        Beige() byref as const FbColor
      declare static function _
        Bisque() byref as const FbColor
      declare static function _
        Black() byref as const FbColor
      declare static function _
        BlanchedAlmond() byref as const FbColor
      declare static function _
        Blue() byref as const FbColor
      declare static function _
        BlueViolet() byref as const FbColor
      declare static function _
        Brown() byref as const FbColor
      declare static function _
        BurlyWood() byref as const FbColor
      declare static function _
        CadetBlue() byref as const FbColor
      declare static function _
        Chartreuse() byref as const FbColor
      declare static function _
        Chocolate() byref as const FbColor
      declare static function _
        Coral() byref as const FbColor
      declare static function _
        CornflowerBlue() byref as const FbColor
      declare static function _
        Cornsilk() byref as const FbColor
      declare static function _
        Crimson() byref as const FbColor
      declare static function _
        Cyan() byref as const FbColor
      declare static function _
        DarkBlue() byref as const FbColor
      declare static function _
        DarkCyan() byref as const FbColor
      declare static function _
        DarkGoldenrod() byref as const FbColor
      declare static function _
        DarkGray() byref as const FbColor
      declare static function _
        DarkGreen() byref as const FbColor
      declare static function _
        DarkKhaki() byref as const FbColor
      declare static function _
        DarkMagenta() byref as const FbColor
      declare static function _
        DarkOliveGreen() byref as const FbColor
      declare static function _
        DarkOrange() byref as const FbColor
      declare static function _
        DarkOrchid() byref as const FbColor
      declare static function _
        DarkRed() byref as const FbColor
      declare static function _
        DarkSalmon() byref as const FbColor
      declare static function _
        DarkSeaGreen() byref as const FbColor
      declare static function _
        DarkSlateBlue() byref as const FbColor
      declare static function _
        DarkSlateGray() byref as const FbColor
      declare static function _
        DarkTurquoise() byref as const FbColor
      declare static function _
        DarkViolet() byref as const FbColor
      declare static function _
        DeepPink() byref as const FbColor
      declare static function _
        DeepSkyBlue() byref as const FbColor
      declare static function _
        DimGray() byref as const FbColor
      declare static function _
        DodgerBlue() byref as const FbColor
      declare static function _
        Firebrick() byref as const FbColor
      declare static function _
        FloralWhite() byref as const FbColor
      declare static function _
        ForestGreen() byref as const FbColor
      declare static function _
        Fuchsia() byref as const FbColor
      declare static function _
        Gainsboro() byref as const FbColor
      declare static function _
        GhostWhite() byref as const FbColor
      declare static function _
        Gold() byref as const FbColor
      declare static function _
        Goldenrod() byref as const FbColor
      declare static function _
        Gray() byref as const FbColor
      declare static function _
        Green() byref as const FbColor
      declare static function _
        GreenYellow() byref as const FbColor
      declare static function _
        Honeydew() byref as const FbColor
      declare static function _
        HotPink() byref as const FbColor
      declare static function _
        IndianRed() byref as const FbColor
      declare static function _
        Indigo() byref as const FbColor
      declare static function _
        Ivory() byref as const FbColor
      declare static function _
        Khaki() byref as const FbColor
      declare static function _
        Lavender() byref as const FbColor
      declare static function _
        LavenderBlush() byref as const FbColor
      declare static function _
        LawnGreen() byref as const FbColor
      declare static function _
        LemonChiffon() byref as const FbColor
      declare static function _
        LightBlue() byref as const FbColor
      declare static function _
        LightCoral() byref as const FbColor
      declare static function _
        LightCyan() byref as const FbColor
      declare static function _
        LightGoldenrodYellow() byref as const FbColor
      declare static function _
        LightGray() byref as const FbColor
      declare static function _
        LightGreen() byref as const FbColor
      declare static function _
        LightPink() byref as const FbColor
      declare static function _
        LightSalmon() byref as const FbColor
      declare static function _
        LightSeaGreen() byref as const FbColor
      declare static function _
        LightSkyBlue() byref as const FbColor
      declare static function _
        LightSlateGray() byref as const FbColor
      declare static function _
        LightSteelBlue() byref as const FbColor
      declare static function _
        LightYellow() byref as const FbColor
      declare static function _
        Lime() byref as const FbColor
      declare static function _
        LimeGreen() byref as const FbColor
      declare static function _
        Linen() byref as const FbColor
      declare static function _
        Magenta() byref as const FbColor
      declare static function _
        Maroon() byref as const FbColor
      declare static function _
        MediumAquamarine() byref as const FbColor
      declare static function _
        MediumBlue() byref as const FbColor
      declare static function _
        MediumOrchid() byref as const FbColor
      declare static function _
        MediumPurple() byref as const FbColor
      declare static function _
        MediumSeaGreen() byref as const FbColor
      declare static function _
        MediumSlateBlue() byref as const FbColor
      declare static function _
        MediumSpringGreen() byref as const FbColor
      declare static function _
        MediumTurquoise() byref as const FbColor
      declare static function _
        MediumVioletRed() byref as const FbColor
      declare static function _
        MidnightBlue() byref as const FbColor
      declare static function _
        MintCream() byref as const FbColor
      declare static function _
        MistyRose() byref as const FbColor
      declare static function _
        Moccasin() byref as const FbColor
      declare static function _
        NavajoWhite() byref as const FbColor
      declare static function _
        Navy() byref as const FbColor
      declare static function _
        OldLace() byref as const FbColor
      declare static function _
        Olive() byref as const FbColor
      declare static function _
        OliveDrab() byref as const FbColor
      declare static function _
        Orange() byref as const FbColor
      declare static function _
        OrangeRed() byref as const FbColor
      declare static function _
        Orchid() byref as const FbColor
      declare static function _
        PaleGoldenrod() byref as const FbColor
      declare static function _
        PaleGreen() byref as const FbColor
      declare static function _
        PaleTurquoise() byref as const FbColor
      declare static function _
        PaleVioletRed() byref as const FbColor
      declare static function _
        PapayaWhip() byref as const FbColor
      declare static function _
        PeachPuff() byref as const FbColor
      declare static function _
        Peru() byref as const FbColor
      declare static function _
        Pink() byref as const FbColor
      declare static function _
        Plum() byref as const FbColor
      declare static function _
        PowderBlue() byref as const FbColor
      declare static function _
        Purple() byref as const FbColor
      declare static function _
        Red() byref as const FbColor
      declare static function _
        RosyBrown() byref as const FbColor
      declare static function _
        RoyalBlue() byref as const FbColor
      declare static function _
        SaddleBrown() byref as const FbColor
      declare static function _
        Salmon() byref as const FbColor
      declare static function _
        SandyBrown() byref as const FbColor
      declare static function _
        SeaGreen() byref as const FbColor
      declare static function _
        SeaShell() byref as const FbColor
      declare static function _
        Sienna() byref as const FbColor
      declare static function _
        Silver() byref as const FbColor
      declare static function _
        SkyBlue() byref as const FbColor
      declare static function _
        SlateBlue() byref as const FbColor
      declare static function _
        SlateGray() byref as const FbColor
      declare static function _
        Snow() byref as const FbColor
      declare static function _
        SpringGreen() byref as const FbColor
      declare static function _
        SteelBlue() byref as const FbColor
      declare static function _
        Tan() byref as const FbColor
      declare static function _
        Teal() byref as const FbColor
      declare static function _
        Thistle() byref as const FbColor
      declare static function _
        Tomato() byref as const FbColor
      declare static function _
        Transparent() byref as const FbColor
      declare static function _
        Turquoise() byref as const FbColor
      declare static function _
        Violet() byref as const FbColor
      declare static function _
        Wheat() byref as const FbColor
      declare static function _
        White() byref as const FbColor
      declare static function _
        WhiteSmoke() byref as const FbColor
      declare static function _
        Yellow() byref as const FbColor
      declare static function _
        YellowGreen() byref as const FbColor
      
    private:
      declare constructor()
      declare constructor( _
        byval as ubyte, _
        byval as ubyte, _
        byval as ubyte )
      declare constructor( _
        byval as ubyte, _
        byval as ubyte, _
        byval as ubyte, _
        byval as ubyte )
      declare constructor( _
        byval as ulong )
      
      declare static function _
        _saturate( _
          byref as _ccFloat ) _
        as _ccFloat
      declare static function _
        _cdot( _
          byref as _ccFloat, _
          byref as _ccFloat ) _
        as double
      declare static function _
        _hueToRGB( _
          byval as double ) _
        as _ccFloat
      declare static function _
        _HSVtoRGB( _
          byref as _ccFloat ) _
        as _ccFloat
      declare static function _
        _HSLtoRGB( _
          byref as _ccFloat ) _
        as _ccFloat
      declare static function _
        _HCYtoRGB( _
          byref as _ccFloat ) _
        as _ccFloat
      declare static function _
        _RGBtoHCV( _
          byref as _ccFloat ) _
        as _ccFloat
      declare static function _
        _RGBtoHSV( _
          byref as _ccFloat ) _
        as _ccFloat
      declare static function _
        _RGBtoHSL( _
          byref as _ccFloat ) _
        as _ccFloat
      declare static function _
        _RGBtoHCY( _
          byref as _ccFloat ) _
        as _ccFloat
      
      as ubyte _
        _B, _G, _R, _A
      
      static as _ccFloat _
        _HCYWeights
      static as double _
        _epsilon, _
        _phi, _
        _invPhi, _
        _cc1, _
        _cc2, _
        _cconv
      static as FbColor _
        _AliceBlue, _
        _AntiqueWhite, _
        _Aqua, _
        _Aquamarine, _
        _Azure, _
        _Beige, _
        _Bisque, _
        _Black, _
        _BlanchedAlmond, _
        _Blue, _
        _BlueViolet, _
        _Brown, _
        _BurlyWood, _
        _CadetBlue, _
        _Chartreuse, _
        _Chocolate, _
        _Coral, _
        _CornflowerBlue, _
        _Cornsilk, _
        _Crimson, _
        _Cyan, _
        _DarkBlue, _
        _DarkCyan, _
        _DarkGoldenrod, _
        _DarkGray, _
        _DarkGreen, _
        _DarkKhaki, _
        _DarkMagenta, _
        _DarkOliveGreen, _
        _DarkOrange, _
        _DarkOrchid, _
        _DarkRed, _
        _DarkSalmon, _
        _DarkSeaGreen, _
        _DarkSlateBlue, _
        _DarkSlateGray, _
        _DarkTurquoise, _
        _DarkViolet, _
        _DeepPink, _
        _DeepSkyBlue, _
        _DimGray, _
        _DodgerBlue, _
        _Firebrick, _
        _FloralWhite, _
        _ForestGreen, _
        _Fuchsia, _
        _Gainsboro, _
        _GhostWhite, _
        _Gold, _
        _Goldenrod, _
        _Gray, _
        _Green, _
        _GreenYellow, _
        _Honeydew, _
        _HotPink, _
        _IndianRed, _
        _Indigo, _
        _Ivory, _
        _Khaki, _
        _Lavender, _
        _LavenderBlush, _
        _LawnGreen, _
        _LemonChiffon, _
        _LightBlue, _
        _LightCoral, _
        _LightCyan, _
        _LightGoldenrodYellow, _
        _LightGray, _
        _LightGreen, _
        _LightPink, _
        _LightSalmon, _
        _LightSeaGreen, _
        _LightSkyBlue, _
        _LightSlateGray, _
        _LightSteelBlue, _
        _LightYellow, _
        _Lime, _
        _LimeGreen, _
        _Linen, _
        _Magenta, _
        _Maroon, _
        _MediumAquamarine, _
        _MediumBlue, _
        _MediumOrchid, _
        _MediumPurple, _
        _MediumSeaGreen, _
        _MediumSlateBlue, _
        _MediumSpringGreen, _
        _MediumTurquoise, _
        _MediumVioletRed, _
        _MidnightBlue, _
        _MintCream, _
        _MistyRose, _
        _Moccasin, _
        _NavajoWhite, _
        _Navy, _
        _OldLace, _
        _Olive, _
        _OliveDrab, _
        _Orange, _
        _OrangeRed, _
        _Orchid, _
        _PaleGoldenrod, _
        _PaleGreen, _
        _PaleTurquoise, _
        _PaleVioletRed, _
        _PapayaWhip, _
        _PeachPuff, _
        _Peru, _
        _Pink, _
        _Plum, _
        _PowderBlue, _
        _Purple, _
        _Red, _
        _RosyBrown, _
        _RoyalBlue, _
        _SaddleBrown, _
        _Salmon, _
        _SandyBrown, _
        _SeaGreen, _
        _SeaShell, _
        _Sienna, _
        _Silver, _
        _SkyBlue, _
        _SlateBlue, _
        _SlateGray, _
        _Snow, _
        _SpringGreen, _
        _SteelBlue, _
        _Tan, _
        _Teal, _
        _Thistle, _
        _Tomato, _
        _Transparent, _
        _Turquoise, _
        _Violet, _
        _Wheat, _
        _White, _
        _WhiteSmoke, _
        _Yellow, _
        _YellowGreen
  end type
  
  dim as _ccFloat _
    FbColor._HCYWeights => type <_ccFloat>( _
      0.299, 0.587, 0.114 )
  dim as double _
    FbColor._epsilon => 1e-10, _
    FbColor._phi => ( 1.0 + sqr( 5.0 ) ) / 2.0, _
    FbColor._invPhi => 1.0 / ( ( 1.0 + sqr( 5.0 ) ) / 2.0 ), _
    FbColor._cc1 => 2.0 / 3.0, _
    FbColor._cc2 => -1.0 / 3.0, _
    FbColor._cconv => 1.0 / 255
  dim as FbColor _
    FbColor._AliceBlue => FbColor.fromRGBA( 240, 248, 255, 255 ), _
    FbColor._AntiqueWhite => FbColor.fromRGBA( 250, 235, 215, 255 ), _
    FbColor._Aqua => FbColor.fromRGBA( 0, 255, 255, 255 ), _
    FbColor._Aquamarine => FbColor.fromRGBA( 127, 255, 212, 255 ), _
    FbColor._Azure => FbColor.fromRGBA( 240, 255, 255, 255 ), _
    FbColor._Beige => FbColor.fromRGBA( 245, 245, 220, 255 ), _
    FbColor._Bisque => FbColor.fromRGBA( 255, 228, 196, 255 ), _
    FbColor._Black => FbColor.fromRGBA( 0, 0, 0, 255 ), _
    FbColor._BlanchedAlmond => FbColor.fromRGBA( 255, 235, 205, 255 ), _
    FbColor._Blue => FbColor.fromRGBA( 0, 0, 255, 255 ), _
    FbColor._BlueViolet => FbColor.fromRGBA( 138, 43, 226, 255 ), _
    FbColor._Brown => FbColor.fromRGBA( 165, 42, 42, 255 ), _
    FbColor._BurlyWood => FbColor.fromRGBA( 222, 184, 135, 255 ), _
    FbColor._CadetBlue => FbColor.fromRGBA( 95, 158, 160, 255 ), _
    FbColor._Chartreuse => FbColor.fromRGBA( 127, 255, 0, 255 ), _
    FbColor._Chocolate => FbColor.fromRGBA( 210, 105, 30, 255 ), _
    FbColor._Coral => FbColor.fromRGBA( 255, 127, 80, 255 ), _
    FbColor._CornflowerBlue => FbColor.fromRGBA( 100, 149, 237, 255 ), _
    FbColor._Cornsilk => FbColor.fromRGBA( 255, 248, 220, 255 ), _
    FbColor._Crimson => FbColor.fromRGBA( 220, 20, 60, 255 ), _
    FbColor._Cyan => FbColor.fromRGBA( 0, 255, 255, 255 ), _
    FbColor._DarkBlue => FbColor.fromRGBA( 0, 0, 139, 255 ), _
    FbColor._DarkCyan => FbColor.fromRGBA( 0, 139, 139, 255 ), _
    FbColor._DarkGoldenrod => FbColor.fromRGBA( 184, 134, 11, 255 ), _
    FbColor._DarkGray => FbColor.fromRGBA( 169, 169, 169, 255 ), _
    FbColor._DarkGreen => FbColor.fromRGBA( 0, 100, 0, 255 ), _
    FbColor._DarkKhaki => FbColor.fromRGBA( 189, 183, 107, 255 ), _
    FbColor._DarkMagenta => FbColor.fromRGBA( 139, 0, 139, 255 ), _
    FbColor._DarkOliveGreen => FbColor.fromRGBA( 85, 107, 47, 255 ), _
    FbColor._DarkOrange => FbColor.fromRGBA( 255, 140, 0, 255 ), _
    FbColor._DarkOrchid => FbColor.fromRGBA( 153, 50, 204, 255 ), _
    FbColor._DarkRed => FbColor.fromRGBA( 139, 0, 0, 255 ), _
    FbColor._DarkSalmon => FbColor.fromRGBA( 233, 150, 122, 255 ), _
    FbColor._DarkSeaGreen => FbColor.fromRGBA( 143, 188, 139, 255 ), _
    FbColor._DarkSlateBlue => FbColor.fromRGBA( 72, 61, 139, 255 ), _
    FbColor._DarkSlateGray => FbColor.fromRGBA( 47, 79, 79, 255 ), _
    FbColor._DarkTurquoise => FbColor.fromRGBA( 0, 206, 209, 255 ), _
    FbColor._DarkViolet => FbColor.fromRGBA( 148, 0, 211, 255 ), _
    FbColor._DeepPink => FbColor.fromRGBA( 255, 20, 147, 255 ), _
    FbColor._DeepSkyBlue => FbColor.fromRGBA( 0, 191, 255, 255 ), _
    FbColor._DimGray => FbColor.fromRGBA( 105, 105, 105, 255 ), _
    FbColor._DodgerBlue => FbColor.fromRGBA( 30, 144, 255, 255 ), _
    FbColor._Firebrick => FbColor.fromRGBA( 178, 34, 34, 255 ), _
    FbColor._FloralWhite => FbColor.fromRGBA( 255, 250, 240, 255 ), _
    FbColor._ForestGreen => FbColor.fromRGBA( 34, 139, 34, 255 ), _
    FbColor._Fuchsia => FbColor.fromRGBA( 255, 0, 255, 255 ), _
    FbColor._Gainsboro => FbColor.fromRGBA( 220, 220, 220, 255 ), _
    FbColor._GhostWhite => FbColor.fromRGBA( 248, 248, 255, 255 ), _
    FbColor._Gold => FbColor.fromRGBA( 255, 215, 0, 255 ), _
    FbColor._Goldenrod => FbColor.fromRGBA( 218, 165, 32, 255 ), _
    FbColor._Gray => FbColor.fromRGBA( 128, 128, 128, 255 ), _
    FbColor._Green => FbColor.fromRGBA( 0, 128, 0, 255 ), _
    FbColor._GreenYellow => FbColor.fromRGBA( 173, 255, 47, 255 ), _
    FbColor._Honeydew => FbColor.fromRGBA( 240, 255, 240, 255 ), _
    FbColor._HotPink => FbColor.fromRGBA( 255, 105, 180, 255 ), _
    FbColor._IndianRed => FbColor.fromRGBA( 205, 92, 92, 255 ), _
    FbColor._Indigo => FbColor.fromRGBA( 75, 0, 130, 255 ), _
    FbColor._Ivory => FbColor.fromRGBA( 255, 255, 240, 255 ), _
    FbColor._Khaki => FbColor.fromRGBA( 240, 230, 140, 255 ), _
    FbColor._Lavender => FbColor.fromRGBA( 230, 230, 250, 255 ), _
    FbColor._LavenderBlush => FbColor.fromRGBA( 255, 240, 245, 255 ), _
    FbColor._LawnGreen => FbColor.fromRGBA( 124, 252, 0, 255 ), _
    FbColor._LemonChiffon => FbColor.fromRGBA( 255, 250, 205, 255 ), _
    FbColor._LightBlue => FbColor.fromRGBA( 173, 216, 230, 255 ), _
    FbColor._LightCoral => FbColor.fromRGBA( 240, 128, 128, 255 ), _
    FbColor._LightCyan => FbColor.fromRGBA( 224, 255, 255, 255 ), _
    FbColor._LightGoldenrodYellow => FbColor.fromRGBA( 250, 250, 210, 255 ), _
    FbColor._LightGray => FbColor.fromRGBA( 211, 211, 211, 255 ), _
    FbColor._LightGreen => FbColor.fromRGBA( 144, 238, 144, 255 ), _
    FbColor._LightPink => FbColor.fromRGBA( 255, 182, 193, 255 ), _
    FbColor._LightSalmon => FbColor.fromRGBA( 255, 160, 122, 255 ), _
    FbColor._LightSeaGreen => FbColor.fromRGBA( 32, 178, 170, 255 ), _
    FbColor._LightSkyBlue => FbColor.fromRGBA( 135, 206, 250, 255 ), _
    FbColor._LightSlateGray => FbColor.fromRGBA( 119, 136, 153, 255 ), _
    FbColor._LightSteelBlue => FbColor.fromRGBA( 176, 196, 222, 255 ), _
    FbColor._LightYellow => FbColor.fromRGBA( 255, 255, 224, 255 ), _
    FbColor._Lime => FbColor.fromRGBA( 0, 255, 0, 255 ), _
    FbColor._LimeGreen => FbColor.fromRGBA( 50, 205, 50, 255 ), _
    FbColor._Linen => FbColor.fromRGBA( 250, 240, 230, 255 ), _
    FbColor._Magenta => FbColor.fromRGBA( 255, 0, 255, 255 ), _
    FbColor._Maroon => FbColor.fromRGBA( 128, 0, 0, 255 ), _
    FbColor._MediumAquamarine => FbColor.fromRGBA( 102, 205, 170, 255 ), _
    FbColor._MediumBlue => FbColor.fromRGBA( 0, 0, 205, 255 ), _
    FbColor._MediumOrchid => FbColor.fromRGBA( 186, 85, 211, 255 ), _
    FbColor._MediumPurple => FbColor.fromRGBA( 147, 112, 219, 255 ), _
    FbColor._MediumSeaGreen => FbColor.fromRGBA( 60, 179, 113, 255 ), _
    FbColor._MediumSlateBlue => FbColor.fromRGBA( 123, 104, 238, 255 ), _
    FbColor._MediumSpringGreen => FbColor.fromRGBA( 0, 250, 154, 255 ), _
    FbColor._MediumTurquoise => FbColor.fromRGBA( 72, 209, 204, 255 ), _
    FbColor._MediumVioletRed => FbColor.fromRGBA( 199, 21, 133, 255 ), _
    FbColor._MidnightBlue => FbColor.fromRGBA( 25, 25, 112, 255 ), _
    FbColor._MintCream => FbColor.fromRGBA( 245, 255, 250, 255 ), _
    FbColor._MistyRose => FbColor.fromRGBA( 255, 228, 225, 255 ), _
    FbColor._Moccasin => FbColor.fromRGBA( 255, 228, 181, 255 ), _
    FbColor._NavajoWhite => FbColor.fromRGBA( 255, 222, 173, 255 ), _
    FbColor._Navy => FbColor.fromRGBA( 0, 0, 128, 255 ), _
    FbColor._OldLace => FbColor.fromRGBA( 253, 245, 230, 255 ), _
    FbColor._Olive => FbColor.fromRGBA( 128, 128, 0, 255 ), _
    FbColor._OliveDrab => FbColor.fromRGBA( 107, 142, 35, 255 ), _
    FbColor._Orange => FbColor.fromRGBA( 255, 165, 0, 255 ), _
    FbColor._OrangeRed => FbColor.fromRGBA( 255, 69, 0, 255 ), _
    FbColor._Orchid => FbColor.fromRGBA( 218, 112, 214, 255 ), _
    FbColor._PaleGoldenrod => FbColor.fromRGBA( 238, 232, 170, 255 ), _
    FbColor._PaleGreen => FbColor.fromRGBA( 152, 251, 152, 255 ), _
    FbColor._PaleTurquoise => FbColor.fromRGBA( 175, 238, 238, 255 ), _
    FbColor._PaleVioletRed => FbColor.fromRGBA( 219, 112, 147, 255 ), _
    FbColor._PapayaWhip => FbColor.fromRGBA( 255, 239, 213, 255 ), _
    FbColor._PeachPuff => FbColor.fromRGBA( 255, 218, 185, 255 ), _
    FbColor._Peru => FbColor.fromRGBA( 205, 133, 63, 255 ), _
    FbColor._Pink => FbColor.fromRGBA( 255, 192, 203, 255 ), _
    FbColor._Plum => FbColor.fromRGBA( 221, 160, 221, 255 ), _
    FbColor._PowderBlue => FbColor.fromRGBA( 176, 224, 230, 255 ), _
    FbColor._Purple => FbColor.fromRGBA( 128, 0, 128, 255 ), _
    FbColor._Red => FbColor.fromRGBA( 255, 0, 0, 255 ), _
    FbColor._RosyBrown => FbColor.fromRGBA( 188, 143, 143, 255 ), _
    FbColor._RoyalBlue => FbColor.fromRGBA( 65, 105, 225, 255 ), _
    FbColor._SaddleBrown => FbColor.fromRGBA( 139, 69, 19, 255 ), _
    FbColor._Salmon => FbColor.fromRGBA( 250, 128, 114, 255 ), _
    FbColor._SandyBrown => FbColor.fromRGBA( 244, 164, 96, 255 ), _
    FbColor._SeaGreen => FbColor.fromRGBA( 46, 139, 87, 255 ), _
    FbColor._SeaShell => FbColor.fromRGBA( 255, 245, 238, 255 ), _
    FbColor._Sienna => FbColor.fromRGBA( 160, 82, 45, 255 ), _
    FbColor._Silver => FbColor.fromRGBA( 192, 192, 192, 255 ), _
    FbColor._SkyBlue => FbColor.fromRGBA( 135, 206, 235, 255 ), _
    FbColor._SlateBlue => FbColor.fromRGBA( 106, 90, 205, 255 ), _
    FbColor._SlateGray => FbColor.fromRGBA( 112, 128, 144, 255 ), _
    FbColor._Snow => FbColor.fromRGBA( 255, 250, 250, 255 ), _
    FbColor._SpringGreen => FbColor.fromRGBA( 0, 255, 127, 255 ), _
    FbColor._SteelBlue => FbColor.fromRGBA( 70, 130, 180, 255 ), _
    FbColor._Tan => FbColor.fromRGBA( 210, 180, 140, 255 ), _
    FbColor._Teal => FbColor.fromRGBA( 0, 128, 128, 255 ), _
    FbColor._Thistle => FbColor.fromRGBA( 216, 191, 216, 255 ), _
    FbColor._Tomato => FbColor.fromRGBA( 255, 99, 71, 255 ), _
    FbColor._Transparent => FbColor.fromRGBA( 0, 0, 0, 0 ), _
    FbColor._Turquoise => FbColor.fromRGBA( 64, 224, 208, 255 ), _
    FbColor._Violet => FbColor.fromRGBA( 238, 130, 238, 255 ), _
    FbColor._Wheat => FbColor.fromRGBA( 245, 222, 179, 255 ), _
    FbColor._White => FbColor.fromRGBA( 255, 255, 255, 255 ), _
    FbColor._WhiteSmoke => FbColor.fromRGBA( 245, 245, 245, 255 ), _
    FbColor._Yellow => FbColor.fromRGBA( 255, 255, 0, 255 ), _
    FbColor._YellowGreen => FbColor.fromRGBA( 154, 205, 50, 255 )
  
  #macro __clerp__( c, am )
    FbColor( _
      ( c.R - _R ) * am + _R, _
      ( c.G - _G ) * am + _G, _
      ( c.B - _B ) * am + _B, _
      ( c.A - _A ) * am + _A )
  #endmacro
  
  #macro __clerp_c__( c, am )
    FbColor( _
      ( c.R - _R ) * am + _R, _
      ( c.G - _G ) * am + _G, _
      ( c.B - _B ) * am + _B, _
      _A )
  #endmacro
  
  constructor _
    FbColor()
  end constructor
  
  constructor _
    FbColor( _
      byref rhs as const FbColor )
    
    _R => rhs._R
    _G => rhs._G
    _B => rhs._B
    _A => rhs._A
  end constructor
  
  constructor _
    FbColor( _
      byval aR as ubyte, _
      byval aG as ubyte, _
      byval aB as ubyte, _
      byval aA as ubyte => 255 )
    
    _R => aR
    _G => aG
    _B => aB
    _A => aA
  end constructor
  
  constructor _
    FbColor( _
      byval aColor as ulong )
    
    _B => cast( ubyte ptr, @aColor )[ 0 ]
    _G => cast( ubyte ptr, @aColor )[ 1 ]
    _R => cast( ubyte ptr, @aColor )[ 2 ]
    _A => cast( ubyte ptr, @aColor )[ 3 ]
  end constructor
  
  destructor _
    FbColor()
  end destructor
  
  operator _
    FbColor.cast() _
    as ulong
    
    return( *cast( ulong ptr, @_B ) )
  end operator
  
  function _
    FbColor._cdot( _
      byref v as _ccFloat, _
      byref w as _ccFloat ) _
    as double
    
  	return( _
  	  v.x * w.x + v.y * w.y + v.z * w.z )
  end function
  
  function _
    FbColor._saturate( _
      byref c as _ccFloat ) _
    as _ccFloat
    
    return( type <_ccFloat>( _
      iif( c.x < 0.0, 0.0, iif( c.x > 1.0, 1.0, c.x ) ), _
      iif( c.y < 0.0, 0.0, iif( c.y > 1.0, 1.0, c.y ) ), _
      iif( c.z < 0.0, 0.0, iif( c.z > 1.0, 1.0, c.z ) ), _
      1.0 ) )
  end function
  
  function _
    FbColor._hueToRGB( _
      byval h as double ) _
    as _ccFloat
    
    return( _
      _saturate( type <_ccFloat>( _
        abs( h * 6.0 - 3.0 ) - 1.0, _
        2.0 - abs( h * 6.0 - 2.0 ), _
        2.0 - abs( h * 6.0 - 4.0 ), _
        1.0 ) ) )
  end function
  
  function _
    FbColor._HSVtoRGB( _
      byref aHSV as _ccFloat ) _
    as _ccFloat
    
    var _
      aRGB => _hueToRGB( aHSV.x )
    
    return( type <_ccFloat>( _
      ( ( aRGB.x - 1.0 ) * aHSV.y + 1.0 ) * aHSV.z, _
      ( ( aRGB.y - 1.0 ) * aHSV.y + 1.0 ) * aHSV.z, _
      ( ( aRGB.z - 1.0 ) * aHSV.y + 1.0 ) * aHSV.z, _
      1.0 ) )
  end function
  
  function _
    FbColor._HSLtoRGB( _
      byref aHSL as _ccFloat ) _
    as _ccFloat
    
    var _
      aRGB => _hueToRGB( aHSL.x )
    dim as double _
      C => ( 1.0 - abs( 2.0 * aHSL.z - 1.0 ) ) * aHSL.y
    
    return( type <_ccFloat>( _
      ( aRGB.x - 0.5 ) * C + aHSL.z, _
      ( aRGB.y - 0.5 ) * C + aHSL.z, _
      ( aRGB.z - 0.5 ) * C + aHSL.z, _
      1.0 ) )
  end function
  
  function _
    FbColor._HCYtoRGB( _
      byref aHCY as _ccFloat ) _
    as _ccFloat
    
    var _
      aRGB => _hueToRGB( aHCY.x )
    
    dim as double _
      Z => _cdot( aRGB, _HCYWeights )
    
    if( aHCY.z < Z ) then
      aHCY.y *=> aHCY.z / Z
    elseif( _
      z < 1.0 ) then
      aHCY.y *=> ( 1.0 - aHCY.z ) / ( 1.0 - Z )
    end if
    
    return( type <_ccFloat>( _
      ( aRGB.x - Z ) * aHCY.Y + aHCY.z, _
      ( aRGB.y - Z ) * aHCY.Y + aHCY.z, _
      ( aRGB.z - Z ) * aHCY.Y + aHCY.z, _
      1.0 ) )
  end function
  
  function _
    FbColor._RGBtoHCV( _
      byref aRGB as _ccFloat ) _
    as _ccFloat
    
    var _
      P => iif( aRGB.y < aRGB.z, _
        type <_ccFloat>( aRGB.z, aRGB.y, -1.0, _cc1 ), _
        type <_ccFloat>( aRGB.y, aRGB.z, 0.0, _cc2 ) ), _
      Q => iif( aRGB.x < P.x, _
        type <_ccFloat>( P.x, P.y, P.w, aRGB.x ), _
        type <_ccFloat>( aRGB.x, P.y, P.z, P.x ) )
      
    dim as double _
      C => Q.x - iif( Q.w < Q.y, Q.w, Q.y ), _
      H => abs( ( Q.w - Q.y ) / ( 6.0 * C + _epsilon ) + Q.z )
    
    return( type <_ccFloat>( H, C, Q.x ) )
  end function
  
  function _
    FbColor._RGBtoHSV( _
      byref aRGB as _ccFloat ) _
    as _ccFloat
    
    var _
      aHCV => _RGBtoHCV( aRGB )
    dim as double _
      S => aHCV.y / ( aHCV.z + _epsilon )
    
    return( type <_ccFloat>( _
      aHCV.x, S, aHCV.z, 1.0 ) )
  end function
  
  function _
    FbColor._RGBtoHSL( _
      byref aRGB as _ccFloat ) _
    as _ccFloat
    
    var _
      aHCV => _RGBtoHCV( aRGB )
    dim as double _
      L => aHCV.z - aHCV.y * 0.5, _
      S => aHCV.y / ( 1.0 - abs( L * 2.0 - 1.0 ) + _epsilon )
    
    return( type <_ccFloat>( aHCV.x, S, L ) )
  end function  
  
  function _
    FbColor._RGBtoHCY( _
      byref aRGB as _ccFloat ) _
    as _ccFloat
    
    var _
      aHCV => _RGBtoHCV( aRGB )
    
    dim as double _
      Y => _cdot( aRGB, _HCYWeights ), _
      Z => _cdot( _HueToRGB( aHCV.x ), _HCYWeights )
    
    if( Y < Z ) then
      aHCV.y *=> Z / ( _epsilon + Y )
    else
      aHCV.y *=> ( 1.0 - Z ) / ( _epsilon + 1 - Y )
    end if
    
  'float3 HCV = RGBtoHCV(RGB);
  '  float Y = dot(RGB, HCYwts);
  '  float Z = dot(HUEtoRGB(HCV.x), HCYwts);
  '  if (Y < Z)
  '  {
  '    HCV.y *= Z / (Epsilon + Y);
  '  }
  '  else
  '  {
  '    HCV.y *= (1 - Z) / (Epsilon + 1 - Y);
  '  }
  '  return float3(HCV.x, HCV.y, Y);    
    return( type<_ccFloat>( aHCV.x, aHCV.y, Y ) )
  end function
  
  function _
    FbColor.fromColor( _
      byval aColor as ulong ) _
    as FbColor
    
    return( FbColor( aColor ) )
  end function
  
  function _
    FbColor.fromRGBA( _
      byval aR as ubyte, _
      byval aG as ubyte, _
      byval aB as ubyte, _
      byval aA as ubyte ) _
    as FbColor
    
    return( FbColor( _
      aR, aG, aB, aA ) )
  end function
  
  function _
    FbColor.fromHSV( _
      byval aH as ubyte, _
      byval aaS as ubyte, _
      byval aV as ubyte, _
      byval aA as ubyte ) _
    as FbColor
    
    var _
      c => _HSVtoRGB( type <_ccFloat>( _
        aH * _cconv, _
        aaS * _cconv, _
        aV * _cconv, _
        1.0 ) )
        
    return( FbColor( _
      c.x * 255, _
      c.y * 255, _
      c.z * 255, _
      aA ) )
  end function
  
  function _
    FbColor.fromHSV( _
      byref aHSV as HSVAColor ) _
    as FbColor
    
    var _
      c => _HSVtoRGB( type <_ccFloat>( _
        aHSV.H * _cconv, _
        aHSV.S * _cconv, _
        aHSV.V * _cconv, _
        1.0 ) )
        
    return( FbColor( _
      c.x * 255, _
      c.y * 255, _
      c.z * 255, _
      aHSV.A ) )
  end function
  
  function _
    FbColor.fromHSL( _
      byval aH as ubyte, _
      byval aaS as ubyte, _
      byval aL as ubyte, _
      byval aA as ubyte ) _
    as FbColor
    
    var _
      c => _HSLtoRGB( type <_ccFloat>( _
        aH * _cconv, _
        aaS * _cconv, _
        aL * _cconv, _
        1.0 ) )
      
    return( FbColor( _
      c.x * 255, _
      c.y * 255, _
      c.z * 255, _
      aA ) )
  end function
  
  function _
    FbColor.fromHSL( _
      byref aHSL as HSLAColor ) _
    as FbColor
    
    var _
      c => _HSLtoRGB( type <_ccFloat>( _
        aHSL.H * _cconv, _
        aHSL.S * _cconv, _
        aHSL.L * _cconv, _
        1.0 ) )
      
    return( FbColor( _
      c.x * 255, _
      c.y * 255, _
      c.z * 255, _
      aHSL.A ) )
  end function
  
  function _
    FbColor.fromHCY( _
      byval aH as ubyte, _
      byval aC as ubyte, _
      byval aY as ubyte, _
      byval aA as ubyte ) _
    as FbColor
    
    var _
      c => _HCYtoRGB( type <_ccFloat>( _
        aH * _cconv, _
        aC * _cconv, _
        aY * _cconv, _
        1.0 ) )
      
    return( FbColor( _
      c.x * 255, _
      c.y * 255, _
      c.z * 255, _
      aA ) )
  end function
  
  function _
    FbColor.fromHCY( _
      byref aHCY as HCYAColor ) _
    as FbColor
    
    var _
      c => _HCYtoRGB( type <_ccFloat>( _
        aHCY.H * _cconv, _
        aHCY.C * _cconv, _
        aHCY.Y * _cconv, _
        1.0 ) )
      
    return( FbColor( _
      c.x * 255, _
      c.y * 255, _
      c.z * 255, _
      aHCY.A ) )
  end function
  
  function _
    FbColor.toHSV() _
    as HSVAColor
    
    var _
      c => _RGBtoHSV( type <_ccFloat>( _
        R * _cconv, _
        G * _cconv, _
        B * _cconv, _
        1.0 ) )
      
    return( HSVAColor( _
      c.x * 255, _
      c.y * 255, _
      c.z * 255, _
      A ) )
  end function
  
  function _
    FbColor.toHSL() _
    as HSLAColor
    
    var _
      c => _RGBtoHSL( type <_ccFloat>( _
        R * _cconv, _
        G * _cconv, _
        B * _cconv, _
        1.0 ) )
      
    return( HSLAColor( _
      c.x * 255, _
      c.y * 255, _
      c.z * 255, _
      A ) )
  end function
  
  function _
    FbColor.toHCY() _
    as HCYAColor
    
    var _
      c => _RGBtoHCY( type <_ccFloat>( _
        R * _cconv, _
        G * _cconv, _
        B * _cconv, _
        1.0 ) )
      
    return( HCYAColor( _
      c.x * 255, _
      c.y * 255, _
      c.z * 255, _
      A ) )
  end function
  
  property _
    FbColor.R() _
    as ubyte
    
    return( _R )
  end property
  
  property _
    FbColor.G() _
    as ubyte
    
    return( _G )
  end property
  
  property _
    FbColor.B() _
    as ubyte
    
    return( _B )
  end property
  
  property _
    FbColor.A() _
    as ubyte
    
    return( _A )
  end property
  
  function _
    FbColor.mix( _
      byref another as FbColor, _
      byval amount as double ) _
    as FbColor
    
    return( __clerp__( another, amount ) )
  end function
  
  function _
    FbColor.mixColor( _
      byref another as const FbColor, _
      byval amount as double ) _
    as FbColor
    
    return( __clerp_c__( another, amount ) )
  end function
  
  function _
    FbColor.mixAlpha( _
      byval another as ubyte, _
      byval amount as double ) _
    as FbColor
    
    return( FbColor( _
      _R, _G, _B, _
      ( another - _A ) * amount + _A ) )
  end function
  
  function _
    FbColor.AliceBlue() byref as const FbColor : return( _AliceBlue ) : end function
  function _
    FbColor.AntiqueWhite() byref as const FbColor : return( _AntiqueWhite ) : end function
  function _
    FbColor.Aqua() byref as const FbColor : return( _Aqua ) : end function
  function _
    FbColor.Aquamarine() byref as const FbColor : return( _Aquamarine ) : end function
  function _
    FbColor.Azure() byref as const FbColor : return( _Azure ) : end function
  function _
    FbColor.Beige() byref as const FbColor : return( _Beige ) : end function
  function _
    FbColor.Bisque() byref as const FbColor : return( _Bisque ) : end function
  function _
    FbColor.Black() byref as const FbColor : return( _Black ) : end function
  function _
    FbColor.BlanchedAlmond() byref as const FbColor : return( _BlanchedAlmond ) : end function
  function _
    FbColor.Blue() byref as const FbColor : return( _Blue ) : end function
  function _
    FbColor.BlueViolet() byref as const FbColor : return( _BlueViolet ) : end function
  function _
    FbColor.Brown() byref as const FbColor : return( _Brown ) : end function
  function _
    FbColor.BurlyWood() byref as const FbColor : return( _BurlyWood ) : end function
  function _
    FbColor.CadetBlue() byref as const FbColor : return( _CadetBlue ) : end function
  function _
    FbColor.Chartreuse() byref as const FbColor : return( _Chartreuse ) : end function
  function _
    FbColor.Chocolate() byref as const FbColor : return( _Chocolate ) : end function
  function _
    FbColor.Coral() byref as const FbColor : return( _Coral ) : end function
  function _
    FbColor.CornflowerBlue() byref as const FbColor : return( _CornflowerBlue ) : end function
  function _
    FbColor.Cornsilk() byref as const FbColor : return( _Cornsilk ) : end function
  function _
    FbColor.Crimson() byref as const FbColor : return( _Crimson ) : end function
  function _
    FbColor.Cyan() byref as const FbColor : return( _Cyan ) : end function
  function _
    FbColor.DarkBlue() byref as const FbColor : return( _DarkBlue ) : end function
  function _
    FbColor.DarkCyan() byref as const FbColor : return( _DarkCyan ) : end function
  function _
    FbColor.DarkGoldenrod() byref as const FbColor : return( _DarkGoldenrod ) : end function
  function _
    FbColor.DarkGray() byref as const FbColor : return( _DarkGray ) : end function
  function _
    FbColor.DarkGreen() byref as const FbColor : return( _DarkGreen ) : end function
  function _
    FbColor.DarkKhaki() byref as const FbColor : return( _DarkKhaki ) : end function
  function _
    FbColor.DarkMagenta() byref as const FbColor : return( _DarkMagenta ) : end function
  function _
    FbColor.DarkOliveGreen() byref as const FbColor : return( _DarkOliveGreen ) : end function
  function _
    FbColor.DarkOrange() byref as const FbColor : return( _DarkOrange ) : end function
  function _
    FbColor.DarkOrchid() byref as const FbColor : return( _DarkOrchid ) : end function
  function _
    FbColor.DarkRed() byref as const FbColor : return( _DarkRed ) : end function
  function _
    FbColor.DarkSalmon() byref as const FbColor : return( _DarkSalmon ) : end function
  function _
    FbColor.DarkSeaGreen() byref as const FbColor : return( _DarkSeaGreen ) : end function
  function _
    FbColor.DarkSlateBlue() byref as const FbColor : return( _DarkSlateBlue ) : end function
  function _
    FbColor.DarkSlateGray() byref as const FbColor : return( _DarkSlateGray ) : end function
  function _
    FbColor.DarkTurquoise() byref as const FbColor : return( _DarkTurquoise ) : end function
  function _
    FbColor.DarkViolet() byref as const FbColor : return( _DarkViolet ) : end function
  function _
    FbColor.DeepPink() byref as const FbColor : return( _DeepPink ) : end function
  function _
    FbColor.DeepSkyBlue() byref as const FbColor : return( _DeepSkyBlue ) : end function
  function _
    FbColor.DimGray() byref as const FbColor : return( _DimGray ) : end function
  function _
    FbColor.DodgerBlue() byref as const FbColor : return( _DodgerBlue ) : end function
  function _
    FbColor.Firebrick() byref as const FbColor : return( _Firebrick ) : end function
  function _
    FbColor.FloralWhite() byref as const FbColor : return( _FloralWhite ) : end function
  function _
    FbColor.ForestGreen() byref as const FbColor : return( _ForestGreen ) : end function
  function _
    FbColor.Fuchsia() byref as const FbColor : return( _Fuchsia ) : end function
  function _
    FbColor.Gainsboro() byref as const FbColor : return( _Gainsboro ) : end function
  function _
    FbColor.GhostWhite() byref as const FbColor : return( _GhostWhite ) : end function
  function _
    FbColor.Gold() byref as const FbColor : return( _Gold ) : end function
  function _
    FbColor.Goldenrod() byref as const FbColor : return( _Goldenrod ) : end function
  function _
    FbColor.Gray() byref as const FbColor : return( _Gray ) : end function
  function _
    FbColor.Green() byref as const FbColor : return( _Green ) : end function
  function _
    FbColor.GreenYellow() byref as const FbColor : return( _GreenYellow ) : end function
  function _
    FbColor.Honeydew() byref as const FbColor : return( _Honeydew ) : end function
  function _
    FbColor.HotPink() byref as const FbColor : return( _HotPink ) : end function
  function _
    FbColor.IndianRed() byref as const FbColor : return( _IndianRed ) : end function
  function _
    FbColor.Indigo() byref as const FbColor : return( _Indigo ) : end function
  function _
    FbColor.Ivory() byref as const FbColor : return( _Ivory ) : end function
  function _
    FbColor.Khaki() byref as const FbColor : return( _Khaki ) : end function
  function _
    FbColor.Lavender() byref as const FbColor : return( _Lavender ) : end function
  function _
    FbColor.LavenderBlush() byref as const FbColor : return( _LavenderBlush ) : end function
  function _
    FbColor.LawnGreen() byref as const FbColor : return( _LawnGreen ) : end function
  function _
    FbColor.LemonChiffon() byref as const FbColor : return( _LemonChiffon ) : end function
  function _
    FbColor.LightBlue() byref as const FbColor : return( _LightBlue ) : end function
  function _
    FbColor.LightCoral() byref as const FbColor : return( _LightCoral ) : end function
  function _
    FbColor.LightCyan() byref as const FbColor : return( _LightCyan ) : end function
  function _
    FbColor.LightGoldenrodYellow() byref as const FbColor : return( _LightGoldenrodYellow ) : end function
  function _
    FbColor.LightGray() byref as const FbColor : return( _LightGray ) : end function
  function _
    FbColor.LightGreen() byref as const FbColor : return( _LightGreen ) : end function
  function _
    FbColor.LightPink() byref as const FbColor : return( _LightPink ) : end function
  function _
    FbColor.LightSalmon() byref as const FbColor : return( _LightSalmon ) : end function
  function _
    FbColor.LightSeaGreen() byref as const FbColor : return( _LightSeaGreen ) : end function
  function _
    FbColor.LightSkyBlue() byref as const FbColor : return( _LightSkyBlue ) : end function
  function _
    FbColor.LightSlateGray() byref as const FbColor : return( _LightSlateGray ) : end function
  function _
    FbColor.LightSteelBlue() byref as const FbColor : return( _LightSteelBlue ) : end function
  function _
    FbColor.LightYellow() byref as const FbColor : return( _LightYellow ) : end function
  function _
    FbColor.Lime() byref as const FbColor : return( _Lime ) : end function
  function _
    FbColor.LimeGreen() byref as const FbColor : return( _LimeGreen ) : end function
  function _
    FbColor.Linen() byref as const FbColor : return( _Linen ) : end function
  function _
    FbColor.Magenta() byref as const FbColor : return( _Magenta ) : end function
  function _
    FbColor.Maroon() byref as const FbColor : return( _Maroon ) : end function
  function _
    FbColor.MediumAquamarine() byref as const FbColor : return( _MediumAquamarine ) : end function
  function _
    FbColor.MediumBlue() byref as const FbColor : return( _MediumBlue ) : end function
  function _
    FbColor.MediumOrchid() byref as const FbColor : return( _MediumOrchid ) : end function
  function _
    FbColor.MediumPurple() byref as const FbColor : return( _MediumPurple ) : end function
  function _
    FbColor.MediumSeaGreen() byref as const FbColor : return( _MediumSeaGreen ) : end function
  function _
    FbColor.MediumSlateBlue() byref as const FbColor : return( _MediumSlateBlue ) : end function
  function _
    FbColor.MediumSpringGreen() byref as const FbColor : return( _MediumSpringGreen ) : end function
  function _
    FbColor.MediumTurquoise() byref as const FbColor : return( _MediumTurquoise ) : end function
  function _
    FbColor.MediumVioletRed() byref as const FbColor : return( _MediumVioletRed ) : end function
  function _
    FbColor.MidnightBlue() byref as const FbColor : return( _MidnightBlue ) : end function
  function _
    FbColor.MintCream() byref as const FbColor : return( _MintCream ) : end function
  function _
    FbColor.MistyRose() byref as const FbColor : return( _MistyRose ) : end function
  function _
    FbColor.Moccasin() byref as const FbColor : return( _Moccasin ) : end function
  function _
    FbColor.NavajoWhite() byref as const FbColor : return( _NavajoWhite ) : end function
  function _
    FbColor.Navy() byref as const FbColor : return( _Navy ) : end function
  function _
    FbColor.OldLace() byref as const FbColor : return( _OldLace ) : end function
  function _
    FbColor.Olive() byref as const FbColor : return( _Olive ) : end function
  function _
    FbColor.OliveDrab() byref as const FbColor : return( _OliveDrab ) : end function
  function _
    FbColor.Orange() byref as const FbColor : return( _Orange ) : end function
  function _
    FbColor.OrangeRed() byref as const FbColor : return( _OrangeRed ) : end function
  function _
    FbColor.Orchid() byref as const FbColor : return( _Orchid ) : end function
  function _
    FbColor.PaleGoldenrod() byref as const FbColor : return( _PaleGoldenrod ) : end function
  function _
    FbColor.PaleGreen() byref as const FbColor : return( _PaleGreen ) : end function
  function _
    FbColor.PaleTurquoise() byref as const FbColor : return( _PaleTurquoise ) : end function
  function _
    FbColor.PaleVioletRed() byref as const FbColor : return( _PaleVioletRed ) : end function
  function _
    FbColor.PapayaWhip() byref as const FbColor : return( _PapayaWhip ) : end function
  function _
    FbColor.PeachPuff() byref as const FbColor : return( _PeachPuff ) : end function
  function _
    FbColor.Peru() byref as const FbColor : return( _Peru ) : end function
  function _
    FbColor.Pink() byref as const FbColor : return( _Pink ) : end function
  function _
    FbColor.Plum() byref as const FbColor : return( _Plum ) : end function
  function _
    FbColor.PowderBlue() byref as const FbColor : return( _PowderBlue ) : end function
  function _
    FbColor.Purple() byref as const FbColor : return( _Purple ) : end function
  function _
    FbColor.Red() byref as const FbColor : return( _Red ) : end function
  function _
    FbColor.RosyBrown() byref as const FbColor : return( _RosyBrown ) : end function
  function _
    FbColor.RoyalBlue() byref as const FbColor : return( _RoyalBlue ) : end function
  function _
    FbColor.SaddleBrown() byref as const FbColor : return( _SaddleBrown ) : end function
  function _
    FbColor.Salmon() byref as const FbColor : return( _Salmon ) : end function
  function _
    FbColor.SandyBrown() byref as const FbColor : return( _SandyBrown ) : end function
  function _
    FbColor.SeaGreen() byref as const FbColor : return( _SeaGreen ) : end function
  function _
    FbColor.SeaShell() byref as const FbColor : return( _SeaShell ) : end function
  function _
    FbColor.Sienna() byref as const FbColor : return( _Sienna ) : end function
  function _
    FbColor.Silver() byref as const FbColor : return( _Silver ) : end function
  function _
    FbColor.SkyBlue() byref as const FbColor : return( _SkyBlue ) : end function
  function _
    FbColor.SlateBlue() byref as const FbColor : return( _SlateBlue ) : end function
  function _
    FbColor.SlateGray() byref as const FbColor : return( _SlateGray ) : end function
  function _
    FbColor.Snow() byref as const FbColor : return( _Snow ) : end function
  function _
    FbColor.SpringGreen() byref as const FbColor : return( _SpringGreen ) : end function
  function _
    FbColor.SteelBlue() byref as const FbColor : return( _SteelBlue ) : end function
  function _
    FbColor.Tan() byref as const FbColor : return( _Tan ) : end function
  function _
    FbColor.Teal() byref as const FbColor : return( _Teal ) : end function
  function _
    FbColor.Thistle() byref as const FbColor : return( _Thistle ) : end function
  function _
    FbColor.Tomato() byref as const FbColor : return( _Tomato ) : end function
  function _
    FbColor.Transparent() byref as const FbColor : return( _Transparent ) : end function
  function _
    FbColor.Turquoise() byref as const FbColor : return( _Turquoise ) : end function
  function _
    FbColor.Violet() byref as const FbColor : return( _Violet ) : end function
  function _
    FbColor.Wheat() byref as const FbColor : return( _Wheat ) : end function
  function _
    FbColor.White() byref as const FbColor : return( _White ) : end function
  function _
    FbColor.WhiteSmoke() byref as const FbColor : return( _WhiteSmoke ) : end function
  function _
    FbColor.Yellow() byref as const FbColor : return( _Yellow ) : end function
  function _
    FbColor.YellowGreen() byref as const FbColor : return( _YellowGreen ) : end function
  
  #undef __clerp__
  #undef __clerp_a__
end namespace

#endif

