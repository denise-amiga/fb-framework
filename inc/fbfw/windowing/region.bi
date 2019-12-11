#ifndef __FBFW_WINDOWING_REGION__
#define __FBFW_WINDOWING_REGION__

namespace Drawing
  type _
    Region
    
    public:
      declare constructor()
      declare constructor( _
        byval as integer, _
        byval as integer, _
        byval as integer, _
        byval as integer )
      declare constructor( _
        byref as Drawing.Point, _
        byref as Drawing.Size )
      declare constructor( _
        byref as Region )
      declare destructor()
      
      declare operator _
        let( _
          byref as Region )
        
      declare property _
        location() byref as Drawing.Point
      declare property _
        location( _
          byref as Drawing.Point )
      declare property _
        size() byref as Drawing.Size
      declare property _
        size( _
          byref as Drawing.size )
        
      declare function _
        mouseEnter( _
          byval as integer, _
          byval as integer ) _ 
        as boolean
      declare function _
        mouseLeave( _
          byval as integer, _
          byval as integer ) _
        as boolean
      
    private:
      as Drawing.Rectangle _
        _rect
      as Drawing.Point _
        _prevPoint
      as boolean _
        _mouseEnter, _
        _mouseLeave
  end type
  
  constructor _
    Region()
  end constructor
  
  constructor _
    Region( _
      byval X1 as integer, _
      byval Y1 as integer, _
      byval X2 as integer, _
      byval Y2 as integer )
    
    _rect => Drawing.Rectangle( _
      X1, Y1, X2, Y2 )
  end constructor
  
  constructor _
    Region( _
      byref aLocation as Drawing.Point, _
      byref aSize as Drawing.Size )
    
    _rect => Drawing.Rectangle( _
      aLocation, _
      aSize )
  end constructor
  
  constructor _
    Region( _
      byref rhs as Region )
    
    _rect => rhs._rect
  end constructor
  
  destructor _
    Region()
  end destructor
  
  operator _
    Region.let( _
      byref rhs as Region )
    
    _rect => rhs._rect
  end operator
  
  property _
    Region.location() _
    byref as Drawing.Point
    
    return( _rect.location )
  end property
  
  property _
    Region.location( _
      byref value as Drawing.Point )
    
    _rect.location => value
  end property
  
  property _
    Region.size() _
    byref as Drawing.Size
    
    return( _rect.extents )
  end property
  
  property _
    Region.size( _
      byref value as Drawing.Size )
    
    _rect.extents => value
  end property
  
  function _
    Region.mouseEnter( _
      byval X as integer, _
      byval Y as integer ) _
    as boolean
    
    if( not _mouseEnter ) then
      if( _
        not _rect.contains( _prevPoint ) andAlso _
        _rect.contains( X, Y ) ) then
        
        _mouseEnter => true
        _mouseLeave => false
      end if
    end if
    
    _prevPoint => Drawing.Point( X, Y )
    
    return( _mouseEnter )
  end function
  
  function _
    Region.mouseLeave( _
      byval X as integer, _
      byval Y as integer ) _
    as boolean
    
    if( _mouseEnter ) then
      if( not _rect.contains( X, Y ) ) then
        _mouseLeave => true
        _mouseEnter => false
      end if
    end if
    
    _prevPoint => Drawing.Point( X, Y )
    
    return( _mouseLeave )
  end function
end namespace

#endif
