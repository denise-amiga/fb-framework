#ifndef __FB_MATH_TRANSFORM2D__
#define __FB_MATH_TRANSFORM2D__

namespace Math
  type _
    Transform2D
    
    public:
      declare constructor( _
        byref as const Math.float3 => _
          Math.float3( 0.0, 0.0, 1.0 ), _
        byref as const Math.float3 => _
          Math.float3( 1.0, 1.0, 1.0 ), _
        byval as const Math.float => 0.0 )
      declare destructor()
      
      declare operator _
        cast() byref as Math.mat3
      
      declare property _
        getU() as Math.float3
      declare property _
        getV() as Math.float3
      declare property _
        translation() as Math.float3
      declare property _
        scaling() as Math.float3
      declare property _
        rotation() as Math.degrees
      declare property _
        rotationOrigin() as Math.float3
      declare property _
        scaleOrigin() as Math.float3
      declare property _
        inverse() as Math.mat3
      declare property _
        parent() as Math.Transform2D ptr
      
      declare function _
        setParent( _
          byval as Math.Transform2D ptr ) _
        as Math.Transform2D ptr
      declare function _
        translate( _
          byref as const Math.float3 ) _
        as Math.Transform2D ptr
      declare function _
        setTranslation( _
          byref as const Math.float3 ) _
        as Math.Transform2D ptr
      declare function _
        scale( _
          byref as const Math.float3 ) _
        as Math.Transform2D ptr
      declare function _
        setScaling( _
          byref as const Math.float3 ) _
        as Math.Transform2D ptr
      declare function _
        rotate( _
          byval as const Math.degrees ) _
        as Math.Transform2D ptr
      declare function _
        setRotation( _
          byval as const Math.degrees ) _
        as Math.Transform2D ptr
      declare function _
        setScaleOrigin( _
          byref as const Math.float3 ) _
        as Math.Transform2D ptr
      declare function _
        setRotationOrigin( _
          byref as const Math.float3 ) _
        as Math.Transform2D ptr
      declare function _
        apply( _
          byref as const Math.mat3 ) _
        as Math.Transform2D ptr
      declare function _
        set( _
          byref as const Math.mat3 ) _
        as Math.Transform2D ptr
      
    private:
      declare sub _
        rebuild()
      
      as boolean _
        m_needsRebuilding, _
        m_needsRecomputeInverse
      as Math.Transform2D ptr _
        m_parent
      as Math.mat3 _
        m_transform => Math.mat3( _
          1.0, 0.0, 0.0, _
          0.0, 1.0, 0.0, _
          0.0, 0.0, 1.0 ), _
        m_other => Math.mat3( _
          1.0, 0.0, 0.0, _
          0.0, 1.0, 0.0, _
          0.0, 0.0, 1.0 ), _
        m_invTransform
      as Math.float3 _
        m_position, _
        m_scale, _
        m_scaleOrigin => Math.float3( 0.0, 0.0, 1.0 ), _
        m_rotateOrigin => Math.float3( 0.0, 0.0, 1.0 )
      as Math.degrees _
        m_angle
  end type
  
  constructor _
    Transform2D( _
      byref aPosition as const Math.float3 => _
        Math.float3( 0.0, 0.0, 1.0 ), _
      byref aScale as const Math.float3 => _
        Math.float3( 1.0, 1.0, 1.0 ), _
      byval aRotationAngle as const Math.float => 0.0 )
    
    m_position => aPosition
    m_scale => aScale
    m_angle => aRotationAngle
    
    rebuild()
  end constructor
  
  destructor _
    Transform2D()
  end destructor
  
  operator _
    Transform2D.cast() _
    byref as Math.mat3
    
    if( m_needsRebuilding ) then
      rebuild()
    end if
    
    return( m_transform )
  end operator
  
  property _
    Transform2D.getU() _
    as Math.float3
    
    if( m_needsRebuilding ) then
      rebuild()
    end if
    
    return( Math.float3( _
      m_transform.a, _
      m_transform.d, _
      m_transform.g ) )
  end property
  
  property _
    Transform2D.getV() _
    as Math.float3
    
    if( m_needsRebuilding ) then
      rebuild()
    end if
    
    return( Math.float3( _
      m_transform.b, _
      m_transform.e, _
      m_transform.h ) )
  end property
  
  property _
    Transform2D.parent() _
    as Math.Transform2D ptr
    
    return( m_parent )
  end property
  
  property _
    Transform2D.translation() _
    as Math.float3
    
    return( m_position )
  end property
  
  property _
    Transform2D.scaling() _
    as Math.float3
    
    return( m_scale )
  end property
  
  property _
    Transform2D.rotation() _
    as Math.degrees
    
    return( m_angle )
  end property
  
  property _
    Transform2D.inverse() _
    as Math.mat3
    
    if( m_needsRecomputeInverse ) then
      if( m_needsRebuilding ) then
        rebuild()
      end if
      
      m_invTransform => Math.inverse( m_transform )
      m_needsRecomputeInverse => false
    end if
    
    return( m_invTransform )
  end property
  
  function _
    Transform2D.setParent( _
      byval aParent as Math.Transform2D ptr ) _
    as Math.Transform2D ptr
    
    m_parent => aParent
    
    return( @this )
  end function
  
  function _
    Transform2D.translate( _
      byref offset as const Math.float3 ) _
    as Math.Transform2D ptr
    
    m_position.x +=> offset.x
    m_position.y +=> offset.y
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  function _
    Transform2D.setTranslation( _
      byref aPosition as const Math.float3 ) _
    as Math.Transform2D ptr
    
    m_position.x => aPosition.x
    m_position.y => aPosition.y
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  function _
    Transform2D.scale( _
      byref aScale as const Math.float3 ) _
    as Math.Transform2D ptr
    
    m_scale.x +=> aScale.x
    m_scale.y +=> aScale.y
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  function _
    Transform2D.setScaling( _
      byref aScale as const Math.float3 ) _
    as Math.Transform2D ptr
    
    m_scale.x => aScale.x
    m_scale.y => aScale.y
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  function _
    Transform2D.rotate( _
      byval anAngle as const Math.degrees ) _
    as Math.Transform2D ptr
    
    m_angle => Math.fmod( m_angle + anAngle, 360.0 )
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  function _
    Transform2D.setScaleOrigin( _
      byref anOrigin as const Math.float3 ) _
    as Math.Transform2D ptr
    
    m_scaleOrigin => Math.float3( _
      anOrigin.x, _
      anOrigin.y, _
      1.0 )
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  function _
    Transform2D.setRotationOrigin( _
      byref anOrigin as const Math.float3 ) _
    as Math.Transform2D ptr
    
    m_rotateOrigin = Math.float3( _
      anOrigin.x, _
      anOrigin.y, _
      1.0 )
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  function _
    Transform2D.setRotation( _
      byval anAngle as const Math.degrees ) _
    as Math.Transform2D ptr
    
    m_angle => Math.fmod( anAngle, 360.0 )
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  function _
    Transform2D.apply( _
      byref aTransform as const Math.mat3 ) _
    as Math.Transform2D ptr
    
    m_other => aTransform * m_other
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  function _
    Transform2D.set( _
      byref aTransform as const Math.mat3 ) _
    as Math.Transform2D ptr
    
    m_other => aTransform
    m_needsRebuilding => true
    
    return( @this )
  end function
  
  sub _
    Transform2D.rebuild()
    
    dim as float _
      c => cos( Math.toRadians( m_angle ) ), _
      s => sin( Math.toRadians( m_angle ) )
    
    '' Translation transform
    var TT => Math.mat3( _
      1.0, 0.0, m_position.x, _
      0.0, 1.0, m_position.y, _
      0.0, 0.0, 1.0 _
      )
    '' Scale transform
    var ST => Math.mat3( _
      m_scale.x, 0.0, -m_scaleOrigin.x * m_scale.x + m_scaleOrigin.x, _
      0.0, m_scale.y, -m_scaleOrigin.y * m_scale.y + m_scaleOrigin.y, _
      0.0, 0.0, 1.0 _
      )
    '' Rotate transform
    var RT => Math.mat3( _
      c, -s, -m_rotateOrigin.x * c + m_rotateOrigin.y * s + m_rotateOrigin.x, _
      s,  c, -m_rotateOrigin.x * s - m_rotateOrigin.y * c + m_rotateOrigin.y, _
      0.0, 0.0, 1.0 _
      )
    
    '' Final composed transform matrix
    if( m_parent <> Math.Nil ) then
      m_transform => *m_parent * TT * ST * RT * m_other
    else
      m_transform => TT * ST * RT * m_other
    end if
    
    m_needsRebuilding => false
    m_needsRecomputeInverse => true
  end sub
  
  /'
    Represents a decomposed 3x3 matrix.
    
    The class decomposes a 3x3 matrix into its translational, rotational,
    scaling and skewing components.
  '/
  type DecomposedMatrix3
    public:
      declare constructor( _
        byref as Math.mat3 )
      declare destructor()
      
      declare property _
        translationX() as Math.float
      declare property _
        translationY() as Math.float
      declare property _
        scaleX() as Math.float
      declare property _
        scaleY() as Math.float
      declare property _
        skewX() as Math.float
      declare property _
        skewY() as Math.float
      declare property _
        rotation() as Math.float
      
    private:
      declare constructor()
      
      as Math.float _
        m_translationX, m_translationY, _
        m_scaleX, m_scaleY, _
        m_rotation, _
        m_skewX, m_skewY
  end type
  
  constructor _
    DecomposedMatrix3()
  end constructor
  
  constructor _
    DecomposedMatrix3( _
      byref M as Math.mat3 )
    
    /'
      M          SVG
      a b c      a c e
      d e f  =>  b d f
      0 0 1      0 0 1
    '/
    dim as Math.float _
      a => M.a, _
      b => M.d, _
      c => M.b, _
      d => M.e, _
      e => M.c, _
      f => M.f, _
      delta => a * d - b * c
    
    m_translationX => e
    m_translationY => f
  
    if( a <> 0.0 orElse b <> 0.0 ) then
      dim as Math.float _
        r => sqr( a * a + b * b )
      m_rotation => Math.toDegrees( _
        iif( b > 0.0, acos( a / r ), -acos( a / r ) ) )
      m_scaleX => r
      m_scaleY => delta / r
      m_skewX => atn( ( a * c + b * d ) / ( r * r ) )
      m_skewY => 0.0
    elseif( c <> 0.0 orElse d <> 0.0 ) then
      dim as Math.float _
        s=> sqr( c * c + d * d )
      m_rotation => Math.toDegrees( _
        Math.HalfPi - iif( d > 0.0, acos( -c / s ), -acos( c / s ) ) )
      m_scaleX => delta / s
      m_scaleY => s
      m_skewX => 0.0
      m_skewY => atn( ( a * c + b * d ) / ( s * s ) )
    end if
  end constructor
  
  destructor _
    DecomposedMatrix3()
  end destructor
  
  property _
    DecomposedMatrix3.translationX() _
    as Math.float
    
    return( m_translationX )
  end property
  
  property _
    DecomposedMatrix3.translationY() _
    as Math.float
    
    return( m_translationY )
  end property
  
  property _
    DecomposedMatrix3.scaleX() _
    as Math.float
    
    return( m_scaleX )
  end property
  
  property _
    DecomposedMatrix3.scaleY() _
    as Math.float
    
    return( m_scaleY )
  end property
  
  property _
    DecomposedMatrix3.skewX() _
    as Math.float
    
    return( m_skewX )
  end property
  
  property _
    DecomposedMatrix3.skewY() _
    as Math.float
    
    return( m_skewY )
  end property
  
  property _
    DecomposedMatrix3.rotation() _
    as Math.float
    
    return( m_rotation )
  end property
end namespace

#endif
