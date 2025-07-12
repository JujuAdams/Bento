// Feather disable all

/// Sets whether raycasting should be enabled in each axis (by default, it is indeed enabled in
/// both axes). This is helpful when creating scrolling elements that treat e.g. left and right
/// input as a way to adjust a setting.
/// 
/// N.B. Links created by `BentoLinkHori()` and `BentoLinkVert()` will override raycasting.
/// 
/// @param enableX
/// @param enableY
/// @param [element=self]

function BentoSetRaycastEnable(_enableX, _enableY, _element = self)
{
    if (not BentoExists(_element)) return;
    
    _element.BENTO_VARS.__raycastEnableX = _enableX;
    _element.BENTO_VARS.__raycastEnableY = _enableY;
}