#include once "xml.bi"

sub _
  xmlDoc_documentLoaded( _
    byref sender as Xml.XmlDocument, _
    byref e as Events.EventArgs )
  
  ? "Document was loaded and parsed."
  
  if( sender.malformed ) then
    ? "It is, unfortunately, malformed."
  end if
  
  ?
end sub

sub _
  showNodesOf( _
    byval aNode as Xml.XmlElement ptr )
  
  ? aNode->name & iif( aNode->content <> "", _
    " : " & aNode->content, "" ) 
  
  if( aNode->hasAttributes ) then
    var _
      anAttribute => aNode->attributes.first
    
    for _
      i as integer => 0 _
      to aNode->attributes.count - 1
      
      ? "  " & anAttribute->item->name & " : " _
        & anAttribute->item->value
      
      anAttribute => anAttribute->forward
    next
  end if
  
  if( aNode->hasChildNodes ) then
    var _
      childNode => aNode->childNodes.first
    
    for _
      i as integer => 0 _
      to aNode->childNodes.count - 1
      
      showNodesOf( *childNode->item )
      
      childNode => childNode->forward
    next
  end if
end sub

/'
  Xml loading and parsing example
'/
'' Instantiate a XmlDocument
var _
  xmlDoc => Xml.XmlDocument() _

/'
  We're going to add a handler just so it tells us whether it loaded
  the document or not, and if it is malformed.
'/
xmlDoc.addHandler( _
  xmlDoc.documentLoaded, _
  asHandler( xmlDoc_documentLoaded ) )

'' Load the Xml text
xmlDoc.loadXml( _
  Parsing.Strings.fromFile( "res/test.xml" ) )

/'
  And then check: if the document has child nodes and is not malformed,
  display its nodes starting at the document element (the outermost
  element from the Xml).
'/
if( _
  xmlDoc.hasChildNodes andAlso _
  not xmlDoc.malformed ) then
  
  var _
    root => xmlDoc.documentElement
  
  ? "Nodes of the document element: "
  showNodesOf( root )
end if

/'
  Another usage: we're going to use the provided convenience functions
  to parse the contents of the elements directly into FreeBasic standard
  data types.
'/
?
xmlDoc.loadXml( _
  Parsing.Strings.fromFile( "res/data-types.xml" ) )

if( _
  xmlDoc.hasChildNodes andAlso _
  not xmlDoc.malformed ) then
  
  var _
    root => xmlDoc.documentElement
  
  ?
  ? Xml.stringElement( "string", root )
  ? Xml.integerElement( "integer", root )
  ? Xml.longIntElement( "longint", root )
  ? Xml.floatElement( "float", root )
  ? Xml.doubleElement( "double", root )
  ? Xml.boolElement( "bool", root ) 
end if

sleep()
