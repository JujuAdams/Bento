// Feather disable all

/// Returns the y-coordinate of the cursor's position.
/// 
/// @param [layerOrName=current]

function BentoCursorGetY(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__navMode == BENTO_MODE_MOUSE)
        {
            return __mouseY;
        }
        else if (__navDirectional)
        {
            return 0.5*(__cursorLastT + __cursorLastB);
        }
        else if (__navMode == BENTO_MODE_TOUCH)
        {
            return (__mousePrimaryState & __BENTO_STATE_START)? __mouseY : __mousePrevY;
        }
    }
    
    return 0;
}