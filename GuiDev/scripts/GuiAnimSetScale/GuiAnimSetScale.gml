// Feather disable all

/// @param [xScale]
/// @param [yScale]
/// @param [instance=id]

function GuiAnimSetScale(_xScale, _yScale, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (_xScale != undefined)
        {
            if (__animScaleX != _xScale)
            {
                __animScaleX = _xScale;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
        
        if (_yScale != undefined)
        {
            if (__animScaleY != _yScale)
            {
                __animScaleY = _yScale;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
    }
}