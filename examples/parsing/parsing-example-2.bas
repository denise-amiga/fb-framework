#include once "fbfw-parsing.bi"

/'
  Example using the Parsing framework to lay out the pattern for a simple
  yet effective recursive descent parser.
  
  Admittedly, the example isn't much (yet) but it shows the general pattern
  is very easily extended and maintained, and keeps the global state to the
  bare minimum (ideally zero).
  
  Despite its simple-mindedness is quite effective (especially for small
  grammars) but the O( keyword-count) performance can be improved by using
  a different data structure to make the keyword-parsing function associations
  (by using a Trie, for example).
'/
using Parsing

/'
  The signature for the parsing functions. All of them get the string that's
  being parsed and the position from where parsing should start, along with
  a context (which can be global to the parser or local for the function),
  and return the position where they finished parsing so the next function
  can start parsing right away.
'/
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

function _
  parse( _
    byref inputString as const string, _
    byref keywords as Array( of( StringType ) ), _
    byref parsingFunction as Array( of( ParseFunction ) ), _
    byval aContext as any ptr, _
    byval position as integer => 1 ) _
  as integer
  
  do while( position < len( inputString ) )
    dim as integer _
      index => Strings.match( _
        inputString, keywords, position )
      
    if( index >= 0 ) then
      position => parsingFunction.at( index ) _
        ( inputString, _
          position + len( keywords.at( index ) ), _
          aContext )
    end if
    
    position +=> 1
  loop
end sub

/'
  Create two matching arrays of keywords and parsing functions. Each keyword
  will be associated with the corresponding parsing function that has the
  same index.
'/
var _
  keywords => Array( of( StringType ) )() _
    .add( "end" ) _
    .add( "function" ) _
    .add( "sub" ), _
  parsingFunction => Array( of( ParseFunction ) )() _
    .add( @parseEnd ) _
    .add( @parseFunction ) _
    .add( @parseSub )

dim as string _
  code => _
    "function foo( bar as integer )" & _
    "  ? bar " & _
    "end function"

dim as any ptr _
  someContext

parse( _
  code, _
  keywords, _
  parsingFunction, _
  someContext )

sleep()
