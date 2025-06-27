// Feather disable all

/// Returns the distance that the pointer has moved between after pressing the primary action. If
/// the navigation mode isn't `BENTO_MODE_MOUSE` or `BENTO_MODE_TOUCH` this function returns `0`.
/// 
/// @param [layerOrName=current]

function BentoPrimaryGetDragDistance(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        return __navPointer? point_distance(__mousePressX, __mousePressY, __mouseX, __mouseY) : 0;
    }
    
    return 0;
}