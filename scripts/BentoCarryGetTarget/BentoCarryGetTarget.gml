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
/// @param [element=self]

function BentoCarryGetTarget(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __carryTargetElement;
    }
    
    return BENTO_NO_ELEMENT;
}