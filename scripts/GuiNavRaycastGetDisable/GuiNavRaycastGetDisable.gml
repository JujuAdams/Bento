// Feather disable all

/// @param instance

function GuiNavRaycastGetDisable(_instance)
{
    if (not instance_exists(_instance)) return false;
    
    return _instance.__raycastDisabled;
}