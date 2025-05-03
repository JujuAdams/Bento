// Feather disable all

/// @param [element=self]

function GuiScrollGetFinished(_element = self)
{
    var _scroller = __GuiScrollFindParent(_element);
    if (not GUI_EXISTS(_scroller)) return false;
    
    with(_scroller.GUI_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return false;
        return ((__scrollX == __scrollTargetX) && (__scrollY == __scrollTargetY));
    }
    
    return 0;
}