// Feather disable all

/// @param [instance=id]

function GuiScrollGetFinished(_instance = id)
{
    var _scroller = __GuiScrollFindParent(_instance);
    if (not instance_exists(_scroller)) return false;
    
    with(_scroller.GUI_STRUCT)
    {
        if ((not __scrollHori) && (not __scrollVert)) return false;
        return ((__scrollX == __scrollTargetX) && (__scrollY == __scrollTargetY));
    }
    
    return 0;
}