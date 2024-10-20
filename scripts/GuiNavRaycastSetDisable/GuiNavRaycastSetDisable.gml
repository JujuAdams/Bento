// Feather disable all

/// @param instance
/// @param disableHori
/// @param disableVert

function GuiNavRaycastSetDisable(_instance, _allowHori, _allowVert)
{
    if (not instance_exists(_instance)) return;
    
    _instance.__raycastDisableHori = _allowHori;
    _instance.__raycastDisableVert = _allowVert;
}