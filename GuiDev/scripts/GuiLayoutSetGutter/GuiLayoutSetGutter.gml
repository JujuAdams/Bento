// Feather disable all

/// @param [x]
/// @param [y]
/// @param [element=self]

function GuiLayoutSetGutter(_x, _y, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if ((__layoutType != GUI_LAYOUT_LIST) && (__layoutType != GUI_LAYOUT_GRID))
        {
            __GuiError("Can only apply gutter to elements using a list or grid layout");
        }
        
        if (_x != undefined)
        {
            if (__layoutGutterX != _x)
            {
                __layoutGutterX = _x;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutGutterY != _y)
            {
                __layoutGutterY = _y;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
    }
}