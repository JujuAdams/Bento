// Feather disable all

/// Hover an element (if possible). This function only works when the input mode is set to
/// `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD` on the layer in question.
/// 
/// The optional `byNavigation` parameter determines whether `BentoCursorGetEnterByNavigation()`
/// will return `true`.
/// 
/// @param element
/// @param [byNavigation=false]
/// @param [layerOrName=current]

function BentoHover(_element, _byNavigation = false, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__navDirectional)
        {
            if (__BentoGetHoverableInternal(_element, false))
            {
                __BentoSetHover(_element, _byNavigation);
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
            __BentoTrace("Cannot hover element, not in a directional input mode");
        }
    }
}

//Internal variant without the debug messages
function __BentoHoverInternal(_element)
{
    with(__BentoLayerEnsure(undefined))
    {
        if (__navDirectional)
        {
            if (__BentoGetHoverableInternal(_element, false))
            {
                __BentoSetHover(_element, false);
                __hoverElementSoft = BENTO_NO_ELEMENT;
            }
        }
    }
}