// Feather disable all

/// @param x
/// @param y
/// @param [instance=id]

function GuiAnimSetOrigin(_x, _y, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_x != undefined)
        {
            if (__animOriginX != _x)
            {
                __animOriginX = _x;
                __GuiMarkAnimAndScrollDirty(id);
            }
        }
        
        if (_y != undefined)
        {
            if (__animOriginY != _y)
            {
                __animOriginY = _y;
                __GuiMarkAnimAndScrollDirty(id);
            }
        }
    }
}