// Feather disable all

/// Selects an element (if possible). This function only works when the input mode is set to
/// `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD` on the layer in question.
/// 
/// @param element
/// @param [layerOrName=current]

function BentoSelect(_element, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        __hoverElement     = _element;
        __hoverElementSoft = BENTO_NO_ELEMENT;
    }
}