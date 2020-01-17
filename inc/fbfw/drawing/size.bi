#ifndef __FBFW_DRAWING_SIZE__
#define __FBFW_DRAWING_SIZE__

namespace Drawing
  /'
    Describes a two dimensional size, in integer values
  '/
  type _
    Size
    
    declare constructor()
    declare constructor( _
      byval as integer, _
      byval as integer )
    declare destructor()
    
    declare function _
      toPoint() as Point
    
    declare operator _
      cast() as string
    declare operator _
      +=( _
        byref as Size )
    declare operator _
      +=( _
        byref as integer )
    declare operator _
      +=( _
        byref as single )
    declare operator _
      -=( _
        byref as Size )
    declare operator _
      -=( _
        byref as integer )
    declare operator _
      -=( _
        byref as single )
    declare operator _
      *=( _
        byref as Size )
    declare operator _
      *=( _
        byref as integer )
    declare operator _
      *=( _
        byref as single )
    declare operator _
      /=( _
        byref as Size )
    declare operator _
      /=( _
        byref as integer )
    declare operator _
      /=( _
        byref as single )
    declare operator _
      \=( _
        byref as integer )
      
    as integer _
      width, _
      height
  end type
  
  constructor _
    Size()
  end constructor
  
  constructor _
    Size( _
      byval aWidth as integer, _
      byval aHeight as integer )
    
    width => aWidth
    height => aHeight
  end constructor
  
  destructor _
    Size()
  end destructor
  
  function _
    Size.toPoint() as Point
    
    return( Point( width, height ) )
  end function
  
  operator _
    Size.cast() as string
    
    return( _
      "{width:" & width & ", height:" & height & "}" )
  end operator
  
  operator _
    Size.+=( _
      byref rhs as Size )
    
    width +=> rhs.width
    height +=> rhs.height
  end operator
  
  operator _
    Size.+=( _
      byref rhs as integer )
      
    width +=> rhs
    height +=> rhs
  end operator
  
  operator _
    Size.+=( _
      byref rhs as single )
      
    width +=> rhs
    height +=> rhs
  end operator
  
  operator _
    Size.-=( _
      byref rhs as Size )
    
    width -=> rhs.width
    height -=> rhs.height
  end operator
  
  operator _
    Size.-=( _
      byref rhs as integer )
      
    width -=> rhs
    height -=> rhs
  end operator
  
  operator _
    Size.-=( _
      byref rhs as single )
      
    width -=> rhs
    height -=> rhs
  end operator
  
  operator _
    Size.*=( _
      byref rhs as Size )
    
    width *=> rhs.width
    height *=> rhs.height
  end operator
  
  operator _
    Size.*=( _
      byref rhs as integer )
      
    width *=> rhs
    height *=> rhs
  end operator
  
  operator _
    Size.*=( _
      byref rhs as single )
      
    width *=> rhs
    height *=> rhs
  end operator
  
  operator _
    Size./=( _
      byref rhs as Size )
    
    width /=> rhs.width
    height /=> rhs.height
  end operator
  
  operator _
    Size./=( _
      byref rhs as integer )
      
    width /=> rhs
    height /=> rhs
  end operator
  
  operator _
    Size./=( _
      byref rhs as single )
      
    width /=> rhs
    height /=> rhs
  end operator
  
  operator _
    Size.\=( _
      byref rhs as integer )
      
    width \=> rhs
    height \=> rhs
  end operator
  
  operator _
    =( _
      byref lhs as Size, _
      byref rhs as Size ) _
    as integer
    
    return( _
      lhs.width = rhs.width andAlso _
      lhs.height = rhs.height )
  end operator
  
  operator _
    <>( _
      byref lhs as Size, _
      byref rhs as Size ) _
    as integer
    
    return( _
      lhs.width <> rhs.width orElse _
      lhs.height <> rhs.height )
  end operator
  
  operator _
    abs( _
      byref rhs as Size ) _
    as Size
    
    return( Size( _
      abs( rhs.width ), abs( rhs.height ) ) )
  end operator
  
  operator _
    mod( _
      byref lhs as Size, _
      byref rhs as integer ) _
    as Size
    
    return( Size( _
      lhs.width mod rhs, lhs.height mod rhs ) )
  end operator
  
  operator _
    mod( _
      byref lhs as Size, _
      byref rhs as single ) _
    as Size
    
    return( Size( _
      Math.fMod( lhs.width, rhs ), Math.fMod( lhs.height, rhs ) ) )
  end operator
  
  operator _
    +( _
      byref lhs as Size, _
      byref rhs as Size ) _
    as Size
    
    return( Size( _
      lhs.width + rhs.width, lhs.height + rhs.height ) )
  end operator
  
  operator _
    +( _
      byref lhs as Size, _
      byref rhs as integer ) _
    as Size
    
    return( Size( _
      lhs.width + rhs, lhs.height + rhs ) )
  end operator
  
  operator _
    -( _
      byref rhs as Size ) _
    as Size
    
    return( Size( _
      -rhs.width, -rhs.height ) )
  end operator
  
  operator _
    -( _
      byref lhs as Size, _
      byref rhs as Size ) _
    as Size
    
    return( Size( _
      lhs.width - rhs.width, lhs.height - rhs.height ) )
  end operator
  
  operator _
    -( _
      byref lhs as Size, _
      byref rhs as integer ) _
    as Size
    
    return( Size( _
      lhs.width - rhs, lhs.height - rhs ) )
  end operator
  
  operator _
    *( _
      byref lhs as Size, _
      byref rhs as Size ) _
    as Size
    
    return( Size( _
      lhs.width * rhs.width, lhs.height * rhs.height ) )
  end operator
  
  operator _
    *( _
      byref lhs as Size, _
      byref rhs as integer ) _
    as Size
    
    return( Size( _
      lhs.width * rhs, lhs.height * rhs ) )
  end operator
  
  operator _
    *( _
      byref lhs as Size, _
      byref rhs as single ) _
    as Size
    
    return( Size( _
      lhs.width * rhs, lhs.height * rhs ) )
  end operator
  
  operator _
    /( _
      byref lhs as Size, _
      byref rhs as Size ) _
    as Size
    
    return( Size( _
      lhs.width / rhs.width, lhs.height / rhs.height ) )
  end operator
  
  operator _
    /( _
      byref lhs as Size, _
      byref rhs as integer ) _
    as Size
    
    return( Size( _
      lhs.width / rhs, lhs.height / rhs ) )
  end operator
  
  operator _
    /( _
      byref lhs as Size, _
      byref rhs as single ) _
    as Size
    
    return( Size( _
      lhs.width / rhs, lhs.height / rhs ) )
  end operator
  
  operator _
    \( _
      byref lhs as Size, _
      byref rhs as integer ) _
    as Size
    
    return( Size( _
      lhs.width \ rhs, lhs.height \ rhs ) )
  end operator
end namespace
#endif
