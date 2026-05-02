// Feather disable all

/// Returns the x-coordinate of the cursor's position.
/// 
/// @param [layerOrName=current]

function BentoCursorGetX(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__navMode == BENTO_MODE_MOUSE)
        {
            return __pointerX;
        }
        else if (__navDirectional)
        {
            return 0.5*(__cursorLastL + __cursorLastR);
        }
        else if (__navMode == BENTO_MODE_TOUCH)
        {
            return (__pointerPrimaryState & __BENTO_STATE_START)? __pointerX : __pointerPrevX;
        }
    }
    
    return 0;
}