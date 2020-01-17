#ifndef __FBFW_XML_NODE_LIST__
#define __FBFW_XML_NODE_LIST__

namespace Xml
  template( LinkedList, of( XmlNode ) )
  
  /'
    Represents a list of Xml nodes
  '/
  type _
    XmlNodeList _
    extends Object
    
    public:
      declare constructor()
      declare virtual destructor()
      
      declare property _
        count() as integer
      declare property _
        nodes() as LinkedList( of( XmlNode ) ) ptr
      
      declare property _
        first() as LinkedListNode( of( XmlNode ) ) ptr
      declare property _
        last() as LinkedListNode( of( XmlNode ) ) ptr
      
      declare sub _
        append( _
          byval as XmlNode ptr )
      declare sub _
        prepend( _
          byval as XmlNode ptr )
        
    private:
      as LinkedList( of( XmlNode ) ) ptr _
        _nodes
  end type
  
  constructor _
    XmlNodeList()
  end constructor
  
  destructor _
    XmlNodeList()
    
    if( _nodes <> XmlNull ) then
      delete( _nodes )
    end if
  end destructor
  
  property _
    XmlNodeList.count() _
    as integer
    
    if( _nodes <> XmlNull ) then
      return( _nodes->count )
    else
      return( 0 )
    end if
  end property
  
  property _
    XmlNodeList.first() _
    as LinkedListNode( of( XmlNode ) ) ptr
    
    return( _nodes->first )
  end property
  
  property _
    XmlNodeList.last() _
    as LinkedListNode( of( XmlNode ) ) ptr
    
    return( _nodes->last )
  end property
  
  property _
    XmlNodeList.nodes() _
    as LinkedList( of( XmlNode ) ) ptr
    
    return( _nodes )
  end property
  
  sub _
    XmlNodeList.append( _
      byval aNode as XmlNode ptr )
    
    if( _nodes = XmlNull ) then
      _nodes => new LinkedList( of( XmlNode ) )
    end if
    
    _nodes->addLast( aNode )
  end sub
  
  sub _
    XmlNodeList.prepend( _
      byval aNode as XmlNode ptr )
    
    if( _nodes = XmlNull ) then
      _nodes => new LinkedList( of( XmlNode ) )
    end if
    
    _nodes->addFirst( aNode )
  end sub
end namespace

#endif
