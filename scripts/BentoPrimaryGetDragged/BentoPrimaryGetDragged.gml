// Feather disable all

/// Returns if the pointer has moved far enough whilst being held to be considered a drag. The
/// drag distance threshold is defined by `BENTO_POINTER_DRAG_THRESHOLD`. If the input mode isn't
/// `BENTO_MODE_MOUSE` or `BENTO_MODE_TOUCH` this function always returns `false`.
/// 
/// @param [layerOrName=current]

function BentoPrimaryGetDragged(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        return __pointerTravelled;
    }
    
    return false;
}