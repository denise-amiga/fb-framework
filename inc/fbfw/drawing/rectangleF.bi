#ifndef __FBFW_DRAWING_RECTANGLEF__
#define __FBFW_DRAWING_RECTANGLEF__

namespace Drawing
  /'
    Describes a two dimensional rectangle's position and extents, in
    float coordinates.
  '/
  type _
    RectangleF
    
    declare constructor()
    declare constructor( _
      byval as single, _
      byval as single, _
      byval as single, _
      byval as single )
    declare constructor( _
      byref as PointF, _
      byref as SizeF )
    declare constructor( _
      byref as Rectangle )
    declare constructor( _
      byref as RectangleF )
    declare destructor()
    
    declare property _
      X() as single
    declare property _
      X( byval as single )
    declare property _
      Y() as single
    declare property _
      Y( byval as single )
    declare property _
      width() as single
    declare property _
      width( byval as single )
    declare property _
      height() as single
    declare property _
      height( byval as single )
    declare property _
      area() as single
    
    declare function _
      isInsideOf( _
        byref as Rectangle ) _
      as boolean
    declare function _
      isInsideOf( _
        byref as RectangleF ) _
      as boolean
    declare function _
      overlapsWith( _
        byref as Rectangle ) _
      as boolean
    declare function _
      overlapsWith( _
        byref as RectangleF ) _
      as boolean
    declare function _
      contains( _
        byref as Point ) _
      as boolean
    declare function _
      contains( _
        byref as PointF ) _
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
      as RectangleF
    declare function _
      scaledBy( _
        byref as SizeF ) _
      as RectangleF
    declare function _
      scaledBy( _
        byval as integer ) _
      as RectangleF
    declare function _
      scaledBy( _
        byval as integer, _
        byval as integer ) _
      as RectangleF
    declare function _
      scaledBy( _
        byval as single ) _
      as RectangleF
    declare function _
      scaledBy( _
        byval as single, _
        byval as single ) _
      as RectangleF
    
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
      as RectangleF
    declare function _
      displacedBy( _
        byref as PointF ) _
      as RectangleF
    declare function _
      displacedBy( _
        byval as integer ) _
      as RectangleF
    declare function _
      displacedBy( _
        byval as integer, _
        byval as integer ) _
      as RectangleF
    declare function _
      displacedBy( _
        byval as single ) _
      as RectangleF
    declare function _
      displacedBy( _
        byval as single, _
        byval as single ) _
      as RectangleF
    
    declare operator _
      cast() as string
    
    declare operator _
      +=( _
        byref as RectangleF )
    declare operator _
      +=( _
        byref as integer )
    declare operator _
      +=( _
        byref as single )
    declare operator _
      -=( _
        byref as RectangleF )
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
      
    as PointF _
      location
    as SizeF _
      extents
  end type
  
  constructor _
    RectangleF()
  end constructor
  
  constructor _
    RectangleF( _
      byval aX as single, _
      byval aY as single, _
      byval aWidth as single, _
      byval aHeight as single )
    
    location => PointF( aX, aY )
    extents => SizeF( aWidth, aHeight )
  end constructor
  
  constructor _
    RectangleF( _
      byref aLocation as PointF, _
      byref aSize as SizeF )
    
    location => aLocation
    extents => aSize
  end constructor
  
  constructor _
    RectangleF( _
      byref aRectangle as Rectangle )
    
    this.constructor( _
      aRectangle.X, aRectangle.Y, _
      aRectangle.width, aRectangle.height )
    'location => PointF( _
    '  aRectangle.location.x, _
    '  aRectangle.location.y )
    'extents => SizeF( _
    '  aRectangle.extents.width, _
    '  aRectangle.extents.height )
  end constructor
  
  constructor _
    RectangleF( _
      byref aRectangle as RectangleF )
    
    this.constructor( _
      aRectangle.X, aRectangle.Y, _
      aRectangle.width, aRectangle.height )
    'location => PointF( _
    '  aRectangle.location.x, _
    '  aRectangle.location.y )
    'extents => SizeF( _
    '  aRectangle.extents.width, _
    '  aRectangle.extents.height )
  end constructor
  
  destructor _
    RectangleF()
  end destructor
  
  property _
    RectangleF.X() _
    as single
    
    return( location.x )
  end property
  
  property _
    RectangleF.X( byval value as single )
    
    location.x => value
  end property
  
  property _
    RectangleF.Y() _
    as single
    
    return( location.y )
  end property
  
  property _
    RectangleF.Y( byval value as single )
    
    location.y => value
  end property
  
  property _
    RectangleF.width() _
    as single
    
    return( extents.width )
  end property
  
  property _
    RectangleF.width( byval value as single )
    
    extents.width => value
  end property
  
  property _
    RectangleF.height() _
    as single
    
    return( extents.height )
  end property
  
  property _
    RectangleF.height( byval value as single )
    
    extents.height => value
  end property
  
  property _
    RectangleF.area() as single
    
    return( abs( extents.width * extents.height ) )
  end property
  
  function _
    RectangleF.isInsideOf( _
      byref another as Rectangle ) _
    as boolean
    
    return( cbool( _
      int( location.x ) - another.location.x >= 0 andAlso _
      int( location.x + extents.width ) - _
        another.location.x <= another.extents.width andAlso _
      int( location.y ) - another.location.y >= 0 andAlso _
      int( location.y + extents.height ) - _
        another.location.y <= another.extents.height ) )
  end function
  
  function _
    RectangleF.isInsideOf( _
      byref another as RectangleF ) _
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
    RectangleF.overlapsWith( _
      byref another as Rectangle ) _
    as boolean
    
    return( cbool( _
      int( location.x + extents.width ) >= another.location.x andAlso _
      int( location.y + extents.height ) >= another.location.y andAlso _
      int( location.x ) <= another.location.x + another.extents.width andAlso _
      int( location.y ) <= another.location.y + another.extents.height ) )
  end function
  
  function _
    RectangleF.overlapsWith( _
      byref another as RectangleF ) _
    as boolean
    
    return( cbool( _
      location.x + extents.width >= another.location.x andAlso _
      location.y + extents.height >= another.location.y andAlso _
      location.x <= another.location.x + another.extents.width andAlso _
      location.y <= another.location.y + another.extents.height ) )
  end function
  
  function _
    RectangleF.contains( _
      byref aPoint as Point ) _
    as boolean
    
    return( cbool( _
      aPoint.x >= location.x andAlso _
      aPoint.x <= location.x + extents.width - 1 andAlso _
      aPoint.y >= location.y andAlso _
      aPoint.y <= location.y + extents.height - 1 ) )
  end function
  
  function _
    RectangleF.contains( _
      byref aPoint as PointF ) _
    as boolean
    
    return( cbool( _
      aPoint.x >= location.x andAlso _
      aPoint.x <= location.x + extents.width - 1 andAlso _
      aPoint.y >= location.y andAlso _
      aPoint.y <= location.y + extents.height - 1 ) )
  end function
  
  function _
    RectangleF.contains( _
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
    RectangleF.contains( _
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
    RectangleF.scaleBy( _
      byref aSize as Size )
    
    scaleBy( aSize.width, aSize.height )
  end sub
  
  sub _
    RectangleF.scaleBy( _
      byref aSize as SizeF )
    
    scaleBy( aSize.width, aSize.height )
  end sub
  
  sub _
    RectangleF.scaleBy( _
      byval aSize as integer )
    
    scaleBy( aSize, aSize )
  end sub
  
  sub _
    RectangleF.scaleBy( _
      byval aSizeX as integer, _
      byval aSizeY as integer )
    
    var _
      newLocX => location.x * aSizeX, _
      newLocY => location.y * aSizeY, _
      newExtX => extents.width * aSizeX, _
      newExtY => extents.height * aSizeY, _
      center => location + extents.toPointF() / 2
    
    location.x => center.x - newExtX / 2
    location.y => center.y - newExtY / 2
    
    extents => SizeF( newExtX, newExtY )
  end sub
  
  sub _
    RectangleF.scaleBy( _
      byval aSize as single )
    
    scaleBy( aSize, aSize )
  end sub
  
  sub _
    RectangleF.scaleBy( _
      byval aSizeX as single, _
      byval aSizeY as single )
    
    var _
      newLocX => location.x * aSizeX, _
      newLocY => location.y * aSizeY, _
      newExtX => extents.width * aSizeX, _
      newExtY => extents.height * aSizeY, _
      center => location + extents.toPointF() / 2
    
    location.x => center.x - newExtX / 2
    location.y => center.y - newExtY / 2
    
    extents => SizeF( newExtX, newExtY )
  end sub
  
  function _
    RectangleF.scaledBy( _
      byref aSize as SizeF ) _
    as RectangleF
    
    return( scaledBy( aSize.width, aSize.height ) )
  end function
  
  function _
    RectangleF.scaledBy( _
      byval aSize as integer ) _
    as RectangleF
    
    return( scaledBy( aSize, aSize ) )
  end function
  
  function _
    RectangleF.scaledBy( _
      byval aSizeX as integer, _
      byval aSizeY as integer ) _
    as RectangleF
    
    var _
      r => RectangleF( location, extents )
    
    r.scaleBy( aSizeX, aSizeY )
    
    return( r )
  end function
  
  function _
    RectangleF.scaledBy( _
      byval aSize as single ) _
    as RectangleF
    
    return( scaledBy( aSize, aSize ) )
  end function
  
  function _
    RectangleF.scaledBy( _
      byval aSizeX as single, _
      byval aSizeY as single ) _
    as RectangleF
    
    var _
      r => RectangleF( location, extents )
    
    r.scaleBy( aSizeX, aSizeY )
    
    return( r )
  end function
  
  sub _
    RectangleF.displaceBy( _
      byref aPoint as Point )
    
    displaceBy( aPoint.x, aPoint.y )
  end sub
  
  sub _
    RectangleF.displaceBy( _
      byref aPoint as PointF )
    
    displaceBy( aPoint.x, aPoint.y )
  end sub
  
  sub _
    RectangleF.displaceBy( _
      byval anAmount as integer )
    
    location +=> anAmount
    extents -=> anAmount * 2
  end sub
  
  sub _
    RectangleF.displaceBy( _
      byval anAmountX as integer, _
      byval anAmountY as integer )
    
    location.x +=> anAmountX
    location.y +=> anAmountY
    extents.width -=> anAmountX * 2
    extents.height -=> anAmountY * 2
  end sub
  
  sub _
    RectangleF.displaceBy( _
      byval anAmount as single )
    
    location +=> anAmount
    extents -=> anAmount * 2
  end sub
  
  sub _
    RectangleF.displaceBy( _
      byval anAmountX as single, _
      byval anAmountY as single )
    
    location.x +=> anAmountX
    location.y +=> anAmountY
    extents.width -=> anAmountX * 2
    extents.height -=> anAmountY * 2
  end sub
  
  function _
    RectangleF.displacedBy( _
      byref aPoint as Point ) _
    as RectangleF
    
    return( displacedBy( aPoint.x, aPoint.y ) )
  end function
  
  function _
    RectangleF.displacedBy( _
      byref aPoint as PointF ) _
    as RectangleF
    
    return( displacedBy( aPoint.x, aPoint.y ) )
  end function
  
  function _
    RectangleF.displacedBy( _
      byval anAmount as integer ) _
    as RectangleF
    
    return( RectangleF( _
      location + anAmount, _
      extents - anAmount * 2 ) )
  end function
  
  function _
    RectangleF.displacedBy( _
      byval anAmountX as integer, _
      byval anAmountY as integer ) _
    as RectangleF
    
    return( RectangleF( _
      PointF( _
        location.x + anAmountX, _
        location.y + anAmountY ), _
      SizeF( _
        extents.width - anAmountX * 2, _
        extents.height - anAmountX * 2 ) ) )
  end function
  
  function _
    RectangleF.displacedBy( _
      byval anAmount as single ) _
    as RectangleF
    
    return( RectangleF( _
      location + anAmount, _
      extents - anAmount * 2 ) )
  end function
  
  function _
    RectangleF.displacedBy( _
      byval anAmountX as single, _
      byval anAmountY as single ) _
    as RectangleF
    
    return( RectangleF( _
      PointF( _
        location.x + anAmountX, _
        location.y + anAmountY ), _
      SizeF( _
        extents.width - anAmountX * 2, _
        extents.height - anAmountY * 2 ) ) )
  end function
  
  /'
    Now we can implement the rest of the PointF type that references the
    RectangleF type.
  '/
  function _
    PointF.isInsideOf( _
      byref aRectangle as RectangleF ) _
    as boolean
    
    return( cbool( _
      x >= aRectangle.location.x andAlso _
      x <= aRectangle.location.x + aRectangle.extents.width - 1 andAlso _
      y >= aRectangle.location.y andAlso _
      y <= aRectangle.location.y + aRectangle.extents.height - 1 ) )
  end function
  
  operator _
    RectangleF.cast() as string
    
    return( _
      "{" & location & ", " & extents & "}" )
  end operator
  
  operator _
    RectangleF.+=( _
      byref rhs as RectangleF )
    
    extents +=> rhs.extents
  end operator
  
  operator _
    RectangleF.+=( _
      byref rhs as integer )
      
    extents +=> rhs
  end operator
  
  operator _
    RectangleF.+=( _
      byref rhs as single )
      
    extents +=> rhs
  end operator
  
  operator _
    RectangleF.-=( _
      byref rhs as RectangleF )
    
    extents -=> rhs.extents
  end operator
  
  operator _
    RectangleF.-=( _
      byref rhs as integer )
      
    extents -=> rhs
  end operator
  
  operator _
    RectangleF.-=( _
      byref rhs as single )
      
    extents -=> rhs
  end operator
  
  operator _
    RectangleF.*=( _
      byref rhs as integer )
      
    extents *=> rhs
  end operator
  
  operator _
    RectangleF.*=( _
      byref rhs as single )
      
    extents *=> rhs
  end operator
  
  operator _
    RectangleF./=( _
      byref rhs as integer )
      
    extents /=> rhs
  end operator
  
  operator _
    RectangleF./=( _
      byref rhs as single )
      
    extents /=> rhs
  end operator
  
  operator _
    RectangleF.\=( _
      byref rhs as integer )
      
    extents \=> rhs
  end operator
  
  operator _
    =( _
      byref lhs as RectangleF, _
      byref rhs as RectangleF ) _
    as integer
    
    return( _
      lhs.location = rhs.location andAlso _
      lhs.extents = rhs.extents )
  end operator
  
  operator _
    <>( _
      byref lhs as RectangleF, _
      byref rhs as RectangleF ) _
    as integer
    
    return( _
      lhs.location <> rhs.location orElse _
      lhs.extents <> rhs.extents )
  end operator
  
  operator _
    >( _
      byref lhs as RectangleF, _
      byref rhs as RectangleF ) _
    as integer
    
    return( _
      lhs.area > rhs.area )
  end operator
  
  operator _
    >=( _
      byref lhs as RectangleF, _
      byref rhs as RectangleF ) _
    as integer
    
    return( _
      lhs.area >= rhs.area )
  end operator
  
  operator _
    <( _
      byref lhs as RectangleF, _
      byref rhs as RectangleF ) _
    as integer
    
    return( _
      lhs.area < rhs.area )
  end operator
  
  operator _
    <=( _
      byref lhs as RectangleF, _
      byref rhs as RectangleF ) _
    as integer
    
    return( _
      lhs.area <= rhs.area )
  end operator
  
  operator _
    +( _
      byref lhs as RectangleF, _
      byref rhs as Point ) _
    as RectangleF
    
    return( RectangleF( _
      lhs.location + PointF( rhs.x, rhs.y ), _
      lhs.extents ) )
  end operator
  
  operator _
    +( _
      byref lhs as RectangleF, _
      byref rhs as PointF ) _
    as RectangleF
    
    return( RectangleF( _
      lhs.location + rhs, _
      lhs.extents ) )
  end operator
  
  operator _
    +( _
      byref lhs as RectangleF, _
      byref rhs as Size ) _
    as RectangleF
    
    return( RectangleF( _
      lhs.location, _
      lhs.extents + SizeF( rhs.width, rhs.height ) ) )
  end operator
  
  operator _
    +( _
      byref lhs as RectangleF, _
      byref rhs as SizeF ) _
    as RectangleF
    
    return( RectangleF( _
      lhs.location, _
      lhs.extents + rhs ) )
  end operator
  
  operator _
    -( _
      byref lhs as RectangleF, _
      byref rhs as Point ) _
    as RectangleF
    
    return( RectangleF( _
      lhs.location - PointF( rhs.x, rhs.y ), _
      lhs.extents ) )
  end operator
  
  operator _
    -( _
      byref lhs as RectangleF, _
      byref rhs as PointF ) _
    as RectangleF
    
    return( RectangleF( _
      lhs.location - rhs, _
      lhs.extents ) )
  end operator
  
  operator _
    -( _
      byref lhs as RectangleF, _
      byref rhs as Size ) _
    as RectangleF
    
    return( RectangleF( _
      lhs.location, _
      lhs.extents - SizeF( rhs.width, rhs.height ) ) )
  end operator
  
  operator _
    -( _
      byref lhs as RectangleF, _
      byref rhs as SizeF ) _
    as RectangleF
    
    return( RectangleF( _
      lhs.location, _
      lhs.extents - rhs ) )
  end operator
  
  /'
    Copy constructor for Rectangle from RectangleF
  '/
  constructor _
    Rectangle( _
      byref aRectangle as RectangleF )
    
    this.constructor( _
      aRectangle.X, aRectangle.Y, _
      aRectangle.width, aRectangle.height )
  end constructor
  
  function _
    Rectangle.isInsideOf( _
      byref another as RectangleF ) _
    as boolean
    
    return( cbool( _
      location.x - int( another.location.x ) >= 0 andAlso _
      location.x + extents.width - _
        int( another.location.x ) <= int( another.extents.width ) andAlso _
      location.y - int( another.location.y ) >= 0 andAlso _
      location.y + extents.height - _
        int( another.location.y ) <= int( another.extents.height ) ) )
  end function
  
  function _
    Rectangle.overlapsWith( _
      byref another as RectangleF ) _
    as boolean
    
    return( cbool( _
      location.x + extents.width >= int( another.location.x ) andAlso _
      location.y + extents.height >= int( another.location.y ) andAlso _
      location.x <= int( another.location.x + another.extents.width ) andAlso _
      location.y <= int( another.location.y + another.extents.height ) ) )
  end function
end namespace

#endif
