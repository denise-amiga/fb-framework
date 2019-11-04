#ifndef __FB_XML__
#define __FB_XML__

#include once "events.bi"
#include once "parsing.bi"

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
#include once "xml/xml-node.bi"
#include once "xml/xml-node-list.bi"
#include once "xml/xml-attribute.bi"
#include once "xml/xml-attribute-collection.bi"
#include once "xml/xml-element.bi"
#include once "xml/xml-document-root.bi"
#include once "xml/xml-parse-utils.bi"
#include once "xml/xml-parse-context.bi"
#include once "xml/xml-parse-functions.bi"
#include once "xml/xml-document.bi"
#include once "xml/xml-helper.bi"

#endif
