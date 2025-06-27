// Feather disable all

/// Selects an instance (if possible). This function only works when the navigation mode is set to
/// `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD`.
/// 
/// @param instance
/// @param [layerOrName=current]

function BentoSelect(_element, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        __hoverElement     = _element;
        __hoverElementSoft = BENTO_NO_ELEMENT;
    }
}