// Feather disable all

/// @param [instance=id]

function GuiScrollGetParamX(_instance = id)
{
    with(_instance)
    {
        return 1 - clamp((__scrollX - __scrollMinX) / (__scrollMaxX - __scrollMinX), 0, 1);
    }
    
    return 0;
}