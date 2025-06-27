// Feather disable all

/// @param [element=self]

function BentoScrollGetFinished(_element = self)
{
    var _scroller = __BentoScrollFindParent(_element);
    if (not BentoExists(_scroller)) return false;
    
    with(_scroller.GUI_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return false;
        return ((__scrollX == __scrollTargetX) && (__scrollY == __scrollTargetY));
    }
    
    return 0;
}