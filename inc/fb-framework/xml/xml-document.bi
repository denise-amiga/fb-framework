#ifndef __FB_XML_XMLDOCUMENT__
#define __FB_XML_XMLDOCUMENT__

/'
  Represents a Xml document
'/
namespace Xml
  type _
    XmlDocument _
    extends Events.WithEvents
    
    public:
      declare constructor()
      declare virtual destructor() override
      
      declare property _
        documentLoaded() byref as const Events.Event
      
      declare property _
        documentElement() as XmlElement ptr
      declare property _
        hasChildNodes() as boolean
      declare property _
        malformed() as boolean
      
      declare sub _ 
        loadXml( _
          byref as const StringType )
        
    protected:
      declare virtual sub _
        onLoadXml( _
          byref as const StringType )
      declare virtual sub _
        onParse( _
          byref as XmlParseContext )
        
    private:
      static as Events.Event _
        _documentLoaded
      
      as StringType _
        _name
      as XmlDocumentRoot _
        _root
      as XmlElement ptr _
        _documentElement
      as boolean _
        _malformed
  end type
  
  dim as Events.Event _
    XmlDocument._documentLoaded => Events.Event( "DocumentLoaded" )
  
  constructor _
    XmlDocument()
    
    register( _documentLoaded )
  end constructor
  
  destructor _
    XmlDocument()
  end destructor
  
  property _ 
    XmlDocument.documentLoaded() _
    byref as const Events.Event
    
    return( _documentLoaded )
  end property
  
  property _ 
    XmlDocument.documentElement() _
    as XmlElement ptr
    
    return( _documentElement )
  end property
  
  property _
    XmlDocument.hasChildNodes() _
    as boolean
    
    return( _root.hasChildNodes )
  end property
  
  property _
    XmlDocument.malformed() _
    as boolean
    
    return( _malformed )
  end property
  
  sub _
    XmlDocument.loadXml( _
      byref aString as const StringType )
    
    onLoadXml( aString )
  
    raiseEvent( _
      documentLoaded, Events.EventArgs() )
  end sub
  
  sub _
    XmlDocument.onLoadXml( _
      byref aString as const StringType )
    
    /'
      Wire up the standard parsing functions into the context
    '/
    dim as XmlParseFunction _
      parsingFunctions( ... ) => { _
        asXmlParsingFunction( parseInstruction ), _
        asXmlParsingFunction( parseCDATA ), _
        asXmlParsingFunction( parseComment ), _
        asXmlParsingFunction( parseDeclaration ), _
        asXmlParsingFunction( parseElement ) _
      }
    
    var _
      aContext => XmlParseContext( _
      aString, _
      parsingFunctions() )
    
    onParse( aContext )
    
    _malformed => aContext.isMalformed
  end sub
  
  sub _
    XmlDocument.onParse( _
      byref aContext as XmlParseContext )
    
    dim as uinteger _
      result => parseTags( _
        aContext, _
        @_root )
    
    _documentElement => _root.getDocumentElement()
  end sub
end namespace

#endif
