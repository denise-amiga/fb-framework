#ifndef __FB_XML_XMLATTRIBUTE__
#define __FB_XML_XMLATTRIBUTE__

/'
  Represents a Xml attribute
'/
namespace Xml
  type _
    XmlAttribute _
    extends XmlNode
    
    public:
      declare constructor( _
        byref as const StringType, _
        byref as StringType )
      declare destructor()
      
      as StringType _
        value
      
    private:
      declare constructor()
  end type
  
  constructor _
    XmlAttribute()
  end constructor
  
  constructor _
    XmlAttribute( _
      byref aName as const StringType, _
      byref aValue as StringType )
    
    _name => aName
    _nodeType => XmlNodeType.Attribute
    value => aValue
  end constructor
  
  destructor _
    XmlAttribute()
  end destructor
end namespace

#endif
