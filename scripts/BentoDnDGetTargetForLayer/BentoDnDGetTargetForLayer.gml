// Feather disable all

/// Returns the element that is being hovered whilst the drag & drop system is in use. This
/// function will only return an element that is permitted to receive the dragged item element.
/// 
/// If no item is being dragged then this function returns `BENTO_NO_ELEMENT` and if no valid
/// element is being hovered then this function will also return `BENTO_NO_ELEMENT`.
/// 
/// This function can return the dragged item element itself if the player has dragged the item
/// back onto itself.
/// 
/// @param [layerOrName=current]
/// @param [environmentName=current]

function BentoDnDGetTargetForLayer(_layerOrName = undefined, _environmentOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName, _environmentOrName))
    {
        with(__BentoGetVars(__dndItemElement))
        {
            return __dndTargetElement;
        }
    }
    
    return BENTO_NO_ELEMENT;
}