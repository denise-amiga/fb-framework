#ifndef __FBFW_COLOR_SPACES__
#define __FBFW_COLOR_SPACES__

namespace Drawing
  type as FbColor _
    FbColor_
  
  type _
    HSVAColor
    
    declare constructor()
    declare constructor( _
      byval as ubyte, _
      byval as ubyte, _
      byval as ubyte, _
      byval as ubyte => 255 )
    declare destructor()
    
    as ubyte _
      H, S, V, A
  end type
  
  constructor _
    HSVAColor()
  end constructor
  
  constructor _
    HSVAColor( _
      byval aH as ubyte, _
      byval aaS as ubyte, _
      byval aV as ubyte, _
      byval aA as ubyte => 255 )
    
    H => aH
    S => aaS
    V => aV
    A => aA
  end constructor
  
  destructor _
    HSVAColor()
  end destructor
  
  type _
    HSLAColor
    
    declare constructor()
    declare constructor( _
      byval as ubyte, _
      byval as ubyte, _
      byval as ubyte, _
      byval as ubyte => 255 )
    declare destructor()
    
    as ubyte _
      H, S, L, A
  end type
  
  constructor _
    HSLAColor()
  end constructor
  
  constructor _
    HSLAColor( _
      byval aH as ubyte, _
      byval aaS as ubyte, _
      byval aL as ubyte, _
      byval aA as ubyte => 255 )
    
    H => aH
    S => aaS
    L => aL
    A => aA
  end constructor
  
  destructor _
    HSLAColor()
  end destructor
  
  type _
    HCYAColor
    
    declare constructor()
    declare constructor( _
      byval as ubyte, _
      byval as ubyte, _
      byval as ubyte, _
      byval as ubyte => 255 )
    declare destructor()
    
    as ubyte _
      H, C, Y, A
  end type
  
  constructor _
    HCYAColor()
  end constructor
  
  constructor _
    HCYAColor( _
      byval aH as ubyte, _
      byval aC as ubyte, _
      byval aY as ubyte, _
      byval aA as ubyte => 255 )
    
    H => aH
    C => aC
    Y => aY
    A => aA
  end constructor
  
  destructor _
    HCYAColor()
  end destructor
end namespace

#endif
