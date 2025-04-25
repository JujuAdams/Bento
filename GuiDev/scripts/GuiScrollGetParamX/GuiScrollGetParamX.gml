// Feather disable all

/// @param [instance=id]

function GuiScrollGetParamX(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    with(_instance.__gui)
    {
        return 1 - clamp((__scrollX - __scrollMinX) / max(0.0001, __scrollMaxX - __scrollMinX), 0, 1);
    }
    
    return 0;
}