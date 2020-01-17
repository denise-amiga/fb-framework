#ifndef __FBFW_XML__
#define __FBFW_XML__

#include once "fbfw-events.bi"
#include once "fbfw-parsing.bi"

/'
  Xml framework.
  
  10/28/2019
    Initial version. Very basic functionality (just reading a Xml document).
    Added support for events.
'/
namespace Xml
  type as Parsing.StringType _
    StringType
  
  const _
    XmlNull => 0
  
  enum _
    XmlNodeType
    
    Attribute
    CDATA
    Comment
    Declaration
    Document
    DocumentRoot
    Element
    None
    ProcessingInstruction
  end enum
end namespace

/'
  Base parser and procedural interface
'/
__include__( __FBFW_XML_FOLDER__, xml-node.bi )
__include__( __FBFW_XML_FOLDER__, xml-node-list.bi )
__include__( __FBFW_XML_FOLDER__, xml-attribute.bi )
__include__( __FBFW_XML_FOLDER__, xml-attribute-collection.bi )
__include__( __FBFW_XML_FOLDER__, xml-element.bi )
__include__( __FBFW_XML_FOLDER__, xml-document-root.bi )
__include__( __FBFW_XML_FOLDER__, xml-parse-utils.bi )
__include__( __FBFW_XML_FOLDER__, xml-parse-context.bi )
__include__( __FBFW_XML_FOLDER__, xml-parse-functions.bi )
__include__( __FBFW_XML_FOLDER__, xml-document.bi )
__include__( __FBFW_XML_FOLDER__, xml-helper.bi )

#endif
