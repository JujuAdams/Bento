// Feather disable all

/// @param [element=self]

function GuiScrollGetSpeed(_element = self)
{
    var _scroller = __GuiScrollFindParent(_element);
    if (not GUI_EXISTS(_scroller)) return 0;
    
    with(_scroller.GUI_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return 0;
        return __scrollSpeed;
    }
    
    return 0;
}