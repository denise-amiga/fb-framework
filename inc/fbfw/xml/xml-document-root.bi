#ifndef __FBFW_XML_DOCUMENT_ROOT__
#define __FBFW_XML_DOCUMENT_ROOT__

namespace Xml
  /'
    Represents the root node for the Xml document hierarchy.
    
    Note that this node is not the same as the 'document element', which
    contains the outermost Xml element. This is simply an abstraction that
    will contain all the Xml nodes for a document once parsed.
  '/
  type _
    XmlDocumentRoot _
    extends XmlElement
    
    public:
      declare constructor()
      declare virtual destructor() override
      
      declare function _
        getDocumentElement() _
        as XmlElement ptr
  end type
  
  constructor _
    XmlDocumentRoot()
    
    _name => "<root>"
    _nodeType => XmlNodeType.DocumentRoot
  end constructor
  
  destructor _
    XmlDocumentRoot()
  end destructor
  
  function _
    XmlDocumentRoot.getDocumentElement() _
    as XmlElement ptr
    
    dim as XmlElement ptr _
      documentElement
    
    if( base.hasChildNodes ) then
      var _
        node => childNodes.first
      
      for _
        i as integer => 0 _
        to childNodes.count - 1
        
        if( node->item->nodeType = XmlNodeType.Element ) then
          documentElement => cptr( _
            XmlElement ptr, node->item )
          exit for
        end if
        
        node => node->forward
      next
    end if
    
    return( documentElement )
  end function
end namespace

#endif
