// Feather disable all

/// @param [x]
/// @param [y]
/// @param [instance=self]

function GuiLayoutSetOffset(_x, _y, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (_x != undefined)
        {
            if (__layoutOffsetX != _x)
            {
                __layoutOffsetX = _x;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutOffsetY != _y)
            {
                __layoutOffsetY = _y;
                __environment.__layoutDirty = true;
            }
        }
    }
}