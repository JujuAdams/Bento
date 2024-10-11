// Feather disable all

/// @param instance
/// @param state

function GuiNavRaycastSetDisable(_instance, _state)
{
    if (not instance_exists(_instance)) return;
    
    _instance.__raycastDisabled = _state;
}