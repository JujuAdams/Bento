// Feather disable all

/// @param horizontal
/// @param vertical
/// @param [instance=id]

function GuiScrollSetEnabled(_horizontal, _vertical, _instance = id)
{
    with(_instance)
    {
        if ((__scrollHori != _horizontal) || (__scrollVert != _vertical))
        {
            __scrollHori = _horizontal;
            __scrollVert = _vertical;
            
            //Ensure we have additional scroll variables set and ready for use
            if (_horizontal || _vertical)
            {
                GuiSetIfNotDefined("__scrollPadLeft",   0);
                GuiSetIfNotDefined("__scrollPadTop",    0);
                GuiSetIfNotDefined("__scrollPadRight",  0);
                GuiSetIfNotDefined("__scrollPadBottom", 0);
            }
            
            GuiScrollLimitsMarkDirty(id);
        }
    }
}