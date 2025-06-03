// Feather disable all

/// @param [x]
/// @param [y]
/// @param [element=self]

function GuiLayoutSetOffset(_x, _y, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_x != undefined)
        {
            if (__layoutOffsetX != _x)
            {
                __layoutOffsetX = _x;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutOffsetY != _y)
            {
                __layoutOffsetY = _y;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
    }
}