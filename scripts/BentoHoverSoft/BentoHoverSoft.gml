// Feather disable all

/// Preferentially hovers an element if no other element is currently hovered. A soft hover will
/// only last for a frame and can be overwritten by `BentoHover()`. This function further only
/// works when the input mode is set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD`.
/// 
/// Hovering an element in this way will not count as entering by navigation. This means that
/// `BentoCursorGetEnterByPlayer()` will return `false`.
/// 
/// @param element
/// @param [layerOrName=current]

function BentoHoverSoft(_element, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__inputModeNavigation)
        {
            __hoverElementSoft = _element;
        }
    }
}