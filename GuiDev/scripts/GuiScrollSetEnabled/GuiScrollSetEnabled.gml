// Feather disable all

/// @param horizontal
/// @param vertical
/// @param [element=self]

function GuiScrollSetEnabled(_horizontal, _vertical, _element = self)
{
    if (not GUI_EXISTS(_element)) return;
    
    with(_element.GUI_VARS)
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
                GuiSetIfNotDefined("__scrollTargetX",   __scrollX);
                GuiSetIfNotDefined("__scrollTargetY",   __scrollY);
                GuiSetIfNotDefined("__scrollSpeed",     infinity);
            }
            
            GuiScrollLimitsMarkDirty(_element);
        }
    }
}