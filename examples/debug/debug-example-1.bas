#include once "fbfw-debug.bi"

/'
  Example showing how to implement a simple error logger when
  the app is in 'Debug Mode'.
'/
#define DEBUG_MODE

#define inDebug _
  #ifdef DEBUG_MODE

#define endDebug _
  #endif

var _
  aLog => Debug.Logger( "errors.txt" )

inDebug
  ? "In debug mode!"
  aLog.write( "ERROR 1: Something happened!" )
  sleep()
endDebug
