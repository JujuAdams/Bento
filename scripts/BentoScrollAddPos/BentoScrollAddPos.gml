// Feather disable all

/// Manually moves the scroll offset.
/// 
/// @param dX
/// @param dY
/// @param [scrollSpeed=default]
/// @param [element=self]

function BentoScrollAddPos(_dX, _dY, _scrollSpeed = BENTO_DEFAULT_SCROLL_SPEED, _element = self)
{
    var _scroller = __BentoFindScrollElement(_element);
    if (not BentoExists(_scroller)) return true;
    
    return BentoScrollSetPos(_scroller.BENTO_VARS.__scrollX + _dX, _scroller.BENTO_VARS.__scrollY + _dY, _scrollSpeed, _scroller);
}