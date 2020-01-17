#ifndef __FBFW_DRAWING_FULLSCREENMODEINFO__
#define __FBFW_DRAWING_FULLSCREENMODEINFO__

namespace Drawing
  /'
    Encapsulates info about supported full screen modes
  '/
  type _
    FullScreenModeInfo
    
    public:
      declare constructor( _
        byval as long, _
        byval as long, _
        byval as long => 32 )
      declare destructor()
      
      declare operator _
        cast() as string
      
      declare property _
        width() as long
      declare property _
        height() as long
      declare property _
        depth() as long
      
    private:
      declare constructor()
      
      as long _
        _width, _
        _height, _
        _depth
  end type
  
  constructor _
    FullScreenModeInfo()
  end constructor
  
  constructor _
    FullScreenModeInfo( _
      byval aWidth as long, _
      byval aHeight as long, _
      byval aDepth as long )
    
    _width => aWidth
    _height => aHeight
    _depth => aDepth
  end constructor
  
  destructor _
    FullScreenModeInfo()
  end destructor
  
  property _
    FullScreenModeInfo.width() _
    as long
    
    return( _width )
  end property
  
  property _
    FullScreenModeInfo.height() _
    as long
    
    return( _height )
  end property
  
  property _
    FullScreenModeInfo.depth() _
    as long
    
    return( _depth )
  end property
  
  operator _
    FullScreenModeInfo.cast() _
    as string
    
    return( "{" & _width & "x" & _height & "x" & _depth & "}" )
  end operator
  
  operator _
    =( _
      byref lhs as FullScreenModeInfo, _
      byref rhs as FullScreenModeInfo ) _
    as integer
    
    return( _
      cbool( lhs.width = rhs.width ) andAlso _
      cbool( lhs.height = rhs.height ) andAlso _
      cbool( lhs.depth = rhs.depth ) )
  end operator
  
  template( List, of( FullScreenModeInfo ) )
end namespace

#endif
