// Feather disable all

/// Sets whether raycasting should be disabled in particular axes. This is helpful when creating
/// scrolling UI elements that treat e.g. left and right input as a way to adjust a setting. You
/// *don't* need to call this function if you have set up a navigation link with `BentoLinkHori()`
/// or `BentoLinkVert()`.
/// 
/// @param enableHori
/// @param enableVert
/// @param [element=self]

function BentoSetRaycastEnable(_enableHori, _enableVert, _element = self)
{
    if (not BentoExists(_element)) return;
    
    _element.GUI_VARS.__raycastEnableHori = _enableHori;
    _element.GUI_VARS.__raycastEnableVert = _enableVert;
}