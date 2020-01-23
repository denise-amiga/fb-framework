#include once "fbfw-drawing.bi"

/'
  Miscelaneous utility functions and classes. Mostly for
  debugging/presentation purposes.
'/
function _
  align( _
    byval anAlignment as Drawing.Alignment, _
    byval extents as integer, _
    byval length as integer ) _
  as integer
  
  dim as integer _
    alignPos => 1
  
  select case as const( anAlignment )
    case( Drawing.Alignment.Left )
      alignPos => 1
    
    case( Drawing.Alignment.Center )
      alignPos => ( extents - length ) \ 2
    
    case( Drawing.Alignment.Right )
      alignPos => extents - length + 1
  end select
  
  return( alignPos )
end function

sub _
  rect( _
    byval x as integer, _
    byval y as integer, _
    byval w as integer, _
    byval h as integer, _
    byval fc as integer => 7, _
    byval bc as integer => 0 )
  
  color( fc, bc )
  
  locate y, x, 0
  
  ? chr( 218 ); string( w - 2, chr( 196 ) ); chr( 191 );
  
  for _
    i as integer => 1 to h - 2
    
    locate y + i, x
    ? chr( 179 ); string( w - 2, " " ); chr( 179 );
  next
  
  locate y + h - 1, x
  ? chr( 192 ); string( w - 2, chr( 196 ) ); chr( 217 );
end sub

sub _
  background( _
    byval fc as integer => 7, _
    byval bc as integer => 2 )
  
  cls()
  color( 7, 2 )
  
  for _
    i as integer => 1 to 25
    
    ? "01234567890123456789012345678901234567890123456789012345678901234567890123456789";
  next
end sub

sub _
  teletypedText( _
    byval x as integer, _
    byval y as integer, _
    byref aText as const string, _
    byval aWidth as integer, _
    byval aPosition as integer )
  
  locate _
    y, x, 0
  color 0, 7
  
  ? string( aWidth, " " );
  
  dim as integer _
    length => iif( aWidth - aPosition > 0, _
      aPosition, _
      aWidth )
  
  x => iif( aWidth - aPosition > 0, _
    ( x + aWidth ) - aPosition, _
    x )
  
  locate _
    y, x
  ? mid( aText, iif( aPosition < aWidth, _
      1, _
      ( aPosition - aWidth ) + 1 ), _
      length );
end sub

type _
  MessageBox
  
  public:
    declare constructor( _
      byval as integer, _
      byval as integer, _
      byval as integer, _
      byval as integer, _
      byref as const string => "" )
    declare destructor()
    
    declare sub _
      addLine( _
        byref as const string )
    declare sub _
      show()
    declare sub _
      clear()
    
  private:
    declare constructor()
    
    as string _
      _lines( any ), _
      _title
    as integer _
      _X, _Y, _
      _width, _
      _height, _
      _currentLine, _
      _maxLine
    as any ptr _
      _mutex
end type

constructor _
  MessageBox()
end constructor

constructor _
  MessageBox( _
    byval aX as integer, _
    byval aY as integer, _
    byval aWidth as integer, _
    byval aHeight as integer, _
    byref aTitle as const string => "" )
  
  _X => aX
  _Y => aY
  _title => aTitle
  _width => aWidth
  _height => iif( aHeight < 3, 3, aHeight )
  
  _maxLine => _height - 1
  
  redim preserve _
    _lines( 0 to _maxLine - 1 )
  
  _currentLine => 0
  
  _mutex => mutexCreate()
end constructor

destructor _
  MessageBox()
  
  mutexDestroy( _mutex )
end destructor

sub _
  MessageBox.clear()
  
  for _
    i as integer => 0 _
    to _maxLine - 1
    
    _lines( i ) => ""
  next
  
  _currentLine => 0
end sub

/'
  Adds a line of text to the Message Box.
  
  Note that the Message Box maintains a list of lines that's actually
  ONE line more than what's displayed. So, if the current line count
  is out the window, the line of text gets added and the displayed
  lines scrolled, so the last line added is always at the bottom.
'/
sub _
  MessageBox.addLine( _
    byref aText as const string )
  
  if( _currentLine < _maxLine - 1 ) then
    _lines( _currentLine ) => aText
    _currentLine +=> 1
  else
    _lines( _currentLine ) => aText
    
    for _
      i as integer => 0 _
      to _maxLine - 2
      
      _lines( i ) => _lines( i + 1 )
    next
  end if
end sub

sub _
  MessageBox.show()
  
  mutexLock( _mutex )
    screenLock()
      rect( _X, _Y, _width, _height )
      
      for _
        i as integer => 0 _
        to _maxLine - 2
        
        locate( _Y + i + 1, _X + 1 )
        ? left( _lines( i ), _width - 2 );
      next
      
      dim as string _
        centeredTitle => iif( _
          _title <> "", _
          " " + _title + " ", _
          "" )
        
      locate( _
        _Y, _X + align( _
          Drawing.Alignment.Center, _
          _width, _
          len( centeredTitle ) ) )
        
      ? centeredTitle;
    screenUnlock()
  mutexUnlock( _mutex ) 
end sub

sub _
  displayTaskManagerMonitor( _
    byval aMonitor as Tasks.TaskManagerMonitor ptr, _
    byval aMessageBox as MessageBox ptr )
  
  aMessageBox->clear()
  
  aMessageBox->addLine( _
    "Start time: " & format( _
      aMonitor->startTime, _
      "ddd d, mmm yyyy hh:mm:ss" ) )
  aMessageBox->addLine( _
    "Running time: " & format( _
      aMonitor->runningTime, _
      "hh:mm:ss" ) )
  aMessageBox->addLine( _
    "Available threads: " & aMonitor->availableThreads )
  aMessageBox->addLine( _
    "Idle threads: " & aMonitor->idleThreads )
  aMessageBox->addLine( _
    "Completed tasks: " & aMonitor->completedTasks )
  
  aMessageBox->show()
end sub

sub _
  displayWorkerThreadMonitor( _
    byval aMonitor as Tasks.TaskManagerMonitor ptr, _
    byval aMessageBox as MessageBox ptr )
  
  aMessageBox->clear()
  
  for _
    i as integer => 0 _
    to aMonitor->availableThreads - 1
    
    aMessageBox->addLine( _
      "tid: " + aMonitor->thread( i )->threadID + _
      "   completed tasks:" & aMonitor->thread( i )->completedTasks )
    aMessageBox->addLine( _
      " total idle time:" & format( _
        aMonitor->thread( i )->idleTime, _
        "#0.000" ) )
    aMessageBox->addLine( _
      " total work time:" & format( _
        aMonitor->thread( i )->workTime, _
        "#0.000" ) )
  next
  
  aMessageBox->show()
end sub

type _
  InfoCenter
  
  public:
    declare constructor( _
      byval as Tasks.TaskManagerMonitor ptr, _
      byval as double )
    declare destructor()
    
    declare sub _
      start()
    declare sub _
      update()
    declare sub _
      message( _
        byref as const string )
      
  private:
    declare constructor()
    
    as MessageBox _
      _taskManagerMsgBox => MessageBox( _
        1, 1, _
        50, 12, _
        "Task Manager info" ), _
      _workerThreadMsgBox => MessageBox( _
        51, 1, _
        50, 32, _
        "Worker threads info" ), _
      _infoMsgBox => MessageBox( _
        1, 33, _
        100, 10, _
        "Task info" )
    
    as Tasks.TaskManagerMonitor ptr _
      _taskManagerMonitor
    as double _
      _elapsed, _
      _updateInterval
end type

constructor _
  InfoCenter()
end constructor

constructor _
  InfoCenter( _
    byval aTaskManagerMonitor as Tasks.TaskManagerMonitor ptr, _
    byval anUpdateInterval as double )
  
  _taskManagerMonitor => aTaskManagerMonitor
  _updateInterval => anUpdateInterval
end constructor

destructor _
  InfoCenter()
  
  delete( _taskManagerMonitor )
end destructor

sub _
  InfoCenter.start()
  
  _elapsed => timer()
end sub

sub _
  InfoCenter.update()
  
  _elapsed => timer() - _elapsed
  
  if( _elapsed * 1000.0 > _updateInterval ) then
    _infoMsgBox.show()
    
    displayTaskManagerMonitor( _
      _taskManagerMonitor, _
      @_taskManagerMsgBox )
    displayWorkerThreadMonitor( _
      _taskManagerMonitor, _
      @_workerThreadMsgBox )
  end if
end sub

sub _
  InfoCenter.message( _
    byref aMessage as const string )
  
  _infoMsgBox.addLine( aMessage )
end sub
