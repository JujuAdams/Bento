// Feather disable all

/// Selects an element (if possible). This function only works when the input mode is set to
/// `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD` on the layer in question.
/// 
/// The optional `byNavigation` parameter determines whether `BentoCursorGetEnterByNavigation()`
/// will return `true`.
/// 
/// @param element
/// @param [byNavigation=false]
/// @param [layerOrName=current]

function BentoSelect(_element, _byNavigation = false, _layerOrName = undefined)
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
            else if (BENTO_SAFE)
            {
                __BentoTrace("Cannot select element, it is not hoverable");
            }
        }
        else if (BENTO_SAFE)
        {
            __BentoTrace("Cannot select element, currently in a directional input mode");
        }
    }
}