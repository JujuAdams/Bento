// Feather disable all

/// Manually moves the scroll offset.
/// 
/// @param [dX=0]
/// @param [dY=0]
/// @param [scrollSpeed=default]
/// @param [element=self]

function BentoScrollMove(_dX = 0, _dY = 0, _scrollSpeed = BENTO_DEFAULT_SCROLL_SPEED, _element = self)
{
    var _scroller = __BentoScrollFindParent(_element);
    if (not BentoExists(_scroller)) return;
    
    BentoScrollSetPos(_scroller.BENTO_VARS.__scrollX + _dX, _scroller.BENTO_VARS.__scrollY + _dY, _scrollSpeed, _scroller);
}