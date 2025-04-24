// Feather disable all

/// @param [x]
/// @param [y]
/// @param [instance=id]

function GuiLayoutSetOffset(_x, _y, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_x != undefined)
        {
            if (__layoutOffsetX != _x)
            {
                __layoutOffsetX = _x;
                _system.__layoutDirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutOffsetY != _y)
            {
                __layoutOffsetY = _y;
                _system.__layoutDirty = true;
            }
        }
    }
}