// Feather disable all

/// @param param
/// @param [instance=id]

function GuiScrollSetParamY(_param, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.__gui)
    {
        GuiScrollSet(__scrollY, lerp(__scrollMinY, __scrollMaxY, 1 - clamp(_param, 0, 1)));
    }
}