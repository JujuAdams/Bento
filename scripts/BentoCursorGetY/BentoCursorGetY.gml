// Feather disable all

/// Returns the y-coordinate of the cursor's position.
/// 
/// @param [layerOrName=current]

function BentoCursorGetY(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__inputMode == BENTO_MODE_MOUSE)
        {
            return __pointerY;
        }
        else if (__inputModeNavigation)
        {
            return 0.5*(__cursorLastT + __cursorLastB);
        }
        else if (__inputMode == BENTO_MODE_TOUCH)
        {
            return (__pointerPrimaryState & __BENTO_STATE_START)? __pointerY : __pointerPrevY;
        }
    }
    
    return 0;
}