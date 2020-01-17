#ifndef __FBFW_XML_PARSE_UTILS__
#define __FBFW_XML_PARSE_UTILS__

/'
  Parsing helper module for the Xml framework.
  
  It contains some useful functions to deal with the parsing of XML entities.
'/
namespace Xml
  /'
    Returns whether or not the subject string is white space. Note that while it
    accepts a string, only a single char is considered for consistency.
  '/
  function _
    isWhiteSpace( _
      byref subject as const StringType ) _
    as boolean
    
    return( cbool( _
      inStr( subject, any Parsing.Strings.whiteSpace ) > 0 ) )
  end function
  
  /'
    Returns whether or not a string matches a subject string at the specified
    position.
  '/
  function _
    match( _
      byref subject as const StringType, _
      byref aMatch as const StringType, _
      byval position as uinteger ) _
    as boolean
    
    return( cbool( _
      aMatch <> "" andAlso _
      mid( _
        subject, _
        position, _
        len( aMatch ) ) = aMatch ) )
  end function
  
  /'
    Returns the char from the subject string at the specified position.
  '/
  function _
    char( _
      byref subject as const StringType, _
      byval position as uinteger ) _
    as StringType
    
    return( chr( _
      subject[ position - 1 ] ) )
  end function
  
  /'
    Returns whether or not any char of a substring is within another subject string.
  '/
  function _
    within( _
      byref subject as const StringType, _
      byref substring as const StringType ) _
    as boolean
    
    return( cbool( _
      inStr( subject, any substring ) > 0 ) )
  end function
  
  /'
    Retrieves a substring from a subject string starting at the specified position
    and up to (but not including) the specified delimiter chars.
  '/
  function _
    getString( _
      byref subject as const StringType, _
      byref delimiters as const StringType, _
      byval position as uinteger, _
      byref aName as StringType ) _
    as uinteger
    
    dim as integer _
      startPosition => position, _
      endPosition => inStr( _
        startPosition, _
        subject, _
        any delimiters )
      
    aName => mid( _
      subject, _
      startPosition, _
      endPosition - startPosition )
    
    return( _
      position + ( endPosition - startPosition ) )
  end function
  
  /'
    Skips all white space in the given subject string, starting at the specified
    position.
  '/
  function _
    skipWhiteSpace( _
      byref subject as const StringType, _
      byval position as uinteger ) _
    as uinteger
    
    do while( _
      position < len( subject ) andAlso _
      isWhiteSpace( char( subject, position ) ) )
      
      position +=> 1
    loop
    
    return( position )
  end function
  
  /'
    Returns whether or not a subject string is 'empty', that is, it only contains
    white space.
  '/
  function _
    isEmptyString( _
      byref subject as const StringType ) _
    as boolean
    
    for _
      i as integer => 1 _
      to len( subject )
      
      if( not isWhiteSpace( _
        char( subject, i ) ) ) then
        
        return( false )
      end if
    next
    
    return( true )
  end function
  
  /'
    Returns the namespace from a XML symbol name, or an empty string if there's no
    namespace.
    
    getXMLNamespace( "svg:path" ) -> "svg"
    getXMLNamespace( "svg" ) -> ""
     
  '/
  function _
    getXMLNamespace( _
      byref aName as const StringType ) _
    as StringType
    
    dim as integer _
      separator => inStr( aName, ":" )
    
    if( separator <> 0 ) then
      return( mid( _
        aName, _
        1, _
        separator - 1 ) )
    else
      return( "" )
    end if
  end function
  
  /'
    Returns the name from a XML symbol name with namespace. If there's no namespace,
    then the name is returned.
    
    getXMLName( "svg:path" ) -> "path" 
    getXMLName( "path" ) -> "path" 
  '/
  function _
    getXMLName( _
      byref aName as const StringType ) _
    as StringType
    
    dim as integer _
      separator => inStr( aName, ":" )
    
    if( separator <> 0 ) then
      return( mid( _
        aName, _
        separator + 1, _
        len( aName ) - separator ) )
    else
      return( aName )
    end if
  end function
  
  /'
    Extracts the name of a URI resource from a tag. URI resources in XML have the form
    'url(#resourceName)', so this function returns 'resourceName', or a null string if
    the tag does not contain a '#' (which is used to separate the name from the rest of
    the tag).
  '/
  function _
    getURLResourceName( _
      byref anURL as const StringType ) _
    as StringType
    
    dim as integer _
      startPos => inStr( anURL, "#" )
    
    if( startPos > 0 ) then
      dim as integer _
        endPos => inStr( startPos, anURL, ")" )
      
      return( mid( _
        anURL, _
        startPos + 1, _
        endPos - startPos - 1 ) )
    end if
    
    return( "" )
  end function
  
  /'
    Gets an escaped XML char.
    
    getEscapedCharTag( "&amp;", 1 ) -> "&"
    getEscapedCharTag( "&lt;", 1 ) -> "<"
    getEscapedCharTag( "&gt;", 1 ) -> ">"
    getEscapedCharTag( "&apos;", 1 ) -> "'"
    getEscapedCharTag( "&quot;", 1 ) -> '"'
    
    The interest of escaping these chars is that three of them are used in their
    literal forms to delimit markup, so for them to appear in both attribute
    values and element contents, an escaping mechanism needs to be used.
  '/
  function _
    getEscapedChar( _
      byref subject as const StringType, _
      byval position as uinteger, _
      byref tag as StringType ) _
    as uinteger
    
    dim as StringType _
      literal => ""
    
    do while( _
      position < len( subject ) andAlso _
      cbool( char( subject, position ) <> ";" ) )
      
      literal +=> char( subject, position )
      
      position +=> 1
    loop
    
    /'
      TODO:
      
        - This should probably be factored out to a dictionary lookup for more
        efficiency and flexibility.
    '/
    select case( lcase( literal ) )
      case( "amp" )
        tag => "&"
      
      case( "lt" )
        tag => "<"
      
      case( "gt" )
        tag => ">"
      
      case( "apos" )
        tag => "'"
      
      case( "quot" )
        tag => """"
      
      case else
        tag => ""
    end select
    
    return( position )
  end function
  
  /'
    Returns the subject string with all the XML escaped chars within replaced with
    their literal equivalents. Note that the function assummes that the '&' char
    (which is used in XML to signal the start of an escaped char) ALWAYS appear in
    its escaped form.
    
    This function is usually used when retrieving the value for attributes, since
    they allow the value to contain, for example, double quotes and apostrophes
    (which are used in their literal form to delimit the attribute value).
  '/
  function _
    replaceEscapedChars( _
      byref subject as const StringType, _
      byval position as integer => 1 ) _
    as StringType
    
    dim _
      replaced as StringType => "", _
      escaped as StringType => ""
    
    do while( _
      position <= len( subject ) )
      
      dim as boolean _
        isLiteral => true
      
      /'
        If the char is the start of an escaped char, retrieve it and flag it
        as such.
      '/
      if( char( _
        subject, _
        position ) = "&" ) then
        
        position => getEscapedChar( _
          subject, _
          position + 1, _
          escaped )
        
        isLiteral => false
      end if
      
      /'
        Then, if the char was a literal, collect it as it is. Otherwise, replace
        it with the appropriate escaped char.
      '/
      if( isLiteral ) then
        replaced +=> char( _
          subject, position )
      else
        replaced +=> escaped
      end if
      
      position +=> 1
    loop
    
    return( replaced )
  end function
end namespace

#endif
