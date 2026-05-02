// Feather disable all

/// @param wrapX
/// @param wrapY
/// @param [element=self]

function BentoSetRaycastWrap(_wrapX, _wrapY, _element = self)
{
    if (not BentoExists(_element)) return;
    
    _element.BENTO_VARS.__raycastWrapX = _wrapX;
    _element.BENTO_VARS.__raycastWrapY = _wrapY;
}