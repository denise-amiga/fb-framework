#ifndef __FBFW_DRAWING_SIZEF__
#define __FBFW_DRAWING_SIZEF__

namespace Drawing
  /'
    Describes a two dimensional size, in float values
  '/
  type _
    SizeF
    
    declare constructor()
    declare constructor( _
      byval as single, _
      byval as single )
    declare destructor()
    
    declare function _
      toPointF() as PointF
    
    declare operator _
      cast() as string
    declare operator _
      +=( _
        byref as SizeF )
    declare operator _
      +=( _
        byref as integer )
    declare operator _
      +=( _
        byref as single )
    declare operator _
      -=( _
        byref as SizeF )
    declare operator _
      -=( _
        byref as integer )
    declare operator _
      -=( _
        byref as single )
    declare operator _
      *=( _
        byref as SizeF )
    declare operator _
      *=( _
        byref as integer )
    declare operator _
      *=( _
        byref as single )
    declare operator _
      /=( _
        byref as SizeF )
    declare operator _
      /=( _
        byref as integer )
    declare operator _
      /=( _
        byref as single )
    declare operator _
      \=( _
        byref as integer )
      
    as single _
      width, _
      height
  end type
  
  constructor _
    SizeF()
  end constructor
  
  constructor _
    SizeF( _
      byval aWidth as single, _
      byval aHeight as single )
    
    width => aWidth
    height => aHeight
  end constructor
  
  destructor _
    SizeF()
  end destructor
  
  function _
    SizeF.toPointF() as PointF
    
    return( PointF( width, height ) )
  end function
  
  operator _
    SizeF.cast() as string
    
    return( _
      "{width:" & width & ", height:" & height & "}" )
  end operator
  
  operator _
    SizeF.+=( _
      byref rhs as SizeF )
    
    width +=> rhs.width
    height +=> rhs.height
  end operator
  
  operator _
    SizeF.+=( _
      byref rhs as integer )
      
    width +=> rhs
    height +=> rhs
  end operator
  
  operator _
    SizeF.+=( _
      byref rhs as single )
      
    width +=> rhs
    height +=> rhs
  end operator
  
  operator _
    SizeF.-=( _
      byref rhs as SizeF )
    
    width -=> rhs.width
    height -=> rhs.height
  end operator
  
  operator _
    SizeF.-=( _
      byref rhs as integer )
      
    width -=> rhs
    height -=> rhs
  end operator
  
  operator _
    SizeF.-=( _
      byref rhs as single )
      
    width -=> rhs
    height -=> rhs
  end operator
  
  operator _
    SizeF.*=( _
      byref rhs as SizeF )
    
    width *=> rhs.width
    height *=> rhs.height
  end operator
  
  operator _
    SizeF.*=( _
      byref rhs as integer )
      
    width *=> rhs
    height *=> rhs
  end operator
  
  operator _
    SizeF.*=( _
      byref rhs as single )
      
    width *=> rhs
    height *=> rhs
  end operator
  
  operator _
    SizeF./=( _
      byref rhs as SizeF )
    
    width /=> rhs.width
    height /=> rhs.height
  end operator
  
  operator _
    SizeF./=( _
      byref rhs as integer )
      
    width /=> rhs
    height /=> rhs
  end operator
  
  operator _
    SizeF./=( _
      byref rhs as single )
      
    width /=> rhs
    height /=> rhs
  end operator
  
  operator _
    SizeF.\=( _
      byref rhs as integer )
      
    width \=> rhs
    height \=> rhs
  end operator
  
  operator _
    =( _
      byref lhs as SizeF, _
      byref rhs as SizeF ) _
    as integer
    
    return( _
      lhs.width = rhs.width andAlso _
      lhs.height = rhs.height )
  end operator
  
  operator _
    <>( _
      byref lhs as SizeF, _
      byref rhs as SizeF ) _
    as integer
    
    return( _
      lhs.width <> rhs.width orElse _
      lhs.height <> rhs.height )
  end operator
  
  operator _
    abs( _
      byref rhs as SizeF ) _
    as SizeF
    
    return( SizeF( _
      abs( rhs.width ), abs( rhs.height ) ) )
  end operator
  
  operator _
    mod( _
      byref lhs as SizeF, _
      byref rhs as integer ) _
    as SizeF
    
    return( SizeF( _
      lhs.width mod rhs, lhs.height mod rhs ) )
  end operator
  
  operator _
    mod( _
      byref lhs as SizeF, _
      byref rhs as single ) _
    as SizeF
    
    return( SizeF( _
      Math.fMod( lhs.width, rhs ), Math.fMod( lhs.height, rhs ) ) )
  end operator
  
  operator _
    +( _
      byref lhs as SizeF, _
      byref rhs as SizeF ) _
    as SizeF
    
    return( SizeF( _
      lhs.width + rhs.width, lhs.height + rhs.height ) )
  end operator
  
  operator _
    +( _
      byref lhs as SizeF, _
      byref rhs as integer ) _
    as SizeF
    
    return( SizeF( _
      lhs.width + rhs, lhs.height + rhs ) )
  end operator
  
  operator _
    +( _
      byref lhs as SizeF, _
      byref rhs as single ) _
    as SizeF
    
    return( SizeF( _
      lhs.width + rhs, lhs.height + rhs ) )
  end operator
  
  operator _
    -( _
      byref rhs as SizeF ) _
    as SizeF
    
    return( SizeF( _
      -rhs.width, -rhs.height ) )
  end operator
  
  operator _
    -( _
      byref lhs as SizeF, _
      byref rhs as SizeF ) _
    as SizeF
    
    return( SizeF( _
      lhs.width - rhs.width, lhs.height - rhs.height ) )
  end operator
  
  operator _
    -( _
      byref lhs as SizeF, _
      byref rhs as integer ) _
    as SizeF
    
    return( SizeF( _
      lhs.width - rhs, lhs.height - rhs ) )
  end operator
  
  operator _
    -( _
      byref lhs as SizeF, _
      byref rhs as single ) _
    as SizeF
    
    return( SizeF( _
      lhs.width - rhs, lhs.height - rhs ) )
  end operator
  
  operator _
    *( _
      byref lhs as SizeF, _
      byref rhs as SizeF ) _
    as SizeF
    
    return( SizeF( _
      lhs.width * rhs.width, lhs.height * rhs.height ) )
  end operator
  
  operator _
    *( _
      byref lhs as SizeF, _
      byref rhs as integer ) _
    as SizeF
    
    return( SizeF( _
      lhs.width * rhs, lhs.height * rhs ) )
  end operator
  
  operator _
    *( _
      byref lhs as SizeF, _
      byref rhs as single ) _
    as SizeF
    
    return( SizeF( _
      lhs.width * rhs, lhs.height * rhs ) )
  end operator
  
  operator _
    /( _
      byref lhs as SizeF, _
      byref rhs as SizeF ) _
    as SizeF
    
    return( SizeF( _
      lhs.width / rhs.width, lhs.height / rhs.height ) )
  end operator
  
  operator _
    /( _
      byref lhs as SizeF, _
      byref rhs as integer ) _
    as SizeF
    
    return( SizeF( _
      lhs.width / rhs, lhs.height / rhs ) )
  end operator
  
  operator _
    /( _
      byref lhs as SizeF, _
      byref rhs as single ) _
    as SizeF
    
    return( SizeF( _
      lhs.width / rhs, lhs.height / rhs ) )
  end operator
  
  operator _
    \( _
      byref lhs as SizeF, _
      byref rhs as integer ) _
    as SizeF
    
    return( SizeF( _
      lhs.width \ rhs, lhs.height \ rhs ) )
  end operator
end namespace

#endif
