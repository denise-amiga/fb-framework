#ifndef __FBFW_XML_ELEMENT__
#define __FBFW_XML_ELEMENT__

namespace Xml
  /'
    Represents a Xml element
  '/
  type _
    XmlElement _
    extends XmlNode
    
    public:
      declare constructor( _
        byval as XmlNodeType )
      declare constructor( _
        byref as const StringType, _
        byval as XmlNodeType )
      declare virtual destructor() override
      
      declare property _
        childNodes() byref as XmlNodeList
      declare property _
        attributes() byref as XmlAttributeCollection
      
      declare virtual property _
        hasAttributes() as boolean override
      declare virtual property _
        hasChildNodes() as boolean override
        
      as StringType _
        content
      
    protected:
      declare constructor()
    
    private:
      as XmlNodeList _
        _childNodes
      as XmlAttributeCollection _
        _attributes
  end type
  
  constructor _
    XmlElement()
  end constructor
  
  constructor _
    XmlElement( _
      byval aNodeType as XmlNodeType )
    
    _nodeType => aNodeType
  end constructor
  
  constructor _
    XmlElement( _
      byref aName as const StringType, _
      byval aNodeType as XmlNodeType )
    
    _name => aName
    _nodeType => aNodeType
  end constructor
  
  destructor _
    XmlElement()
  end destructor
  
  property _
    XmlElement.childNodes() _
    byref as XmlNodeList
    
    return( _childNodes )
  end property
  
  property _
    XmlElement.attributes() _
    byref as XmlAttributeCollection
    
    return( _attributes )
  end property
  
  property _
    XmlElement.hasAttributes() _
    as boolean
    
    return( cbool( _attributes.count > 0 ) )
  end property
  
  property _
    XmlElement.hasChildNodes() _
    as boolean
    
    return( cbool( _childNodes.count > 0 ) )
  end property
  
  operator _
    XmlNode.cast() _
    as XmlElement ptr
    
    return( cptr( XmlElement ptr, @this ) )
  end operator
end namespace

#endif
