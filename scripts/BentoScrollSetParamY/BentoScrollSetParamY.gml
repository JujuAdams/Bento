// Feather disable all

/// Sets the scroll *parameter* for the y-axis. This is a value from `0` to `1` (inclusive) where a
/// value of `0` indicates no scrolling and `1` indicates scrolling to the bottom of the content
/// children inside the element.
/// 
/// @param param
/// @param [scrollSpeed=default]
/// @param [element=self]

function BentoScrollSetParamY(_param, _scrollSpeed = BENTO_DEFAULT_SCROLL_SPEED, _element = self)
{
    with(__BentoGetVars(_element))
    {
        BentoScrollSetPos(undefined, lerp(__scrollMinY, __scrollMaxY, 1 - clamp(_param, 0, 1)), _scrollSpeed, _element);
    }
}