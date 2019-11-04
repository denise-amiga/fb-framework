#include once "parsing.bi"

using Parsing

dim as StringType _
  test => "The quick brown fox jumps over the lazy dog", _
  spliced

test => Strings.splice( test, spliced, " quick brown" )

? test
? trim( spliced )

test => "foo:bar:baz"

? Strings.leftOf( ":", test )
? Strings.rightOf( ":", test )
? Strings.leftOf( ":", Strings.rightOf( ":", test ) )
? Strings.rightOf( ":", Strings.rightOf( ":", test ) )

test => Strings.splice( _
  test, spliced, Strings.leftOf( ":", test ) )

? test
? spliced

test => "image-1.bmp"

? Strings.startsWith( "image-1", test )
? Strings.endsWith( ".bmp", test )

test => "The, quick, brown, fox"

?
var _
  tokens => Strings.split( test, ", " )

for _
  i as integer => 0 _
  to tokens->count - 1
  
  ? tokens->at( i )
next

sleep()
