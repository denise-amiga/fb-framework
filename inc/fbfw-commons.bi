#ifndef __FBFW_COMMONS_BI__
#define __FBFW_COMMONS_BI__

#define __FBFW_FOLDER__ _
  fbfw/

#define __fbfw_str__( a ) _
  #a
#define __fbfw_conc__( a, b ) _
  ##a##b
#define __fbfw_inc__( p, f ) _
  __fbfw_str__( __fbfw_conc__( p, f ) )

#macro __include__( p, f ) _
  #include once __fbfw_inc__( p, f )
#endmacro

#define __FBFW_AUTO_PTR_FOLDER__ _
  auto-ptr/
#define __FBFW_COLLECTIONS_FOLDER__ _
  collections/
#define __FBFW_DEBUG_FOLDER__ _
  debug/
#define __FBFW_DRAWING_FOLDER__ _
  drawing/
#define __FBFW_EASINGS_FOLDER__ _
  easings/
#define __FBFW_EVENTS_FOLDER__ _
  events/
#define __FBFW_GRAPHICS_FOLDER__ _
  graphics/
#define __FBFW_INTERACTION_FOLDER__ _
  interaction/
#define __FBFW_MATH_FOLDER__ _
  math/
#define __FBFW_RANDOMIZATION_FOLDER__ _
  randomization/
#define __FBFW_TASKS_FOLDER__ _
  tasks/
#define __FBFW_THREADING_FOLDER__ _
  threading/
#define __FBFW_WINDOWING_FOLDER__ _
  windowing/
#define __FBFW_XML_FOLDER__ _
  xml/

namespace FbFw
  const as string _
    stCr => chr( 13 ), _
    stLf => chr( 10 ), _
    stCrLf => chr( 13, 10 ), _
    stTab => chr( 9 ), _
    stVerticalTab => chr( 11 ), _
    stSpace => chr( 32 ), _
    stBack => chr( 8 ), _
    stFormFeed => chr( 12 )
end namespace

#endif
