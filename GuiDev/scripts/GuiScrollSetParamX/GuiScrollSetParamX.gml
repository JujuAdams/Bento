// Feather disable all

/// @param param
/// @param [instance=id]

function GuiScrollSetParamX(_param, _instance = id)
{
    with(_instance)
    {
        GuiScrollSet(lerp(__scrollMinX, __scrollMaxX, 1 - clamp(_param, 0, 1)), __scrollY);
    }
    
    return 0;
}