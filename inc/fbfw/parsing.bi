#ifndef __FBFW_PARSING__
#define __FBFW_PARSING__

#include once "file.bi"
#include once "fbfw-collections.bi"

/'
  Framework for common string parsing tasks.
  
  Entirely procedural, with a functional-style flavor. Their efficiency will
  of course depend on the string type used.
'/
namespace Parsing
  /'
    Alias for the string type used.
  '/
  type as string _
    StringType
  
  template( Array, of( StringType ) )
  
  enum _
    SpecialChars
    
    Null => 0
    Tab => 9
    Lf => 10
    Cr => 13
    Space => 32
  end enum
  
  const as StringType _
    fbCr => chr( SpecialChars.Cr ), _
    fbLf => chr( SpecialChars.Lf ), _
    FbCrLf => chr( SpecialChars.Cr ) & chr( SpecialChars.Lf )
  
  namespace Strings
    /'
      Defines a string containing the chars considered whitespace
    '/
    const as StringType _
      WhiteSpace => _
        chr( SpecialChars.Tab ) + _
        chr( SpecialChars.Lf ) + _
        chr( SpecialChars.Cr ) + _
        chr( SpecialChars.Space )
    
    function _
      isWhitespace( _
        byval aChar as ubyte ) _
      as boolean
      
      return( cbool( _
        aChar = SpecialChars.Tab orElse _
        aChar = SpecialChars.Lf orElse _
        aChar = SpecialChars.Cr orElse _
        aChar = SpecialChars.Space ) )
    end function
    
    function _
      skipWhitespace( _
        byref subject as const StringType, _
        byval position as uinteger ) _
      as uinteger
      
      do while( _
        cbool( position < len( subject ) ) andAlso _
        isWhitespace( subject[ position - 1 ] ) )
        
        position +=> 1
      loop
      
      return( position )
    end function
    
    /'
      Returns whether or not the specified char is within the subject string
    '/
    function _
      within( _
        byval aChar as ubyte, _
        byref subject as const StringType ) _
      as boolean
      
      for _
        i as integer => 0 _
        to len( subject ) - 1
        
        if( aChar = subject[ i ] ) then
          return( true )
        end if
      next
      
      return( false )
    end function
    /'
      Splices a string and returns it trimmed, with the spliced
      string in the 'aSplice' parameter.
    '/
    function _
      splice( _
        byref subject as const StringType, _
        byref aSplice as StringType, _
        byref other as const StringType ) _
      as StringType
      
      '' Trivial rejects
      if( other = "" ) then
        aSplice => ""
        return( subject )
      end if
      
      if( subject = "" ) then
        aSplice => ""
        return( "" )
      end if
      
      dim as StringType _
        leftString, _
        rightString
      
      dim as integer _
        startPos => inStr( subject, other )
      
      if( startPos = 0 ) then
        return( subject )
      end if
      
      leftString => _
        left( subject, startPos - 1 )
      rightString => _
        right( subject, _
          len( subject ) - ( startPos + len( other ) - 1 ) )
      aSplice => _
        mid( subject, startPos, len( other ) )
      
      return( leftString + rightString )
    end function
    
    /'
      Returns whether or not a string starts with the specified
      prefix.
    '/
    function _
      startsWith( _
        byref aPrefix as const StringType, _
        byref aString as const StringType ) _
      as boolean
      
      return( cbool( left( _
        aString, len( aPrefix ) ) = aPrefix ) )
    end function
    
    /'
      Returns whether or not a string ends with the specified
      suffix.
    '/
    function _
      endsWith( _
        byref aSuffix as const StringType, _
        byref aString as const StringType ) _
      as boolean
      
      return( cbool( right( _
        aString, len( aSuffix ) ) = aSuffix ) )
    end function
    
    /'
      Retrieves the string at the left of the specified char,
      without including it.
    '/
    function _
      leftOf( _
        byref aChar as const StringType, _
        byref aString as const StringType ) _
      as StringType
      
      return( mid( _
        aString, 1, inStr( aString, aChar ) - 1 ) )
    end function
    
    /'
      Retrieves the string at the right of the specified char,
      without including it.
    '/
    function _
      rightOf( _
        byref aChar as const StringType, _
        byref aString as const StringType ) _
      as StringType
      
      dim as uinteger _
        startPos => inStr( aString, aChar )
      
      return( mid( _
        aString, startPos + 1, len( aString ) - startPos ) )
    end function
    
    /'
      Returns how many characters of the specified charcode a string
      contains.
    '/
    function _
      howMany( _
        byref aCharcode as uinteger, _
        byref aString as const string ) _
      as integer
      
      dim as integer _
        count
      
      for _
        i as integer => 0 _
        to len( aString ) - 1
        
        count => iif( aString[ i ] = aCharcode, _
          count + 1, count )
      next
      
      return( count )
    end function
    
    /'
      Tests whether or not a string matches any string of the given set
      at the specified position. Returns the 0-based index into the set
      if a match was found, -1 if not.
    '/
    function _
      match( _
        byref subject as const StringType, _
        byref aSet as Array( of( StringType ) ), _
        byval position as uinteger ) _
      as integer
      
      dim as integer _
        result => -1
      
      for _
        i as integer => 0 _
        to aSet.count - 1
        
        if( _
          len( aSet.at( i ) ) > 0 andAlso _
          mid( _
            subject, _
            position, _
            len( aSet.at( i ) ) ) = aSet.at( i ) ) then
          
          result => i
          exit for
        end if
      next
      
      return( result )
    end function
    
    /'
      Loads a file as a string.
      
      Not exactly rocket-science, but this is a handy function to have.
    '/
    function _
      fromFile( _
        byref aPath as const StringType ) _
      as StringType
      
      dim as StringType _
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
      
      return( content )
    end function
    
    /'
      Splits a string into tokens, using the specified delimiters. The
      last optional parameter allows you to specify whether you want the
      function to retrieve the delimiters or not.
    '/
    function _
      split( _
        byref aString as StringType, _
        byref delimiters as const StringType, _
        byval retrieveDelimiters as boolean => true ) _
      as auto_ptr( of( Array( of( StringType ) ) ) )
      
      '' Trivial reject
      if( _
        len( aString ) = 0 orElse _
        len( delimiters ) = 0 ) then
        
        return( auto_ptr( of( Array( of( StringType ) ) ) ) _
          ( new Array( of( StringType ) )() ) )
      end if
      
      '' Trivial accept, just one word
      if( inStr( _
        aString, _
        any delimiters ) = 0 andAlso _
        len( aString ) > 0 ) then
        
        var _
          a => new Array( of( StringType ) )()
        
        a->add( aString )
        
        return( auto_ptr( _
          of( Array( of( StringType ) ) ) )( a ) )
      end if
      
      dim as uinteger _
        count => 0, _
        wordCount => 0, _
        position => 0
      
      /'
        Preallocates the positions of the delimiters on the string.
        Not memory friendly, but on big strings this makes a world
        of difference.
      '/
      dim as uinteger ptr _
        positions => allocate( len( aString ) * sizeOf( uinteger ) )
      
      /'
        Tally the positions of the delimiters on the string.
        
        However naive this algorithm might look, it's actually smoking-hot fast.
        All others I have tested (including a scheme using a specialized hash
        table(!)) failed to outperform this. Reasons are, of course, the simplicity
        and linearity of the iteration (which helps the cache immensely).
      '/
      for _
        i as uinteger => 0 _
        to len( aString ) - 1
        
        for _
          char as uinteger => 0 _
          to len( delimiters ) - 1
          
          if( aString[ i ] = delimiters[ char ] ) then
            count +=> 1
            positions[ count ] => i + 1
            
            if( _
              count > 1 andAlso _
              ( i + 1 ) > positions[ count - 1 ] + 1 ) then
              
              wordCount +=> 1
            end if
            
            exit for
          end if
        next
      next
      
      /'
        If the last position tallied isn't at the end of the string, it
        means that the last token is a word, so account for it.
      '/
      if( positions[ count ] < len( aString ) ) then
        wordCount +=> 1
      end if
      
      '' Then fetch all the tokens, delimiters included
      position => 0
      
      dim as StringType _
        token
      
      '' First token is a word?
      if( positions[ position + 1 ] > 1 ) then
        token => mid( _
          aString, _
          1, _
          positions[ position + 1 ] - 1 )
        
        wordCount +=> 1
      end if
      
      dim as integer _
        tokenCount => iif( retrieveDelimiters, _
          wordCount + count, _
          wordCount )
      
      var _
        result => new Array( of( StringType ) ) _
          ( tokenCount * 2 )
      
      '' Add the first word
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
          aString, _
          positions[ position ], _
          1 )
        
        if( _
          len( token ) > 0 andAlso _
          retrieveDelimiters ) then
          
          result->add( token )
        end if
        
        '' Word?
        if( _
          positions[ position ] + 1 <> positions[ position + 1 ] andAlso _
          positions[ position ] + 1 <= len( aString ) ) then
          
          token => mid( _
            aString, _
            positions[ position ] + 1, _
            positions[ position + 1 ] - positions[ position ] - 1 )
          
          if( len( token ) > 0 ) then
            result->add( token )
          end if
        end if
      loop
      
      '' Release the preallocated buffer of positions
      deallocate( positions )
      
      '' And return an auto_ptr with the results
      return( auto_ptr( _
        of( Array( of( StringType ) ) ) )( result ) )
    end function
  end namespace
end namespace

#endif
