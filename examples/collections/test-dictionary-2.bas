#include once "collections.bi"
#include once "xstring.bi"

template( Dictionary, _
  of( string ), of( XString ) )

type _
  Show _
  extends Action( of( string ) )
  
  declare destructor() override
  
  declare sub _
    invoke( _
      byval as string ptr ) override
end type

destructor _
  Show()
end destructor

sub _
  Show.invoke( _
    byval aString as string ptr )
  
  if( _
    *aString <> fbCr andAlso _
    *aString <> fbLf andAlso _
    *aString <> fbCrLf andAlso _
    *aString <> fbSpc andAlso _
    *aString <> fbTab ) then
    
    ? "(" & indexOf & ") " + *aString
  end if
end sub

/'
  Unit test showing some simple text parsing, using the XString class
'/
scope
  var _
    xml => Dictionary( _
      of( string ), _
      of( XString ) )()
    
  xml _
    .add( "xml1", new XString( _
      "<root> " + fbCrLf + _
      "  <element1 type=""string"">" + fbCrLf + _
      "  </element1>" + fbCrLf + _
      "</root>" ) ) _
    .add( "xml2", new XString( _
      "<root> " + fbCrLf + _
      "  <element2 type='integer'>" + fbCrLf + _
      "  </element2>" + fbCrLf + _
      "</root>" ) )
    
  var _
    aTokenArray => xml.find( "xml1" )->split( _
      fbCr + fbLf + fbSpc + """'" + "=" )
    
  aTokenArray->forEach( Show() )
  
  delete( aTokenArray )
end scope

sleep()
