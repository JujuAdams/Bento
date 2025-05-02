// Feather disable all

/// @param [x]
/// @param [y]
/// @param [instance=id]

function GuiLayoutSetOffset(_x, _y, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
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