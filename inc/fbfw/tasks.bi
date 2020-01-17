#ifndef __FBFW_TASKS_BI__
#define __FBFW_TASKS_BI__

#include once "vbcompat.bi"

#include once "fbfw-collections.bi"
#include once "fbfw-events.bi"

#if __FB_OUT_EXE__
  #undef export
  #define export
#endif

namespace Tasks
  const _
    TasksNull => 0
end namespace

__include__( __FBFW_TASKS_FOLDER__, ITask.bi )
__include__( __FBFW_TASKS_FOLDER__, task.bi )
__include__( __FBFW_TASKS_FOLDER__, worker-thread-base.bi )
__include__( __FBFW_TASKS_FOLDER__, worker-thread-monitor.bi )
__include__( __FBFW_TASKS_FOLDER__, task-manager-monitor.bi )
__include__( __FBFW_TASKS_FOLDER__, task-manager.bi )
__include__( __FBFW_TASKS_FOLDER__, worker-thread.bi )

#endif
