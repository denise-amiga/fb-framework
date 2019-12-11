#ifndef __FBFW_XSTRING__
#define __FBFW_XSTRING__

#include once "file.bi"
#include once "vbcompat.bi"

#include once "fbfw-collections.bi"

template( Array, of( string ) )

/'
  Represents a string of characters.
  
  Intended to be the base string class for the framework, to add Unicode
  support along with other miscelaneous utilities.
'/
type _
  XString _
  extends Object
  
  public:
    declare constructor()
    declare constructor( _
      byref as XString )
    declare constructor( _
      byref as string )
    declare virtual destructor()
    
    declare operator _
      let( byref as string )
    declare operator _
      let( byref as XString )
    declare operator _
      cast() as string
    
    declare operator _
      +=( _
        byref as string )
    declare operator _
      &=( _
        byref as string )
    declare operator _
      +=( _
        byref as XString )
    declare operator _
      &=( _
        byref as XString )
      
    declare property _
      chars() as ubyte ptr
    declare property _
      char( _
        byval as uinteger ) _
      as string
    declare property _
      length() as uinteger
    declare property _
      isEmpty() as boolean
    
    declare function _
      getHashCode() as ulong
    declare function _
      contains( _
        byref as const string ) _
      as boolean
    declare function _
      toLower() as XString
    declare function _
      toUpper() as XString
    declare function _
      substring( _
        byval as uinteger ) _
      as XString
    declare function _
      substring( _
        byval as uinteger, _
        byval as uinteger ) _
      as XString
    declare function _
      splice( _
        byref as XString ) _
      as XString
    declare function _
      positionOf( _
        byref as XString ) _
      as uinteger
    declare function _
      positionOf( _
        byref as XString, _
        byval as uinteger ) _
      as uinteger
    declare function _
      positionOfAny( _
        byref as XString ) _
      as uinteger
    declare function _
      positionOfAny( _
        byref as XString, _
        byval as uinteger ) _
      as uinteger
    declare function _
      leftmost( _
        byval as uinteger ) _
      as XString
    declare function _
      rightmost( _
        byval as uinteger ) _
      as XString
    declare function _
      split( _
        byref as const string ) _
      as Array( of( string ) ) ptr
    declare function _
      startsWith( _
        byref as const string ) _
      as boolean
    declare function _
      endsWith( _
        byref as const string ) _
      as boolean
    
    declare static function _
      fromFile( _
        byref as const string ) _
      as XString
    
    static as const ubyte _
      CrChar, _
      LfChar, _
      TabChar, _
      SpaceChar
    
  private:
    as string _
      _string
end type

dim as const ubyte _
  XString.CrChar => 13, _
  XString.LfChar => 10, _
  XString.TabChar => 9, _
  XString.SpaceChar => 32

constructor _
  XString()
  
  _string => ""
end constructor

constructor _
  XString( _
    byref rhs as XString )
  
  _string => rhs._string
end constructor

constructor _
  XString( _
    byref rhs as string )
  
  _string => rhs
end constructor

operator _
  XString.let( _
    byref rhs as XString )
  
  _string => rhs._string
end operator

operator _
  XString.let( _
    byref rhs as string )
  
  _string => rhs
end operator

destructor _
  XString()
end destructor

operator _
  XString.cast() _
  as string
  
  return( _string )
end operator

operator _
  XString.+=( _
    byref rhs as string )
  
  _string += rhs
end operator

operator _
  XString.&=( _
    byref rhs as string )
  
  _string &= rhs
end operator

operator _
  XString.+=( _
    byref rhs as XString )
  
  _string += rhs._string
end operator

operator _
  XString.&=( _
    byref rhs as XString )
  
  _string &= rhs._string
end operator

property _
  XString.chars() _
  as ubyte ptr
  
  return( @_string[ 0 ] )
end property

property _
  XString.char( _
    byval aPosition as uinteger ) _
  as string
  
  return( chr( _string[ aPosition - 1 ] ) )
end property

property _
  XString.length() _
  as uinteger
  
  return( len( _string ) )
end property

property _
  XString.isEmpty() _
  as boolean
  
  return( cbool( _string = "" ) )
end property

function _
  XString.getHashCode() _
  as ulong
  
  dim as ulong _
    hash
  
  for _
    i as integer => 0 _
    to len( _string ) - 1
    
    hash => ( hash shl 4 ) xor _
      ( hash shr 28 ) xor ( _string )[ i ]
  next
  
  return( hash )
end function

function _
  XString.contains( _
    byref aString as const string ) _
  as boolean
  
  return( cbool( inStr( _
    _string, aString ) > 0 ) )
end function

function _
  XString.toLower() _
  as XString
  
  return( lcase( _string ) )
end function

function _
  XString.toUpper() _
  as XString
  
  return( ucase( _string ) )
end function

function _
  XString.substring( _
    byval start as uinteger ) _
  as XString
  
  return( mid( _string, start ) )
end function

function _
  XString.substring( _
    byval start as uinteger, _
    byval aLength as uinteger ) _
  as XString
  
  return( mid( _string, start, aLength ) )
end function

operator _ 
  + ( _
    byref lhs as XString, _
    byref rhs as XString ) _
  as XString
  
  return( cast( string, lhs ) + cast( string, rhs ) )
end operator

operator _ 
  & ( _
    byref lhs as XString, _
    byref rhs as XString ) _
  as XString
  
  return( cast( string, lhs ) & cast( string, rhs ) )
end operator

operator _
  =( _
    byref lhs as XString, _
    byref rhs as XString ) _
  as integer
  
  return( cast( string, lhs ) = cast( string, rhs ) )
end operator

function _
  XString.positionOf( _
    byref another as XString ) _
  as uinteger
  
  return( inStr( _string, another ) )
end function

function _
  XString.positionOf( _
    byref another as XString, _
    byval start as uinteger ) _
  as uinteger
  
  return( inStr( start, _string, another ) )
end function

function _
  XString.positionOfAny( _
    byref another as XString ) _
  as uinteger
  
  return( inStr( _string, any another ) )
end function

function _
  XString.positionOfAny( _
    byref another as XString, _
    byval start as uinteger ) _
  as uinteger
  
  return( inStr( start, _string, any another ) )
end function

function _
  XString.leftmost( _
    byval numChars as uinteger ) _
  as XString
  
  return( left( _string, numChars ) )
end function

function _
  XString.rightmost( _
    byval numChars as uinteger ) _
  as XString
  
  return( right( _string, numChars ) )
end function

function _
  XString.splice( _
    byref other as XString ) _
  as XString
  
  '' Trivial rejects
  if( _string = "" ) then
    return( "" )
  end if
  
  dim as uinteger _
    startPos => positionOf( other )
  
  if( startPos = 0 ) then
    return( _string )
  end if
  
  dim as XString _
    leftPart => leftmost( startPos - 1 ), _
    rightPart => rightmost( _
      length - ( startPos + other.length ) - 1 ), _
    spliced => substring( startPos, other.length )
  
  _string => leftPart + rightPart
  
  return( spliced )
end function

function _
  XString.split( _
    byref delimiters as const string ) _
  as Array( of( string ) ) ptr
  
  '' Trivial reject
  if( _
    len( _string ) = 0 orElse _
    len( delimiters ) = 0 ) then
    
    return( new Array( of( string ) ) )
  end if
  
  '' Trivial accept
  if( inStr( _
    _string, _
    any delimiters ) = 0 andAlso _
    len( _string ) > 0 ) then
    
    var _
      a => new Array( of( string ) )
    
    a->add( _string )
    
    return( a )
  end if
  
  dim as uinteger _
    count => 0, _
    wordCount => 0, _
    position => 0
  
  '' Tally the positions of the delimiters on the string
  dim as integer _
    positions( any )
  redim _
    positions( 1 to 2000 )
  
  do
    position => inStr( _
      position + 1, _
      _string, _
      any delimiters )
    
    '' Delimiter found?
    if( position > 0 ) then
      count +=> 1
      
      if( count > ubound( positions ) ) then
        redim preserve _
          positions( 1 to ubound( positions ) * 2 )
      end if
      
      positions( count ) => position
      
      if( _
        count > 1 andAlso _
        position > positions( count - 1 ) + 1 ) then
        
        wordCount +=> 1
      end if
    end if
  loop until( position = 0 )
  
  /'
    If the last position tallied isn't at the end of the string, it
    means that the last token is a word, so account for it.
  '/
  if( positions( count ) < len( _string ) ) then
    wordCount +=> 1
  end if
  
  '' Then fetch all the tokens, delimiters included
  position => 0
  
  dim as string _
    token
  
  '' First token is a word?
  if( positions( position + 1 ) > 1 ) then
    token => mid( _
      _string, _
      1, _
      positions( position + 1 ) - 1 )
    
    wordCount +=> 1
  end if
  
  var _
    result => new Array( of( string ) )( ( wordCount + count ) * 3 )
  
  if( len( token ) > 0 ) then
    result->add( token )
  end if
  
  dim as integer _
    startPos, endPos
  
  do while _
    ( position < count )
    
    position += 1
    
    '' Delimiter?
    token => mid( _
      _string, _
      positions( position ), _
      1 )
    
    if( len( token ) > 0 ) then
      result->add( token )
    end if
    
    '' Word?
    if( _
      positions( position ) + 1 <> positions( position + 1 ) andAlso _
      positions( position ) + 1 <= len( _string ) ) then
      
      token => mid( _
        _string, _
        positions( position ) + 1, _
        positions( position + 1 ) - positions( position ) - 1 )
      
      if( len( token ) > 0 ) then
        result->add( token )
      end if
    end if
  loop
  
  return( result )
end function

function _
  XString.fromFile( _
    byref aPath as const string ) _
  as XString
  
  dim as string _
    content => ""
  
  if( fileExists( aPath ) ) then
    dim as long _
      fileHandle => freeFile()
    
    open _
      aPath _
      for binary access read _
      as fileHandle
    
    '' Resize string to fit content
    content => space( lof( fileHandle ) )
    
    '' And get it all at once
    get #fileHandle, , content
    
    close( fileHandle )
  end if
  
  return( XString( content ) )
end function

function _
  XString.startsWith( _
    byref aString as const string ) _
  as boolean
  
  return( cbool( left( _
    _string, len( aString ) ) = aString ) )
end function

function _
  XString.endsWith( _
    byref aString as const string ) _
  as boolean
  
  return( cbool( right( _
    _string, len( aString ) ) = aString ) )
end function

#endif
