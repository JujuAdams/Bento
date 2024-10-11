// Feather disable all

/// @param instance

function GuiScrollGetY(_instance)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.__scrollY;
}