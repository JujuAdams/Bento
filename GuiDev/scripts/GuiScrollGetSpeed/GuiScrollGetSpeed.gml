// Feather disable all

/// @param [instance=id]

function GuiScrollGetSpeed(_instance = id)
{
    var _scroller = __GuiScrollFindParent(_instance);
    if (not instance_exists(_scroller)) return 0;
    
    with(_scroller.GUI_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return 0;
        return __scrollSpeed;
    }
    
    return 0;
}