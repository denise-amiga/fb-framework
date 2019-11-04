#ifndef __FB_XML_XMLNODE__
#define __FB_XML_XMLNODE__

#include once "parsing.bi"

/'
  Base class for all Xml nodes
'/
namespace Xml
  type as XmlElement _
    __XmlElement
  
  type _
    XmlNode _
    extends Object
    
    public:
      declare virtual destructor()
      
      declare operator _
        cast() as __XmlElement ptr
      
      declare property _
        name() as StringType
      declare property _
        nodeType() as XmlNodeType
      declare virtual property _
        hasAttributes() as boolean
      declare virtual property _
        hasChildNodes() as boolean
      
    protected:
      declare constructor()
      
      as StringType _
        _name
      as XmlNodeType _
        _nodeType => XmlNodeType.None
  end type
  
  constructor _
    XmlNode()
  end constructor
  
  destructor _
    XmlNode()
  end destructor
  
  property _
    XmlNode.name() _
    as StringType
    
    return( _name )
  end property
  
  property _
    XmlNode.nodeType() _
    as XmlNodeType
    
    return( _nodeType )
  end property
  
  property _
    XmlNode.hasAttributes() _
    as boolean
    
    return( false )
  end property
  
  property _
    XmlNode.hasChildNodes() _
    as boolean
    
    return( false )
  end property
end namespace

#endif
