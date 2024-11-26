// Feather disable all

/// @param [instance=id]

function GuiScrollGetParamY(_instance = id)
{
    with(_instance)
    {
        return 1 - clamp((__scrollY - __scrollMinY) / (__scrollMaxY - __scrollMinY), 0, 1);
    }
    
    return 0;
}