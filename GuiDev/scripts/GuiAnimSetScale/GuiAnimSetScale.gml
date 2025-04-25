// Feather disable all

/// @param [xScale]
/// @param [yScale]
/// @param [force]
/// @param [instance=id]

function GuiAnimSetScale(_xScale, _yScale, _force, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.__gui)
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
        
        if (_force != undefined)
        {
            if (__animScaleForce != _force)
            {
                __animScaleForce = _force;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
    }
}