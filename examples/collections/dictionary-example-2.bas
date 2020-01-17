#include once "fbfw-collections.bi"
#include once "fbfw-xstring.bi"

/'
  Example showing some simple text parsing, using the XString class
'/
using FbFw

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
    *aString <> stCr andAlso _
    *aString <> stLf andAlso _
    *aString <> stCrLf andAlso _
    *aString <> stSpace andAlso _
    *aString <> stTab ) then
    
    ? "(" & indexOf & ") " + *aString
  end if
end sub

scope
  var _
    xml => Dictionary( _
      of( string ), _
      of( XString ) )()
    
  xml _
    .add( "xml1", new XString( _
      "<root> " + stCrLf + _
      "  <element1 type=""string"">" + stCrLf + _
      "  </element1>" + stCrLf + _
      "</root>" ) ) _
    .add( "xml2", new XString( _
      "<root> " + stCrLf + _
      "  <element2 type='integer'>" + stCrLf + _
      "  </element2>" + stCrLf + _
      "</root>" ) )
    
  var _
    aTokenArray => xml.find( "xml1" )->split( _
      stCr + stLf + stSpace + """'" + "=" )
    
  aTokenArray->forEach( Show() )
  
  delete( aTokenArray )
end scope

sleep()
