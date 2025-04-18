// Feather disable all

/// @param [instance=id]

function GuiScrollGetParamY(_instance = id)
{
    with(_instance)
    {
        return 1 - clamp((__scrollY - __scrollMinY) / max(0.0001, __scrollMaxY - __scrollMinY), 0, 1);
    }
    
    return 0;
}