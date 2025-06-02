// Feather disable all

/// Returns whether an instance is hoverable (i.e. its "over" state can be set).
/// 
/// @param [element=self]
/// @param [checkVisible=true]

function GuiGetHoverable(_element = self, _checkVisible = true)
{
    if (not GuiExists(_element)) return false;
    
    with(_element.GUI_VARS)
    {
        var _layer = __layer;
        if (_layer.__navMode == GUI_MODE_UNKNOWN) return false;
        if (__hoverableIndex != _layer.__hoverableRegenCount) return false;
        return ((not _checkVisible) || __scissorWorldVisible);
    }
    
    return false;
}