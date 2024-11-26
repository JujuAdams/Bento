// Feather disable all

/// Sets whether raycasting should be disabled in particular axes. This is helpful when creating
/// scrolling UI elements that treat e.g. left and right input as a way to adjust a setting. You
/// *don't* need to call this function if you have set up a navigation link with `GuiNavLinkHori()`
/// or `GuiNavLinkVert()`.
/// 
/// @param disableHori
/// @param disableVert
/// @param [instance=id]

function GuiNavRaycastSetDisable(_disableHori, _disableVert, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    _instance.__raycastDisableHori = _disableHori;
    _instance.__raycastDisableVert = _disableVert;
}