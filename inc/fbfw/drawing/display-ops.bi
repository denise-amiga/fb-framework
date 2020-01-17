#ifndef __FBFW_DRAWING_DISPLAYOPS__
#define __FBFW_DRAWING_DISPLAYOPS__

namespace Drawing
  /'
    Represent the operations that can be performed on a Graphics.Display
    object.
  '/
  type _
    DisplayOps _
    extends Object
    
    public:
      declare virtual destructor()
      
      declare abstract property _
        opName() as string
      declare abstract property _
        opWidth() as integer
      declare abstract property _
        opHeight() as integer
      declare abstract property _
        opForeColor() as Drawing.FbColor
      declare abstract property _
        opForeColor( _
          byref as Drawing.FbColor )
      declare abstract property _
        opBackColor() as Drawing.FbColor
      declare abstract property _
        opBackColor( _
          byref as Drawing.FbColor )
      declare abstract property _
        opRows() as integer
      declare abstract property _
        opColumns() as integer
      
      declare abstract sub _
        opInit( _
          byval as integer, _
          byval as integer )
      declare abstract sub _
        opInitFullScreen()
      declare abstract sub _
        opInitFullScreenLowest()
      declare abstract sub _
        opInitFullScreenHighest()
      declare abstract sub _
        opInitFullScreen( _
          byval as integer, _
          byval as integer )
      declare abstract sub _
        opClear()
      declare abstract sub _
        opClear( _
          byref as Drawing.FbColor )
      declare abstract sub _
        opStartFrame()
      declare abstract sub _
        opEndFrame()
      
      declare abstract sub _
        opTextAt( _
          byval as integer, _
          byval as integer, _
          byref as const string )
      declare abstract sub _
        opTextAt( _
          byval as integer, _
          byval as integer, _
          byref as const string, _
          byref as Drawing.FbColor )
      declare abstract sub _
        opTextAt( _
          byval as integer, _
          byval as integer, _
          byref as const string, _
          byref as Drawing.FbColor, _
          byref as Drawing.FbColor )
      
    protected:
      declare property _
        fullScreenModes() _
        byref as List( of( FullScreenModeInfo ) )
      
      declare function _
        closestFullScreenResTo( _
          byval as integer, _
          byval as integer ) _
        as FullScreenModeInfo ptr
      
    private:
      as List( of( FullScreenModeInfo ) ) ptr _
        _fullScreenModes => new List( of( FullScreenModeInfo ) )()
  end type
  
  destructor _
    DisplayOps()
    
    delete( _fullScreenModes )
  end destructor
  
  property _
    DisplayOps.fullScreenModes() _
    byref as List( of( FullScreenModeInfo ) )
    
    return( *_fullScreenModes )
  end property
  
  function _
    DisplayOps.closestFullScreenResTo( _
      byval aWidth as integer, _
      byval aHeight as integer ) _
    as FullScreenModeInfo ptr
    
    dim as integer _
      closest => 99999, _
      index
    
    for _
      i as integer => 0 _
      to _fullScreenModes->count - 1
      
      dim as integer _
        dist => _
          ( aWidth - _fullScreenModes->at( i )->width ) ^ 2 + _
          ( aHeight - _fullScreenModes->at( i )->height ) ^ 2 
      
      if( _
        dist <= closest ) then
        
        index => i
        closest => dist
      end if
    next
    
    return( _fullScreenModes->at( index ) )
  end function
end namespace

#endif
