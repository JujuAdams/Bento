// Feather disable all

/// @param [x]
/// @param [y]
/// @param [instance=id]

function GuiAnimSetOffset(_x, _y, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_x != undefined)
        {
            if (__animXOffset != _x)
            {
                __animXOffset = _x;
                _system.__animationDirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__animYOffset != _y)
            {
                __animYOffset = _y;
                _system.__animationDirty = true;
            }
        }
    }
}