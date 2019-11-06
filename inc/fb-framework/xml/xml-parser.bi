/'
  SXML: Simple XML parser
  
  A very simple parser for XML-like formats. Not compliant but functional nonetheless. 
  Very useful for data-driven designs as XML is a fairly standard format that many
  apps, such as Inkscape, use to read/write their files; so you can easily interoperate
  your code with apps that support the XML recommendation. Blender (through COLLADA) 
  and Inkscape (through SVG) are two examples.
  
  It parses the given file into an object, which you can then easily index to retrieve
  the desired data for further parsing.
  
  - IMPORTANT NOTE -
  Some XML files are nested too deep (such as those generated by Adobe Illustrator) so
  a stack size of at least 8192K is recommended, since the parser is a recursively
  descent one. To change the stack size, see the -t compiler option in the FreeBasic
  Manual.
  
  - Implementation notes -
  Designed to be simple and easily extensible/modifiable. It's not the fastest one around
  but it's reasonably efficient considering its scope (data-driven game development,
  mostly).
  
  It uses no external dependencies, so you can simply #include it into your projects and
  have XML functionality without needing to ship other binaries nor external code.
  
  Since it uses FreeBasic's native strings and string functions, its performance is not
  stellar, but it's not half bad either. Modifying it to use ZStrings or use your own
  algorithms should be easy enough, since the interface is composed entirely of functions
  that use the same prototype, and operate independently from each other by sharing state
  through parameter passing and return values.
  
  As an interesting side note, the interface provided can be modified very easily to
  accomodate other markup formats such as JSON and MarkUp.
'/
namespace SXML
  '' Forward the context type
  type as ParseContext _
    _context
  
  /'
    Parsing functions prototype. They have to return the position at where they finished
    parsing, so the next parsing function will start where the last one ended. This allows
    easy chaining of parsing functions, to extend/implement additional parsing if need be.
  '/
  type as function( _
    byref as _context, _
    byval as XMLElement ptr, _
    byref as const string, _
    byref as const string, _
    byval as uinteger ) as uinteger _
  ParseFunction
  
  /'
    The error reporting callback function
  '/
  type as sub( _
    byref as const string, _
    byval as any ptr ) _
  ErrorCallback
  
  /'
    The parsing context. Contains the parsing function pointers, the string containing
    the document, and the opening and closing tags for them. Also, a callback mechanism
    is provided to handle parsing errors.
    
    Note that some elements like XML comments and declarations are straightforward to
    parse, while others like elements are more complicated and have special parsing
    rules and use the opening and closing tags differently.
  '/
  type _
    ParseContext
    
    public:
      declare constructor( _
        byref as const string, _
        eTags() as string, _
        cTags() as string, _
        pFuncs() as ParseFunction, _
        byval as ErrorCallback => SXML.Nil, _
        byval as any ptr => SXML.Nil )
      declare destructor()
      
      as string _
        subject, _
        elementTags( any ), _
        closeTags( any )
      as ParseFunction _
        parseFuncs( any )
      as ErrorCallback _
        errorFunc
      as any ptr _
        errorParam
      as boolean _
        isMalformed => false
      
    private:
      declare constructor()
  end type
  
  constructor _
    ParseContext()
  end constructor
  
  constructor _
    ParseContext( _
      byref aSubject as const string, _
      eTags() as string, _
      cTags() as string, _
      pFuncs() as ParseFunction, _
      byval aCallback as ErrorCallback => SXML.Nil, _
      byval param as any ptr => SXML.Nil )
    
    subject => aSubject
    
    redim _
      elementTags( 0 to ubound( eTags ) )
    
    for _
      i as integer => 0 _
      to ubound( eTags )
      
      elementTags( i ) => eTags( i )
    next
    
    redim _
      closeTags( 0 to ubound( cTags ) )
    
    for _
      i as integer => 0 _
      to ubound( cTags )
      
      closeTags( i ) => cTags( i )
    next
    
    redim _
      parseFuncs( 0 to ubound( pFuncs ) )
    
    for _
      i as integer => 0 _
      to ubound( pFuncs )
      
      parseFuncs( i ) => pFuncs( i )
    next
    
    errorFunc => aCallback
    errorParam => param
  end constructor
  
  destructor _
    ParseContext()
  end destructor
  
  /'
    Main parse function.
    
    Parsing of the document starts with this function, passing it a parsing context, and
    the starting position (usually 1 at the start of the parsing).
  '/
  function _
    parseTags( _
      byref context as ParseContext, _
      byval node as XMLElement ptr, _
      byval position as uinteger => 1, _
      byref closeTag as const string => "" ) _
    as uinteger
    
    do while( _
      position < len( context.subject ) andAlso _
      not match( _
        context.subject, _
        closeTag, _
        position ) )
      
      '' Get the index for the opening tag
      dim as integer _
        index => getTagIndex( _
          context.subject, _
          context.elementTags(), _
          position )
        
      /'
        If a tag has been found, call the appropriate parsing function. Note that it also
        skips the opening tag so the next function can start parsing right away.
      '/
      if( index >= 0 ) then
        position => context.parseFuncs( index )( _
          context, _
          node, _
          context.elementTags( index ), _
          context.closeTags( index ), _
          position + len( context.elementTags( index ) ) )
      else
        /'
          Advance the position to the next char. Note that this implies that any markup
          that's not recognized will be silently ignored.
        '/
        position +=> 1
      end if
    loop
    
    return( position )
  end function
  
  /'
    Parses a XML comment
  '/
  function _
    parseComment( _
      byref context as ParseContext, _
      byval node as XMLElement ptr, _
      byref elementTag as const string, _
      byref closeTag as const string, _
      byval position as uinteger ) _
    as uinteger
    
    dim as string _
      result
    
    do while( _
      position < len( context.subject ) andAlso _
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
      
      This is not required but recommended by the XML Recommendation.
    '/
    var _
      nElement => new XMLElement( "xml:comment" )
    
    nElement->content => result
    
    node->addElement( nElement )
    
    '' Skip the closing tag
    return( position + len( closeTag ) )
  end function
  
  /'
    Parses a XML Processing Instruction (PI)
  '/
  function _
    parseInstruction( _
      byref context as ParseContext, _
      byval node as XMLElement ptr, _
      byref elementTag as const string, _
      byref closeTag as const string, _
      byval position as uinteger ) _
    as uinteger
    
    dim as string _
      result
    
    do while( _
      position < len( context.subject ) andAlso _
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
      nElement => new XMLElement( "xml:PI" )
    
    nElement->content => result
    
    node->addElement( nElement )
    
    '' Skip the closing tag
    return( position + len( closeTag ) )
  end function
  
  /'
    Parses a XML declaration
  '/
  function _
    parseDeclaration( _
      byref context as ParseContext, _
      byval node as XMLElement ptr, _
      byref elementTag as const string, _
      byref closeTag as const string, _
      byval position as uinteger ) _
    as uinteger
    
    dim as string _
      result
    
    do while( _
      position < len( context.subject ) andAlso _
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
      nElement => new XMLElement( "xml:decl" )
    
    nElement->content => result
    
    node->addElement( nElement )
    
    '' Skip the closing tag
    return( position + len( closeTag ) )
  end function
  
  /'
    Parses a XML CDATA block
  '/
  function _
    parseCDATA( _
      byref context as ParseContext, _
      byval node as XMLElement ptr, _
      byref elementTag as const string, _
      byref closeTag as const string, _
      byval position as uinteger ) _
    as uinteger
    
    dim as string _
      result
    
    do while( _
      position < len( context.subject ) andAlso _
      not match( _
        context.subject, _
        closeTag, _
        position ) )
      
      /'
        Consume the CDATA block as-is. This is important, because normally CDATA blocks are
        used to embed binary data such as images into the document.
      '/
      result +=> char( _
        context.subject, position )
      
      position +=> 1
    loop
    
    '' Add the element to the node's content
    var _
      nElement => new XMLElement( "xml:CDATA" )
    
    nElement->content => result
    
    node->addElement( nElement )
    
    '' Skip the closing tag
    return( position + len( closeTag ) )
  end function
  
  /'
    Parse a single XML element attribute
  '/
  function _
    parseAttribute( _
      byref context as ParseContext, _
      byval node as XMLElement ptr, _
      byval position as uinteger ) _
    as uinteger
    
    dim as string _
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
    
    dim as string _
      delimiter => char( context.subject, position )
    
    /'
      Skips equals sign and attribute value open quote and retrieve the string containing
      the value.
    '/
    position => getString( _
      context.subject, _
      delimiter, _
      position + 1, _
      attributeValue )
    
    /'
      Add the attribute to the element. Note that it also replaces any escaped char within
      the attribute value as per the XML Recommendation.
    '/
    var _
      nAttribute => new XMLAttribute( _
        attributeName, _
        replaceEscapedChars( _
          attributeValue, 1 ), _
        node )
    
    node->addAttribute( nAttribute )
    
    '' Skip the attribute value closing quote
    return( position + 1 )
  end function
  
  /'
    Parses the attributes of an element
  '/
  function _
    parseElementAttributes( _
      byref context as ParseContext, _
      byval node as XMLElement ptr, _
      byval position as uinteger ) _
    as uinteger
    
    do while( _
      position < len( context.subject ) andAlso _
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
      Return the position as-is, since attributes are part of XML elements and these have
      several different parsing rules, depending on if it's empty (it doesn't have any
      content) and how you express this fact. According to the XML Recommendation, all these
      constitute valid empty elements:
      
      <IMG align="left" />
      <br></br>
      <br/>
      
      Therefore, further processing is needed to determine this at the lower level parsing
      function.
    '/
    return( position )
  end function
  
  /'
    Parses the content of an XML element
  '/
  function _
    parseElementContent( _
      byref context as ParseContext, _
      byval node as XMLElement ptr, _
      byref elementTag as const string, _
      byref closeTag as const string, _
      byval position as uinteger ) _
    as uinteger
    
    dim as string _
      content
    
    do while( _
      position < len( context.subject ) andAlso _
      not match( _
        context.subject, _
        closeTag, _
        position ) )
      
      '' If there's any markup in the content, parse it
      if( char( _
        context.subject, _
        position ) = "<" ) then
        
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
          If there's no markup in the content of the element, the content is to be passed
          as-is to the application as per the XML Recommendation.
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
        Only retrieve the content of an element if it's not composed entirely of white space.
        Note that markup in content is still parsed as normal, as opposed to CDATA sections
        where markup is interpreted literally.
        
        If any markup appears in the content section that is not intended to be markup, it must
        be escaped. See the XML Recommendation on this.
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
      byref context as ParseContext, _
      byval node as XMLElement ptr, _
      byref elementTag as const string, _
      byref closeTag as const string, _
      byval position as uinteger ) _
    as uinteger
    
    dim as string _
      elementName
    
    '' Get the element name (without markup)
    position => getString( _
      context.subject, _
      "/>" + whiteSpace, _
      position, _
      elementName )
    
    '' Create the new element as content of the current node
    var _
      nElement => new XMLElement( elementName )
    
    node->addElement( nElement )
    
    '' Skip the white space before attributes
    position => skipWhiteSpace( _
      context.subject, _
      position )
    
    '' Parse the attributes, if any
    position => parseElementAttributes( _
      context, _
      nElement, _
      position )
    
    /'
      And then determine how the element is closed. This changes depending on several factors,
      such as the absence of attributes and/or content.
    '/
    if( match( context.subject, "/>", position ) ) then
      '' Empty element (doesn't have any content)
      return( position + len( "/>" ) )
    end if
    
    /'
      The element may have an empty attribute list, but can still have content, so parse it.
    '/
    if( match( context.subject, ">", position ) ) then
      '' Construct the closing tag for the element
      dim as string _
        endTag => "</" + elementName + ">"
      
      '' Parse element contents
      position => parseElementContent( _
        context, _
        nElement, _
        elementName, _
        endTag, _
        position + 1 )
      
      '' Are we at the closing tag yet?
      if( match( context.subject, endTag, position ) ) then
        '' Yes, so skip it
        return( position + len( endTag ) )
      end if
      
      '' Document is probably malformed, report it
      with context
        if( .errorFunc <> Nil ) then
          .errorFunc( _
            "ERROR: Malformed document, at char " & position, _
            .errorParam )
          
          .isMalformed => true
        end if
      end with
      
      '' Return the position so parsing can continue
      return( position )
    end if
    
    '' The document is probably malformed, report it
    with context
      if( .errorFunc <> Nil ) then
        .errorFunc( _
          "ERROR: Malformed document, at char " & position, _
          .errorParam )
        
        .isMalformed => true
      end if
    end with
    
    '' Return the position so parsing can continue
    return( position )
  end function
end namespace