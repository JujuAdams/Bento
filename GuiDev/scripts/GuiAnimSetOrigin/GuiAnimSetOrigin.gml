// Feather disable all

/// @param x
/// @param y
/// @param [instance=id]

function GuiAnimSetOrigin(_x, _y, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (_x != undefined)
        {
            if (__animOriginX != _x)
            {
                __animOriginX = _x;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
        
        if (_y != undefined)
        {
            if (__animOriginY != _y)
            {
                __animOriginY = _y;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
    }
}