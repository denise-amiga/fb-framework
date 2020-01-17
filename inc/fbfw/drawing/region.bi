#ifndef __FBFW_DRAWING_REGION__
#define __FBFW_DRAWING_REGION__

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
      declare constructor( _
        byref as Rectangle )
      declare constructor( _
        byref as RectangleF )
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
        overlapsWith( _
          byref as Rectangle ) _
        as boolean
      declare function _
        overlapsWith( _
          byref as RectangleF ) _
        as boolean
      
      declare function _
        enter( _
          byval as integer, _
          byval as integer ) _ 
        as boolean
      declare function _
        leave( _
          byval as integer, _
          byval as integer ) _
        as boolean
      
    private:
      as Drawing.Rectangle _
        _rect
      as Drawing.Point _
        _prevPoint
      as boolean _
        _enter, _
        _leave
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
  
  constructor _
    Region( _
      byref rhs as Rectangle )
    
    _rect => Rectangle( rhs )
  end constructor
  
  constructor _
    Region( _
      byref rhs as RectangleF )
    
    _rect => Rectangle( _
      rhs.X, rhs.Y, _
      rhs.width, rhs.height )
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
    Region.overlapsWith( _
      byref another as Rectangle ) _
    as boolean
    
    return( _rect.overlapsWith( another ) )
  end function
  
  function _
    Region.overlapsWith( _
      byref another as RectangleF ) _
    as boolean
    
    return( _rect.overlapsWith( another ) )
  end function
  
  function _
    Region.enter( _
      byval X as integer, _
      byval Y as integer ) _
    as boolean
    
    if( not _enter ) then
      if( _
        not _rect.contains( _prevPoint ) andAlso _
        _rect.contains( X, Y ) ) then
        
        _enter => true
        _leave => false
      end if
    end if
    
    _prevPoint => Drawing.Point( X, Y )
    
    return( _enter )
  end function
  
  function _
    Region.leave( _
      byval X as integer, _
      byval Y as integer ) _
    as boolean
    
    if( _enter ) then
      if( not _rect.contains( X, Y ) ) then
        _leave => true
        _enter => false
      end if
    end if
    
    _prevPoint => Drawing.Point( X, Y )
    
    return( _leave )
  end function
end namespace

#endif
