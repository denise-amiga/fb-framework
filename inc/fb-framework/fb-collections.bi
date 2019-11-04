#ifndef __FB_COLLECTIONS__
#define __FB_COLLECTIONS__

#include once "templates.bi"

/'
  Framework for strongly-typed templated collections.
  
  10/30/2019
    Added support for variadic macros (Freebasic >= 1.07.1).
  
  10/26/2019
    Initial version.
  
  TODO:
    - Optimize code generation size. This will have a slight impact
      on performance but a MAJOR impact on executable size and
      compile times.
    - Add support for disposing callbacks for all collections.
    - Implement the selectAll() method for all collections where it
      will make sense.
    - Implement iterators.
'/
#include once "collections/TKeys.bi"
#include once "collections/TPredicate.bi"
#include once "collections/TAction.bi"
#include once "collections/TKeyValuePair.bi"

#include once "collections/ICollection.bi"

#include once "auto-ptr.bi"

/'
  The templated type itself expands into the current namespace,
  but this is reserved for future expansions, and to integrate
  your own collection code.
'/
namespace Collections
  '' The priority order for Priority Queues
  enum PriorityOrder
    Ascending
    Descending
  end enum
end namespace

/'
  Standard collections
'/

#include once "collections/TArray.bi"
#include once "collections/TList.bi"
#include once "collections/TLinkedList.bi"
#include once "collections/TDictionary.bi"
#include once "collections/TPriorityQueue.bi"

#endif
