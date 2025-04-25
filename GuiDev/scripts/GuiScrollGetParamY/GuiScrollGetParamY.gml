// Feather disable all

/// @param [instance=id]

function GuiScrollGetParamY(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    with(_instance.GUI_STRUCT)
    {
        return 1 - clamp((__scrollY - __scrollMinY) / max(0.0001, __scrollMaxY - __scrollMinY), 0, 1);
    }
    
    return 0;
}