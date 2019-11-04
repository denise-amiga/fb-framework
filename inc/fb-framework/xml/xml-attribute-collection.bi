#ifndef __FB_XML_XMLATTRIBUTECOLLECTION__
#define __FB_XML_XMLATTRIBUTECOLLECTION__

namespace Xml
  template( LinkedList, of( XmlAttribute ) )
  
  /'
    Represents the collection of attributes for a Xml node
  '/
  type _
    XmlAttributeCollection _
    extends Object
    
    public:
      declare constructor()
      declare virtual destructor()
      
      declare property _
        count() as integer
      
      declare property _
        first() as LinkedListNode( of( XmlAttribute ) ) ptr
      declare property _
        last() as LinkedListNode( of( XmlAttribute ) ) ptr
      
      declare sub _
        append( _
          byval as XmlAttribute ptr )
      declare sub _
        prepend( _
          byval as XmlAttribute ptr )
        
    private:
      as LinkedList( of( XmlAttribute ) ) ptr _
        _attributes
  end type
  
  constructor _
    XmlAttributeCollection()
  end constructor
  
  destructor _
    XmlAttributeCollection()
    
    if( _attributes <> XmlNull ) then
      delete( _attributes )
    end if
  end destructor
  
  property _
    XmlAttributeCollection.count() _
    as integer
    
    if( _attributes <> XmlNull ) then
      return( _attributes->count )
    else
      return( 0 )
    end if
  end property
  
  property _
    XmlAttributeCollection.first() _
    as LinkedListNode( of( XmlAttribute ) ) ptr
    
    return( _attributes->first )
  end property
  
  property _
    XmlAttributeCollection.last() _
    as LinkedListNode( of( XmlAttribute ) ) ptr
    
    return( _attributes->last )
  end property
  
  sub _
    XmlAttributeCollection.append( _
      byval anAttribute as XmlAttribute ptr )
    
    if( _attributes = XmlNull ) then
      _attributes => new LinkedList( of( XmlAttribute ) )
    end if
    
    _attributes->addLast( anAttribute )
  end sub
  
  sub _
    XmlAttributeCollection.prepend( _
      byval anAttribute as XmlAttribute ptr )
    
    if( _attributes = XmlNull ) then
      _attributes => new LinkedList( of( XmlAttribute ) )
    end if
    
    _attributes->addFirst( anAttribute )
  end sub
end namespace

#endif