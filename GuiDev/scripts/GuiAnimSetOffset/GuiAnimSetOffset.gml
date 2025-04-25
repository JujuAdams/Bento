// Feather disable all

/// @param [x]
/// @param [y]
/// @param [instance=id]

function GuiAnimSetOffset(_x, _y, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (_x != undefined)
        {
            if (__animOffsetX != _x)
            {
                __animOffsetX = _x;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
        
        if (_y != undefined)
        {
            if (__animOffsetY != _y)
            {
                __animOffsetY = _y;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
    }
}