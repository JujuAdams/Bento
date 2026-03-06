// Feather disable all

/// Preferentially selects an element if no other element is currently selected. A soft select will
/// only last for a frame and can be overwritten by `BentoSelect()`. This function further only
/// works when the input mode is set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD`.
/// 
/// Selecting an element in this way will not count as entering by navigation. This means that
/// `BentoCursorGetEnterByNavigation()` will return `false`.
/// 
/// @param element
/// @param [layerOrName=current]

function BentoSelectSoft(_element, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__navDirectional)
        {
            __hoverElementSoft = _element;
        }
    }
}