// Feather disable all

/// @param [layerOrName=current]

function BentoFocusGetTop(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        return __focusTop;
    }
    
    return BENTO_NO_ELEMENT;
}