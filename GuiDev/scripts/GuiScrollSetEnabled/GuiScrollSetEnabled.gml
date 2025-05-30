// Feather disable all

/// @param horizontal
/// @param vertical
/// @param [element=self]

function GuiScrollSetEnabled(_horizontal, _vertical, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if ((__scrollHori != _horizontal) || (__scrollVert != _vertical))
        {
            __scrollHori = _horizontal;
            __scrollVert = _vertical;
            
            GuiScrollLimitsMarkDirty(_element);
        }
    }
}