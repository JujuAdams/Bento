// Feather disable all

/// Hover an element (if possible). This function only works when the input mode is set to
/// `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD` on the layer in question. The optional `byPlayer`
/// parameter determines whether `BentoCursorGetEnterByPlayer()` will return `true`.
/// 
/// If the element has been successfully hovered then this function will return `1`. If the element
/// exists but cannot be hovered for some technical reason, such as hovering an element on a newly
/// created layer, then this function will fall back on a "soft hover" (see `BentoHoverSoft()`) and
/// the function will return `0`. If an element cannot be hovered at all, such as not being in a
/// legal input mode, then the function will return `-1`,
/// 
/// @param [element=self]
/// @param [byPlayer=false]

function BentoHover(_element = self, _byPlayer = false)
{
    if (not BentoExists(_element)) return -1;
    
    with(_element.BENTO_VARS.__layer)
    {
        if (__inputModeNavigation)
        {
            if (__BentoGetHoverableInternal(_element, false))
            {
                __BentoSetHover(_element, _byPlayer);
                __hoverElementSoft = BENTO_NO_ELEMENT;
                return 1;
            }
            else
            {
                __BentoTrace("Element is not currently hoverable, using a soft hover instead");
                __hoverElementSoft = _element;
                return 0;
            }
        }
        else if (BENTO_SAFE)
        {
            __BentoTrace("Cannot hover element, not in a navigation input mode");
        }
    }
    
    return -1;
}