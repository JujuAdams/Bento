// Feather disable all

/// @param param
/// @param [scrollSpeed=default]
/// @param [element=self]

function BentoScrollSetParamX(_param, _scrollSpeed = BENTO_DEFAULT_SCROLL_SPEED, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        BentoScrollSet(lerp(__scrollMinX, __scrollMaxX, 1 - clamp(_param, 0, 1)), __scrollY, _scrollSpeed, _element);
    }
}