#ifndef __FBFW_XML_PARSE_FUNCTIONS__
#define __FBFW_XML_PARSE_FUNCTIONS__

/'
  Standard implementations for Xml parsing functions.
  
  Provided both for reference and to have a functional, albeit
  simplistic, Xml parser.
'/
namespace Xml
  function _
    parseNewLine( _
      byref context as XmlParseContext, _
      byval position as uinteger ) _
    as uinteger
    
    dim as ubyte ptr _
      aChar => @context.subject[ position - 1 ]
    
    if( *aChar = Parsing.SpecialChars.Cr ) then
      if( _
        cbool( position < len( context.subject ) ) andAlso _
        cbool( *( aChar + 1 ) = Parsing.SpecialChars.Lf ) ) then
        
        position +=> 1
      end if
      
      context.lineNumber +=> 1
      context.charPos => 1
    else
      if( *aChar = Parsing.SpecialChars.Lf ) then
        context.lineNumber +=> 1
        context.charPos => 1
      end if
    end if
    
    return( position )
  end function
  
  /'
    Outermost parse function.
    
    Parsing of the document starts with this function, passing it a parsing
    context, and the starting position (usually 1 at the start of the parsing).
    The FreeBasic standard convention is used for all parsing functions (ie
    strings start at 1, not 0).
  '/
  function _
    parseTags( _
      byref context as XmlParseContext, _
      byval node as XmlElement ptr, _
      byval position as uinteger => 1, _
      byref closeTag as const string => "" ) _
    as uinteger
    
    do while( _
      cbool( position < len( context.subject ) ) andAlso _
      not context.isMalformed andAlso _
      not match( _
        context.subject, _
        closeTag, _
        position ) )
      
      '' Get the index for the opening tag
      dim as integer _
        index => context.getTagIndexAt( position )
      
      /'
        If a tag has been found, call the appropriate parsing function. Note that it also
        skips the opening tag so the function can start parsing right away.
      '/
      if( index >= 0 ) then
        position => context.parseFunction[ index ]( _
          context, _
          node, _
          context.elementTag[ index ], _
          context.closeTag[ index ], _
          position + len( context.elementTag[ index ] ) )
      else
        'if( not isWhiteSpace( _
        '  char( context.subject, position ) ) ) then
        '  
        '  context.isMalformed => true
        'end if
        'context.isMalformed => true
        'return( position )
      end if
      
      /'
        Advance the position to the next char. Note that this implies that
        any markup that's not recognized will be silently ignored.
      '/
      position +=> 1
    loop
    
    return( position )
  end function
  
  /'
    Parses a XML comment
  '/
  function _
    parseComment( _
      byref context as XmlParseContext, _
      byval node as XmlElement ptr, _
      byref elementTag as const StringType, _
      byref closeTag as const StringType, _
      byval position as uinteger ) _
    as uinteger
    
    dim as StringType _
      result
    
    do while( _
      cbool( position < len( context.subject ) ) andAlso _
      not match( _
        context.subject, _
        closeTag, _
        position ) )
      
      '' Consume the comment char as-is
      result +=> char( _
        context.subject, position )
      
      position +=> 1
    loop
    
    /'
      Add the comment text to the node contents.
      
      This is not required but advised by the XML Recommendation.
    '/
    var _
      newElement => new XMLElement( XmlNodeType.Comment )
    
    newElement->content => result
    
    node->childNodes.append( newElement )
    
    '' Skip the closing tag
    return( position + len( closeTag ) )
  end function
  
  /'
    Parses a XML Processing Instruction (PI)
  '/
  function _
    parseInstruction( _
      byref context as XmlParseContext, _
      byval node as XmlElement ptr, _
      byref elementTag as const StringType, _
      byref closeTag as const StringType, _
      byval position as uinteger ) _
    as uinteger
    
    dim as StringType _
      result
    
    do while( _
      cbool( position < len( context.subject ) ) andAlso _
      not match( _
        context.subject, _
        closeTag, _
        position ) )
      
      '' Consume the instruction data as-is
      result +=> char( _
        context.subject, position )
      
      position +=> 1
    loop
    
    '' Add the element to the node contents
    var _
      newElement => new XMLElement( XmlNodeType.ProcessingInstruction )
    
    newElement->content => result
    
    node->childNodes.append( newElement )
    
    '' Skip the closing tag
    return( position + len( closeTag ) )
  end function
  
  /'
    Parses a XML declaration
  '/
  function _
    parseDeclaration( _
      byref context as XmlParseContext, _
      byval node as XmlElement ptr, _
      byref elementTag as const StringType, _
      byref closeTag as const StringType, _
      byval position as uinteger ) _
    as uinteger
    
    dim as StringType _
      result
    
    do while( _
      cbool( position < len( context.subject ) ) andAlso _
      not match( _
        context.subject, _
        closeTag, _
        position ) )
      
      '' Consume the declaration data as-is
      result +=> char( _
        context.subject, position )
      
      position +=> 1
    loop
    
    '' Add element to the node's content
    var _
      newElement => new XMLElement( XmlNodeType.Declaration )
    
    newElement->content => result
    
    node->childNodes.append( newElement )
    
    '' Skip the closing tag
    return( position + len( closeTag ) )
  end function
  
  /'
    Parses a XML CDATA block
  '/
  function _
    parseCDATA( _
      byref context as XmlParseContext, _
      byval node as XmlElement ptr, _
      byref elementTag as const StringType, _
      byref closeTag as const StringType, _
      byval position as uinteger ) _
    as uinteger
    
    dim as StringType _
      result
    
    do while( _
      cbool( position < len( context.subject ) ) andAlso _
      not match( _
        context.subject, _
        closeTag, _
        position ) )
      
      /'
        Consume the CDATA block as-is. This is important, because
        normally CDATA blocks are used to embed binary data such as
        images into the document.
      '/
      result +=> char( _
        context.subject, position )
      
      position +=> 1
    loop
    
    '' Add the element to the node's content
    var _
      newElement => new XMLElement( XmlNodeType.CDATA )
    
    newElement->content => result
    
    node->childNodes.append( newElement )
    
    '' Skip the closing tag
    return( position + len( closeTag ) )
  end function
  
  /'
    Parse a single XML element attribute
  '/
  function _
    parseAttribute( _
      byref context as XmlParseContext, _
      byval node as XmlElement ptr, _
      byval position as uinteger ) _
    as uinteger
    
    dim as StringType _
      attributeName, _
      attributeValue
    
    '' Skip white space before the attribute
    position => skipWhiteSpace( _
      context.subject, _
      position )
    
    '' Get the name of the attribute
    position => getString( _
      context.subject, _
      "=", _
      position, _
      attributeName )
    
    /'
      See which delimiter is used to signal the attribute's
      value (' or ").
    '/
    position +=> 1
    
    dim as StringType _
      delimiter => char( context.subject, position )
    
    /'
      Skips equals sign and attribute value open quote and retrieve 
      the string containing the value.
    '/
    position => getString( _
      context.subject, _
      delimiter, _
      position + 1, _
      attributeValue )
    
    /'
      Add the attribute to the element. Note that it also replaces
      any escaped char within the attribute value as per the XML 
      Recommendation.
    '/
    var _
      newAttribute => new XMLAttribute( _
        attributeName, _
        replaceEscapedChars( attributeValue ) )
    
    node->attributes.append( newAttribute )
    
    '' Skip the attribute value closing quote
    return( position + 1 )
  end function
  
  /'
    Parses the attributes of an element
  '/
  function _
    parseElementAttributes( _
      byref context as XmlParseContext, _
      byval node as XmlElement ptr, _
      byval position as uinteger ) _
    as uinteger
    
    do while( _
      cbool( position < len( context.subject ) ) andAlso _
      not within( _
        char( context.subject, position ), _
        "/><" ) )
        
      '' Parse the attribute
      position => parseAttribute( _
        context, _
        node, _
        position )
      
      '' Skip white space after attribute
      position => skipWhiteSpace( _
        context.subject, _
        position )
    loop
    
    /'
      Return the position as-is, since attributes are part of XML elements 
      and these have several different parsing rules, depending on if it's
      empty (it doesn't have any content) and how you express this fact.
      According to the XML Recommendation, all these constitute valid empty
      elements:
      
      <empty align="left" />
      <empty></empty>
      <empty/>
      
      Therefore, further processing is needed to determine this at the lower
      level parsing function.
    '/
    return( position )
  end function
  
  /'
    Parses the content of an XML element
  '/
  function _
    parseElementContent( _
      byref context as XmlParseContext, _
      byval node as XmlElement ptr, _
      byref elementTag as const StringType, _
      byref closeTag as const StringType, _
      byval position as uinteger ) _
    as uinteger
    
    dim as StringType _
      content
    
    do while( _
      cbool( position < len( context.subject ) ) andAlso _
      not context.isMalformed andAlso _
      not match( _
        context.subject, _
        closeTag, _
        position ) )
      
      '' If there's any markup in the content, parse it
      if( cbool( char( _
        context.subject, _
        position ) = "<" ) ) then
        
        /'
          Recursively parse content elements
        '/
        position => parseTags( _
          context, _
          node, _
          position, _
          closeTag )
      else
        /'
          If there's no markup in the content of the element, the content
          is to be passed as-is to the application as per the XML
          Recommendation.
        '/
        if( char( _
          context.subject, _
          position ) = "&" ) then
          
          '' This is an escaped char, parse it
          dim as string _
            escapedChar
          
          position => getEscapedChar( _
            context.subject, _
            position + 1, _
            escapedChar )
          
          content +=> escapedChar
        else
          content +=> char( _
            context.subject, position )
        end if
        
        position +=> 1
      end if
    loop
    
    if( not isEmptyString( content ) ) then
      /'
        Only retrieve the content of an element if it's not composed
        entirely of white space. Note that markup in content is still
        parsed as normal, as opposed to CDATA sections where markup is
        interpreted literally.
        
        If any markup appears in the content section that is not intended
        to be markup, it must be escaped. See the XML Recommendation for
        info on how escaping in XML works.
      '/
      
      node->content => content
    end if
    
    '' Return the position unchanged to the lowermost parse function
    return( position )
  end function
  
  /'
    Parses a XML element
  '/
  function _
    parseElement( _
      byref context as XmlParseContext, _
      byval node as XmlElement ptr, _
      byref elementTag as const StringType, _
      byref closeTag as const StringType, _
      byval position as uinteger ) _
    as uinteger
    
    dim as StringType _
      elementName
    
    '' Get the element name (without markup)
    position => getString( _
      context.subject, _
      "/>" + Parsing.Strings.WhiteSpace, _
      position, _
      elementName )
    
    '' Create the new element as content of the current node
    var _
      newElement => new XmlElement( _
        elementName, XmlNodeType.Element )
    
    node->childNodes.append( newElement )
    
    '' Skip the white space before attributes
    position => skipWhiteSpace( _
      context.subject, _
      position )
    
    '' Parse the attributes, if any
    position => parseElementAttributes( _
      context, _
      newElement, _
      position )
    
    /'
      And then determine how the element is closed. This changes depending
      on several factors, such as the absence of attributes and/or content.
    '/
    if( match( context.subject, "/>", position ) ) then
      '' Empty element (doesn't have any content)
      return( position + len( "/>" ) )
    end if
    
    /'
      The element may have an empty attribute list, but can still have
      content, so parse it.
    '/
    if( match( context.subject, ">", position ) ) then
      '' Construct the closing tag for the element
      dim as StringType _
        endTag => "</" + elementName + ">"
      
      '' Parse element contents
      position => parseElementContent( _
        context, _
        newElement, _
        elementName, _
        endTag, _
        position + 1 )
      
      '' Are we at the closing tag yet?
      if( match( context.subject, endTag, position ) ) then
        '' Yes, so skip it and return
        return( position + len( endTag ) )
      end if
    end if
    
    '' Document is probably malformed, report it
    context.isMalformed => true
    
    '' Return the position so parsing can continue
    return( position )
  end function
end namespace

#endif
