// Feather disable all

/// Sets whether navigation should be enabled in each axis (by default, it is indeed enabled in
/// both axes). This is helpful when creating scrolling elements that treat e.g. left and right
/// input as a way to adjust a setting.
/// 
/// N.B. Links created by `BentoNavigationLinkX()` and `BentoNavigationLinkY()` will override this
///      setting.
/// 
/// @param enableX
/// @param enableY
/// @param [element=self]

function BentoSetNavigationEnable(_enableX, _enableY, _element = self)
{
    if (not BentoExists(_element)) return;
    
    _element.BENTO_VARS.__navigationEnableX = _enableX;
    _element.BENTO_VARS.__navigationEnableY = _enableY;
}