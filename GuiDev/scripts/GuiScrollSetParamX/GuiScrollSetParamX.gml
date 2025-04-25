// Feather disable all

/// @param param
/// @param [instance=id]

function GuiScrollSetParamX(_param, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.__gui)
    {
        GuiScrollSet(lerp(__scrollMinX, __scrollMaxX, 1 - clamp(_param, 0, 1)), __scrollY);
    }
}