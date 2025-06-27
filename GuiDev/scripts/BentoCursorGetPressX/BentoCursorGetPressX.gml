// Feather disable all

/// @param [layerOrName=current]

function BentoCursorGetPressX(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        return __navPointer? __mousePressX : __directionalLastX;
    }
    
    return 0;
}