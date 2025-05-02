// Feather disable all

/// Sets whether raycasting should be disabled in particular axes. This is helpful when creating
/// scrolling UI elements that treat e.g. left and right input as a way to adjust a setting. You
/// *don't* need to call this function if you have set up a navigation link with `GuiNavLinkHori()`
/// or `GuiNavLinkVert()`.
/// 
/// @param disableHori
/// @param disableVert
/// @param [instance=self]

function GuiNavRaycastSetDisable(_disableHori, _disableVert, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    _instance.GUI_VARS.__raycastDisableHori = _disableHori;
    _instance.GUI_VARS.__raycastDisableVert = _disableVert;
}