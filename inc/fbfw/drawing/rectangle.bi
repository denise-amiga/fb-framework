#ifndef __FBFW_DRAWING_RECTANGLE__
#define __FBFW_DRAWING_RECTANGLE__

namespace Drawing
  /'
    Describes a two dimensional rectangle's position and extents, in
    integer coordinates.
  '/
  type _
    Rectangle
    
    declare constructor()
    declare constructor( _
      byval as integer, _
      byval as integer, _
      byval as integer, _
      byval as integer )
    declare constructor( _
      byref as Point, _
      byref as Size )
    declare constructor( _
      byref as Rectangle )
    declare constructor( _
      byref as _RectangleF )
    declare destructor()
    
    declare property _
      X() as integer
    declare property _
      X( byval as integer )
    declare property _
      Y() as integer
    declare property _
      Y( byval as integer )
    declare property _
      width() as integer
    declare property _
      width( byval as integer )
    declare property _
      height() as integer
    declare property _
      height( byval as integer )
    declare property _
      area() as integer
    
    declare function _
      isInsideOf( _
        byref as Rectangle ) _
      as boolean
    declare function _
      isInsideOf( _
        byref as _RectangleF ) _
      as boolean
    declare function _
      overlapsWith( _
        byref as Rectangle ) _
      as boolean
    declare function _
      overlapsWith( _
        byref as _RectangleF ) _
      as boolean
    
    declare function _
      contains( _
        byval as integer, _
        byval as integer ) _
      as boolean
    declare function _
      contains( _
        byval as single, _
        byval as single ) _
      as boolean
    declare function _
      contains( _
        byref as Point ) _
      as boolean
    declare function _
      contains( _
        byref as PointF ) _
      as boolean
    
    declare sub _
      scaleBy( _
        byref as Size )
    declare sub _
      scaleBy( _
        byref as SizeF )
    declare sub _
      scaleBy( _
        byval as integer )
    declare sub _
      scaleBy( _
        byval as integer, _
        byval as integer )
    declare sub _
      scaleBy( _
        byval as single )
    declare sub _
      scaleBy( _
        byval as single, _
        byval as single )
      
    declare function _
      scaledBy( _
        byref as Size ) _
      as Rectangle
    declare function _
      scaledBy( _
        byref as SizeF ) _
      as Rectangle
    declare function _
      scaledBy( _
        byval as integer ) _
      as Rectangle
    declare function _
      scaledBy( _
        byval as integer, _
        byval as integer ) _
      as Rectangle
    declare function _
      scaledBy( _
        byval as single ) _
      as Rectangle
    declare function _
      scaledBy( _
        byval as single, _
        byval as single ) _
      as Rectangle
    
    declare sub _
      displaceBy( _
        byref as Point )
    declare sub _
      displaceBy( _
        byref as PointF )
    declare sub _
      displaceBy( _
        byval as integer )
    declare sub _
      displaceBy( _
        byval as integer, _
        byval as integer )
    declare sub _
      displaceBy( _
        byval as single )
    declare sub _
      displaceBy( _
        byval as single, _
        byval as single )
      
    declare function _
      displacedBy( _
        byref as Point ) _
      as Rectangle
    declare function _
      displacedBy( _
        byref as PointF ) _
      as Rectangle
    declare function _
      displacedBy( _
        byval as integer ) _
      as Rectangle
    declare function _
      displacedBy( _
        byval as integer, _
        byval as integer ) _
      as Rectangle
    declare function _
      displacedBy( _
        byval as single ) _
      as Rectangle
    declare function _
      displacedBy( _
        byval as single, _
        byval as single ) _
      as Rectangle
    
    declare operator _
      cast() as string
    declare operator _
      +=( _
        byref as Rectangle )
    declare operator _
      +=( _
        byref as integer )
    declare operator _
      +=( _
        byref as single )
    declare operator _
      -=( _
        byref as Rectangle )
    declare operator _
      -=( _
        byref as integer )
    declare operator _
      -=( _
        byref as single )
    declare operator _
      *=( _
        byref as integer )
    declare operator _
      *=( _
        byref as single )
    declare operator _
      /=( _
        byref as integer )
    declare operator _
      /=( _
        byref as single )
    declare operator _
      \=( _
        byref as integer )
      
    as Point _
      location
    as Size _
      extents
  end type
  
  constructor _
    Rectangle()
  end constructor
  
  constructor _
    Rectangle( _
      byval X1 as integer, _
      byval Y1 as integer, _
      byval X2 as integer, _
      byval Y2 as integer )
    
    if( X2 < X1 ) then
      swap X2, Y1
    end if
    
    if( Y2 < Y1 ) then
      swap Y2, Y1
    end if
    
    location => Point( X1, Y1 )
    extents => Size( abs( X2 - X1 ), abs( Y2 - Y1 ) )
  end constructor
  
  constructor _
    Rectangle( _
      byref aLocation as Point, _
      byref aSize as Size )
    
    location => aLocation
    extents => aSize
  end constructor
  
  constructor _
    Rectangle( _
      byref aRectangle as Rectangle )
    
    this.constructor( _
      aRectangle.X, aRectangle.Y, _
      aRectangle.width, aRectangle.height )
  end constructor
  
  /'
    ** Constructor Rectangle( byref as _RectangleF ) **
    
    The missing constructor def is placed after the definition of
    the RectangleF class.
  '/
  
  destructor _
    Rectangle()
  end destructor
  
  operator _
    Rectangle.cast() as string
    
    return( _
      "{" & location & ", " & extents & "}" )
  end operator
  
  operator _
    Rectangle.+=( _
      byref rhs as Rectangle )
    
    extents +=> rhs.extents
  end operator
  
  operator _
    Rectangle.+=( _
      byref rhs as integer )
      
    extents +=> rhs
  end operator
  
  operator _
    Rectangle.+=( _
      byref rhs as single )
      
    extents +=> rhs
  end operator
  
  operator _
    Rectangle.-=( _
      byref rhs as Rectangle )
    
    extents -=> rhs.extents
  end operator
  
  operator _
    Rectangle.-=( _
      byref rhs as integer )
      
    extents -=> rhs
  end operator
  
  operator _
    Rectangle.-=( _
      byref rhs as single )
      
    extents -=> rhs
  end operator
  
  operator _
    Rectangle.*=( _
      byref rhs as integer )
      
    extents *=> rhs
  end operator
  
  operator _
    Rectangle.*=( _
      byref rhs as single )
      
    extents *=> rhs
  end operator
  
  operator _
    Rectangle./=( _
      byref rhs as integer )
      
    extents /=> rhs
  end operator
  
  operator _
    Rectangle./=( _
      byref rhs as single )
      
    extents /=> rhs
  end operator
  
  operator _
    Rectangle.\=( _
      byref rhs as integer )
      
    extents \=> rhs
  end operator
  
  operator _
    =( _
      byref lhs as Rectangle, _
      byref rhs as Rectangle ) _
    as integer
    
    return( _
      lhs.location = rhs.location andAlso _
      lhs.extents = rhs.extents )
  end operator
  
  operator _
    <>( _
      byref lhs as Rectangle, _
      byref rhs as Rectangle ) _
    as integer
    
    return( _
      lhs.location <> rhs.location orElse _
      lhs.extents <> rhs.extents )
  end operator
  
  operator _
    >( _
      byref lhs as Rectangle, _
      byref rhs as Rectangle ) _
    as integer
    
    return( _
      lhs.area > rhs.area )
  end operator
  
  operator _
    >=( _
      byref lhs as Rectangle, _
      byref rhs as Rectangle ) _
    as integer
    
    return( _
      lhs.area >= rhs.area )
  end operator
  
  operator _
    <( _
      byref lhs as Rectangle, _
      byref rhs as Rectangle ) _
    as integer
    
    return( _
      lhs.area < rhs.area )
  end operator
  
  operator _
    <=( _
      byref lhs as Rectangle, _
      byref rhs as Rectangle ) _
    as integer
    
    return( _
      lhs.area <= rhs.area )
  end operator
  
  operator _
    +( _
      byref lhs as Rectangle, _
      byref rhs as Point ) _
    as Rectangle
    
    return( Rectangle( _
      lhs.location + rhs, _
      lhs.extents ) )
  end operator
  
  operator _
    +( _
      byref lhs as Rectangle, _
      byref rhs as PointF ) _
    as Rectangle
    
    return( Rectangle( _
      lhs.location + Point( rhs.x, rhs.y ), _
      lhs.extents ) )
  end operator
  
  operator _
    +( _
      byref lhs as Rectangle, _
      byref rhs as Size ) _
    as Rectangle
    
    return( Rectangle( _
      lhs.location, _
      lhs.extents + rhs ) )
  end operator
  
  operator _
    +( _
      byref lhs as Rectangle, _
      byref rhs as SizeF ) _
    as Rectangle
    
    return( Rectangle( _
      lhs.location, _
      lhs.extents + Size( rhs.width, rhs.height ) ) )
  end operator
  
  operator _
    -( _
      byref lhs as Rectangle, _
      byref rhs as Point ) _
    as Rectangle
    
    return( Rectangle( _
      lhs.location - rhs, _
      lhs.extents ) )
  end operator
  
  operator _
    -( _
      byref lhs as Rectangle, _
      byref rhs as PointF ) _
    as Rectangle
    
    return( Rectangle( _
      lhs.location - Point( rhs.x, rhs.y ), _
      lhs.extents ) )
  end operator
  
  operator _
    -( _
      byref lhs as Rectangle, _
      byref rhs as Size ) _
    as Rectangle
    
    return( Rectangle( _
      lhs.location, _
      lhs.extents - rhs ) )
  end operator
  
  operator _
    -( _
      byref lhs as Rectangle, _
      byref rhs as SizeF ) _
    as Rectangle
    
    return( Rectangle( _
      lhs.location, _
      lhs.extents - Size( rhs.width, rhs.height ) ) )
  end operator
  
  property _
    Rectangle.X() _
    as integer
    
    return( location.x )
  end property
  
  property _
    Rectangle.X( byval value as integer )
    
    location.x => value
  end property
  
  property _
    Rectangle.Y() _
    as integer
    
    return( location.y )
  end property
  
  property _
    Rectangle.Y( byval value as integer )
    
    location.y => value
  end property
  
  property _
    Rectangle.width() _
    as integer
    
    return( extents.width )
  end property
  
  property _
    Rectangle.width( byval value as integer )
    
    extents.width => value
  end property
  
  property _
    Rectangle.height() _
    as integer
    
    return( extents.height )
  end property
  
  property _
    Rectangle.height( byval value as integer )
    
    extents.height => value
  end property
  
  property _
    Rectangle.area() as integer
    
    return( abs( extents.width * extents.height ) )
  end property
  
  function _
    Rectangle.isInsideOf( _
      byref another as Rectangle ) _
    as boolean
    
    return( cbool( _
      location.x - another.location.x >= 0 andAlso _
      location.x + extents.width - _
        another.location.x <= another.extents.width andAlso _
      location.y - another.location.y >= 0 andAlso _
      location.y + extents.height - _
        another.location.y <= another.extents.height ) )
  end function
  
  function _
    Rectangle.overlapsWith( _
      byref another as Rectangle ) _
    as boolean
    
    return( cbool( _
      location.x + extents.width - 1 >= another.location.x andAlso _
      location.y + extents.height - 1 >= another.location.y andAlso _
      location.x <= another.location.x + another.extents.width - 1 andAlso _
      location.y <= another.location.y + another.extents.height - 1 ) )
  end function
  
  function _
    Rectangle.contains( _
      byref aPoint as Point ) _
    as boolean
    
    return( cbool( _
      aPoint.x >= location.x andAlso _
      aPoint.x <= location.x + extents.width - 1 andAlso _
      aPoint.y >= location.y andAlso _
      aPoint.y <= location.y + extents.height - 1 ) )
  end function
  
  function _
    Rectangle.contains( _
      byref aPoint as PointF ) _
    as boolean
    
    return( cbool( _
      aPoint.x >= location.x andAlso _
      aPoint.x <= location.x + extents.width - 1 andAlso _
      aPoint.y >= location.y andAlso _
      aPoint.y <= location.y + extents.height - 1 ) )
  end function
  
  function _
    Rectangle.contains( _ 
      byval aX as integer, _
      byval aY as integer ) _
    as boolean
    
    return( cbool( _
      aX >= location.x andAlso _
      aX <= location.x + extents.width - 1 andAlso _
      aY >= location.y andAlso _
      aY <= location.y + extents.height - 1 ) )
  end function
  
  function _
    Rectangle.contains( _
      byval aX as single, _
      byval aY as single ) _
    as boolean
    
    return( cbool( _
      aX >= location.x andAlso _
      aX <= location.x + extents.width - 1 andAlso _
      aY >= location.y andAlso _
      aY <= location.y + extents.height - 1 ) )
  end function
  
  sub _
    Rectangle.scaleBy( _
      byref aSize as Size )
    
    scaleBy( aSize.width, aSize.height )
  end sub
  
  sub _
    Rectangle.scaleBy( _
      byref aSize as SizeF )
    
    scaleBy( aSize.width, aSize.height )
  end sub
  
  sub _
    Rectangle.scaleBy( _
      byval aSize as integer )
    
    scaleBy( aSize, aSize )
  end sub
  
  sub _
    Rectangle.scaleBy( _
      byval aSizeX as integer, _
      byval aSizeY as integer )
    
    var _
      newLocX => location.x * aSizeX, _
      newLocY => location.y * aSizeY, _
      newExtX => extents.width * aSizeX, _
      newExtY => extents.height * aSizeY, _
      center => location + extents.toPoint() / 2
    
    location.x => center.x - newExtX / 2
    location.y => center.y - newExtY / 2
    
    extents => Size( newExtX, newExtY )
  end sub
  
  sub _
    Rectangle.scaleBy( _
      byval aSize as single )
    
    scaleBy( aSize, aSize )
  end sub
  
  sub _
    Rectangle.scaleBy( _
      byval aSizeX as single, _
      byval aSizeY as single )
    
    var _
      newLocX => location.x * aSizeX, _
      newLocY => location.y * aSizeY, _
      newExtX => extents.width * aSizeX, _
      newExtY => extents.height * aSizeY, _
      center => location + extents.toPoint() / 2
    
    location.x => center.x - newExtX / 2
    location.y => center.y - newExtY / 2
    
    extents => Size( newExtX, newExtY )
  end sub
  
  function _
    Rectangle.scaledBy( _
      byref aSize as SizeF ) _
    as Rectangle
    
    return( scaledBy( aSize.width, aSize.height ) )
  end function
  
  function _
    Rectangle.scaledBy( _
      byval aSize as integer ) _
    as Rectangle
    
    return( scaledBy( aSize, aSize ) )
  end function
  
  function _
    Rectangle.scaledBy( _
      byval aSizeX as integer, _
      byval aSizeY as integer ) _
    as Rectangle
    
    var _
      r => Rectangle( location, extents )
    
    r.scaleBy( aSizeX, aSizeY )
    
    return( r )
  end function
  
  function _
    Rectangle.scaledBy( _
      byval aSize as single ) _
    as Rectangle
    
    return( scaledBy( aSize, aSize ) )
  end function
  
  function _
    Rectangle.scaledBy( _
      byval aSizeX as single, _
      byval aSizeY as single ) _
    as Rectangle
    
    var _
      r => Rectangle( location, extents )
    
    r.scaleBy( aSizeX, aSizeY )
    
    return( r )
  end function
  
  sub _
    Rectangle.displaceBy( _
      byref aPoint as Point )
    
    displaceBy( aPoint.x, aPoint.y )
  end sub
  
  sub _
    Rectangle.displaceBy( _
      byref aPoint as PointF )
    
    displaceBy( aPoint.x, aPoint.y )
  end sub
  
  sub _
    Rectangle.displaceBy( _
      byval anAmount as integer )
    
    location +=> anAmount
    extents -=> anAmount * 2
  end sub
  
  sub _
    Rectangle.displaceBy( _
      byval anAmountX as integer, _
      byval anAmountY as integer )
    
    location.x +=> anAmountX
    location.y +=> anAmountY
    extents.width -=> anAmountX * 2
    extents.height -=> anAmountY * 2
  end sub
  
  sub _
    Rectangle.displaceBy( _
      byval anAmount as single )
    
    location +=> anAmount
    extents -=> anAmount * 2
  end sub
  
  sub _
    Rectangle.displaceBy( _
      byval anAmountX as single, _
      byval anAmountY as single )
    
    location.x +=> anAmountX
    location.y +=> anAmountY
    extents.width -=> anAmountX * 2
    extents.height -=> anAmountY * 2
  end sub
  
  function _
    Rectangle.displacedBy( _
      byref aPoint as Point ) _
    as Rectangle
    
    return( displacedBy( aPoint.x, aPoint.y ) )
  end function
  
  function _
    Rectangle.displacedBy( _
      byref aPoint as PointF ) _
    as Rectangle
    
    return( displacedBy( aPoint.x, aPoint.y ) )
  end function
  
  function _
    Rectangle.displacedBy( _
      byval anAmount as integer ) _
    as Rectangle
    
    return( Rectangle( _
      location + anAmount, _
      extents - anAmount * 2 ) )
  end function
  
  function _
    Rectangle.displacedBy( _
      byval anAmountX as integer, _
      byval anAmountY as integer ) _
    as Rectangle
    
    return( Rectangle( _
      Point( _
        location.x + anAmountX, _
        location.y + anAmountY ), _
      Size( _
        extents.width - anAmountX * 2, _
        extents.height - anAmountX * 2 ) ) )
  end function
  
  function _
    Rectangle.displacedBy( _
      byval anAmount as single ) _
    as Rectangle
    
    return( Rectangle( _
      location + anAmount, _
      extents - anAmount * 2 ) )
  end function
  
  function _
    Rectangle.displacedBy( _
      byval anAmountX as single, _
      byval anAmountY as single ) _
    as Rectangle
    
    return( Rectangle( _
      Point( _
        location.x + anAmountX, _
        location.y + anAmountY ), _
      Size( _
        extents.width - anAmountX * 2, _
        extents.height - anAmountY * 2 ) ) )
  end function
  
  /'
    Now we can implement the rest of the Point type that references the
    Rectangle type.
  '/
  function _
    Point.isInsideOf( _
      byref aRectangle as Rectangle ) _
    as boolean
    
    return( cbool( _
      x >= aRectangle.location.x andAlso _
      x <= aRectangle.location.x + aRectangle.extents.width andAlso _
      y >= aRectangle.location.y andAlso _
      y <= aRectangle.location.y + aRectangle.extents.height ) )
  end function
end namespace

#endif
