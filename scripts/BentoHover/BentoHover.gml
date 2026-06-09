// Feather disable all

/// Hover an element (if possible). This function only works when the input mode is set to
/// `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD` on the layer in question.
/// 
/// The optional `byPlayer` parameter determines whether `BentoCursorGetEnterByPlayer()` will
/// return `true`.
/// 
/// @param [element=self]
/// @param [byPlayer=false]
/// @param [layerOrName=current]

function BentoHover(_element = self, _byPlayer = false, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__inputModeNavigation)
        {
            if (__BentoGetHoverableInternal(_element, false))
            {
                __BentoSetHover(_element, _byPlayer);
                __hoverElementSoft = BENTO_NO_ELEMENT;
            }
            else
            {
                __BentoTrace("Element is not currently hoverable, using a soft hover instead");
                __hoverElementSoft = _element;
            }
        }
        else if (BENTO_SAFE)
        {
            __BentoTrace("Cannot hover element, not in a navigation input mode");
        }
    }
}