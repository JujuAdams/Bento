// Feather disable all

/// @param [layerOrName=current]

function BentoCursorGetPressY(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        return __navPointer? __mousePressY : __directionalLastY;
    }
    
    return 0;
}