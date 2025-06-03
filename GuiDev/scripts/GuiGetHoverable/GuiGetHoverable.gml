// Feather disable all

/// Returns whether an instance is hoverable (i.e. its "over" state can be set).
/// 
/// @param [element=self]
/// @param [checkVisible=true]

function GuiGetHoverable(_element = self, _checkVisible = true)
{
    return __GuiGetHoverableInternal(_element, _checkVisible);
}

function __GuiGetHoverableInternal(_element, _checkVisible)
{
    if (not GuiExists(_element)) return false;
    
    with(_element.GUI_VARS)
    {
        //Can't hover invisible elements
        if (not __visible) return false;
        
        //Can't hover elements that aren't in the most recent hoverable order array
        if (__hoverableIndex != __layer.__hoverableRegenCount) return false;
        
        //Can't hover anything that's outside a clipping region
        return ((not _checkVisible) || (__scissorVisibility != GUI_VISIBLE_NONE));
    }
    
    return false;
}