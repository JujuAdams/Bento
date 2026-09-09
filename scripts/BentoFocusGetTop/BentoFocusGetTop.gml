// Feather disable all

/// Returns the top-most focused element for the layer.
/// 
/// @param [layerOrName=current]

function BentoFocusGetTop(_layerOrName = undefined)
{
    with(__BentoLayerSeek(_layerOrName))
    {
        return __focusTop;
    }
    
    return BENTO_NO_ELEMENT;
}