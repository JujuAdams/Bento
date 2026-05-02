// Feather disable all

/// Sets the scroll *parameter* for the x-axis. This is a value from `0` to `1` (inclusive) where a
/// value of `0` indicates no scrolling and `1` indicates scrolling to the right of the content
/// children inside the element.
/// 
/// @param param
/// @param [scrollSpeed=default]
/// @param [element=self]

function BentoScrollSetParamX(_param, _scrollSpeed = BENTO_DEFAULT_SCROLL_SPEED, _element = self)
{
    with(__BentoGetVars(_element))
    {
        BentoScrollSetPos(lerp(__scrollMinX, __scrollMaxX, 1 - clamp(_param, 0, 1)), undefined, _scrollSpeed, _element);
    }
}