// Feather disable all

/// Returns the scroll speed for an element, in pixels per frame.
/// 
/// @param [element=self]

function BentoScrollGetSpeed(_element = self)
{
    var _scroller = __BentoFindScrollElement(_element);
    if (not BentoExists(_scroller)) return 0;
    
    with(_scroller.BENTO_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return 0;
        return __scrollSpeed;
    }
    
    return 0;
}