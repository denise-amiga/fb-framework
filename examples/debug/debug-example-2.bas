#include once "fbfw-debug.bi"

/'
  Example showing how to implement error logging to the console
  when the app is in 'Debug Mode'.
'/
#define DEBUG_MODE

#define inDebug _
  #ifdef DEBUG_MODE

#define endDebug _
  #endif

var _
  aConsole => Debug.Console()

screenRes( 800, 600, 32 )

inDebug
  ? "In debug mode!"
  aConsole.write( "ERROR 1: Something happened!" )
  sleep()
endDebug
