// Feather disable all

/// @param [instance=self]

function GuiScrollGetFinished(_instance = self)
{
    var _scroller = __GuiScrollFindParent(_instance);
    if (not GUI_EXISTS(_scroller)) return false;
    
    with(_scroller.GUI_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return false;
        return ((__scrollX == __scrollTargetX) && (__scrollY == __scrollTargetY));
    }
    
    return 0;
}