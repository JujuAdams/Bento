// Feather disable all

/// @param [x]
/// @param [y]
/// @param [instance=id]

function GuiSetLayoutOffset(_x, _y, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_x != undefined)
        {
            if (__layoutXOffset != _x)
            {
                __layoutXOffset = _x;
                _system.__layoutDirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutYOffset != _y)
            {
                __layoutYOffset = _y;
                _system.__layoutDirty = true;
            }
        }
    }
}