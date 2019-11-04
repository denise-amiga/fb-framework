#ifndef __XML_HELPER__
#define __XML_HELPER__

/'
  Helper module that contains useful functions to parse FreeBasic primitive
  data types from a XML node.
'/
namespace Xml
  /'
    Parses a string from a XML attribute
  '/
  function _
    stringAttribute( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as StringType
    
    dim as StringType _
      result => ""
    
    if( anElement->hasAttributes ) then
      var _
        anAttribute => anElement->attributes.first
      
      for _
        i as integer => 0 _
        to anElement->attributes.count - 1
        
        if( lcase( anAttribute->item->name ) = lcase( aName ) ) then
          result => anAttribute->item->value
          exit for
        end if
        
        anAttribute => anAttribute->forward
      next
    end if
    
    return( result )
  end function
  
  /'
    Parses an integer from a XML attribute
  '/
  function _
    integerAttribute( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as integer
    
    return( int( val( _
      stringAttribute( aName, anElement ) ) ) )
  end function
  
  /'
    Parses a long integer from a XML attribute
  '/
  function _
    longIntAttribute( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as longint
    
    return( clngint( val( _
      stringAttribute( aName, anElement ) ) ) )
  end function
  
  /'
    Parses a single-precision float from a XML attribute
  '/
  function _
    floatAttribute( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as single
    
    return( csng( val( _
      stringAttribute( aName, anElement ) ) ) )
  end function
  
  /'
    Parses a double-precision float from a XML attribute
  '/
  function _
    doubleAttribute( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as double
    
    return( val( _
      stringAttribute( aName, anElement ) ) )
  end function
  
  /'
    Parses a boolean from a XML attribute
  '/
  function _
    boolAttribute( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as boolean
    
    return( cbool( _
      lcase( stringAttribute( aName, anElement ) ) = "true" ) )
    
    'dim as StringType _
    '  value => lcase( stringAttribute( aName, anElement ) )
    
    'dim as boolean _
    '  result
    '
    'select case( value )
    '  case "true"
    '    result => true
    '  
    '  case "false"
    '    result => false
    '  
    '  case else
    '    result => false
    'end select
    '
    'return( result )
  end function
  
  /'
    Parses a string from a XML element
  '/
  function _
    stringElement( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as StringType
    
    dim as StringType _
      result => ""
    
    if( anElement->hasChildNodes ) then
      var _
        aNode => anElement->childNodes.first
      
      for _
        i as integer => 0 _
        to anElement->childNodes.count - 1
        
        var _
          element => cptr( _
            XmlElement ptr, _
            aNode->item )
          
        if( lcase( element->name ) = lcase( aName ) ) then
          result => element->content
          exit for
        end if
        
        aNode => aNode->forward
      next
    end if
    
    return( result )
  end function
  
  /'
    Parses an integer from a XML element
  '/
  function _
    integerElement( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as integer
    
    return( int( val( _
      stringElement( aName, anElement ) ) ) )
  end function
  
  /'
    Parses a long integer from a XML element
  '/
  function _
    longIntElement( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as longint
    
    return( clngint( val( _
      stringElement( aName, anElement ) ) ) )
  end function
  
  /'
    Parses a single-precision float from a XML element
  '/
  function _
    floatElement( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as single
    
    return( csng( val( _
      stringElement( aName, anElement ) ) ) )
  end function
  
  /'
    Parses a double-precision float from a XML element
  '/
  function _
    doubleElement( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as double
    
    return( val( _
      stringElement( aName, anElement ) ) )
  end function
  
  /'
    Parses a boolean from a XML element
  '/
  function _
    boolElement( _
      byref aName as const StringType, _
      byval anElement as XmlElement ptr ) _
    as boolean
    
    dim as boolean _
      result
    
    dim as StringType _
      value => stringElement( aName, anElement )
    
    return( iif( lcase( value ) = "true", _
      true, false ) )
    
    'select case( lcase( value ) )
    '  case "true"
    '    result => true
    '  
    '  case "false"
    '    result => false
    '  
    '  case else
    '    result => false
    'end select
    
    'return( result )
  end function
end namespace

#endif
