// Feather disable all

/// @param [x]
/// @param [y]
/// @param [force]
/// @param [instance=id]

function GuiAnimSetScale(_x, _y, _force, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_x != undefined)
        {
            if (__animXScale != _x)
            {
                __animXScale = _x;
                __GuiMarkAnimAndScrollDirty(id);
            }
        }
        
        if (_y != undefined)
        {
            if (__animYScale != _y)
            {
                __animYScale = _y;
                __GuiMarkAnimAndScrollDirty(id);
            }
        }
        
        if (_force != undefined)
        {
            if (__animScaleForce != _force)
            {
                __animScaleForce = _force;
                __GuiMarkAnimAndScrollDirty(id);
            }
        }
    }
}