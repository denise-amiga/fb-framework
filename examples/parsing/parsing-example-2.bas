#include once "parsing.bi"

using Parsing

type as function( _
  byref as const string, _
  byval as uinteger, _
  byval as any ptr => 0 ) _
  as uinteger _
  ParseFunction

template( Array, of( ParseFunction ) )

function _
  parseEnd( _
    byref subject as const string, _
    byval position as uinteger, _
    byval aContext as any ptr => 0 ) _
  as uinteger
  
  '' Skip the white space after 'end'
  position +=> 1
  
  var _
    endOfBlock => Array( of( StringType ) )() _
      .add( "function" ).add( "sub" )
  
  dim as integer _
    index => Strings.match( _
      subject, _
      endOfBlock, _
      position )
  
  if( index >= 0 ) then
    ? "<end" & endOfBlock.at( index ) & ">"
    position +=> len( endOfBlock.at( index ) )
  else
    '' Error
  end if
  
  return( position )
end function

function _
  parseFunction( _
    byref subject as const string, _
    byval position as uinteger, _
    byval aContext as any ptr => 0 ) _
  as uinteger
  
  ? "<function>"
  ? "  <parse parameter list and body>"
  
  return( position )
end function

function _
  parseSub( _
    byref subject as const string, _
    byval position as uinteger, _
    byval aContext as any ptr => 0 ) _
  as uinteger
  
  ? "Parsing 'sub' statement..."
  return( position )
end function

var _
  keywords => Array( of( StringType ) )() _
    .add( "end" ).add( "function" ).add( "sub" ), _
  parsingFunction => Array( of( ParseFunction ) )() _
    .add( @parseEnd ).add( @parseFunction ).add( @parseSub )

dim as string _
  code => _
    "function foo( bar as integer )" & _
    "  ? bar " & _
    "end function"

dim as any ptr _
  someContext
dim as uinteger _
  position => 1

do while( position < len( code ) )
  dim as integer _
    index => Strings.match( _
      code, keywords, position )
  
  if( index >= 0 ) then
    position => parsingFunction.at( index ) _
      ( code, _
        position + len( keywords.at( index ) ), _
        someContext )
  end if
  
  position +=> 1
loop

sleep()
