// Feather disable all

/// Scrolls to highlight an element inside a parent.
/// 
/// @param [scrollSpeed]
/// @param [element=self]

function BentoScrollTo(_scrollSpeed = BENTO_DEFAULT_SCROLL_SPEED, _element = self)
{
    if (not BentoExists(_element)) return;
    
    var _result = __BentoGetScrollDelta(_element);
    if (not BentoExists(_result.__parent)) return;
    
    BentoScrollMove(_result.__dX, _result.__dY, _scrollSpeed, _result.__parent);
}