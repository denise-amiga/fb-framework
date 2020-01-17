#ifndef __FBFW_THREADING_THREAD__
#define __FBFW_THREADING_THREAD__

namespace Threading
  /'
    Minimal abstraction that represents a thread of execution. Meant to create
    independent classes that do processing on the background.
  '/
  type _
    Thread _
    extends Object
    
    public:
      declare virtual destructor()
      
      declare sub _
        lock()
      declare sub _
        unlock()
      
      declare sub _
        start()
      declare sub _
        pause()
      declare sub _
        resume()
      
    protected:
      declare constructor()
      
      declare virtual sub _
        onRun()
      
    private:
      declare static sub _
        run( _
          byval as Thread ptr )
        
      declare sub _
        stop()
      
      as any ptr _
        _thread, _
        _mutex
      as boolean _
        _running, _
        _paused
  end type
  
  constructor _
    Thread()
    
    _mutex => mutexCreate()
    
    _thread => threadCreate( _
      cptr( _
        sub( byval as any ptr ), _
        @run ), _
      @this )
  end constructor
  
  destructor _
    Thread()
    
    this.stop()
    
    threadWait( _thread )
    mutexDestroy( _mutex )
  end destructor
  
  sub _
    Thread.lock()
    
    mutexLock( _mutex )
  end sub
  
  sub _
    Thread.unlock()
    
    mutexUnlock( _mutex )
  end sub
  
  sub _
    Thread.start()
    
    _running => true 
  end sub
  
  sub _
    Thread.stop()
    
    _running => false
  end sub
  
  sub _
    Thread.pause()
    
    _paused => true
  end sub
  
  sub _
    Thread.resume()
    
    _paused => false
  end sub
  
  /'
    The Thread object will call the 'onRun()' virtual method continuously,
    until the object is destroyed.
  '/
  sub _
    Thread.run( _
      byval instance as Thread ptr )
    
    do while( instance->_running )
      if( not instance->_paused ) then
        instance->onRun()
      end if
      
      sleep( 1, 1 )
    loop
  end sub
  
  sub _
    Thread.onRun()
  end sub
end namespace

#endif
