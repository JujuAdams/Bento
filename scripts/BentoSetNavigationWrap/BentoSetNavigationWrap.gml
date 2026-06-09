// Feather disable all

/// Sets whether navigation wrapping should be enabled in each axis. This can be used to create
/// lists of buttons that can be scrolled in bother directions.
/// 
/// N.B. Links created by `BentoNavigationLinkX()` and `BentoNavigationLinkY()` will override this
///      setting.
/// 
/// @param wrapX
/// @param wrapY
/// @param [element=self]

function BentoSetNavigationWrap(_wrapX, _wrapY, _element = self)
{
    if (not BentoExists(_element)) return;
    
    _element.BENTO_VARS.__navigationWrapX = _wrapX;
    _element.BENTO_VARS.__navigationWrapY = _wrapY;
}