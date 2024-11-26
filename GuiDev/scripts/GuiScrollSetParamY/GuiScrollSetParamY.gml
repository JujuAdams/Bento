// Feather disable all

/// @param param
/// @param [instance=id]

function GuiScrollSetParamY(_param, _instance = id)
{
    with(_instance)
    {
        GuiScrollSet(__scrollX, lerp(__scrollMinY, __scrollMaxY, 1 - clamp(_param, 0, 1)));
    }
    
    return 0;
}