// Feather disable all

/// @param [element=self]

function BentoScrollGetSpeed(_element = self)
{
    var _scroller = __BentoScrollFindParent(_element);
    if (not BentoExists(_scroller)) return 0;
    
    with(_scroller.GUI_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return 0;
        return __scrollSpeed;
    }
    
    return 0;
}