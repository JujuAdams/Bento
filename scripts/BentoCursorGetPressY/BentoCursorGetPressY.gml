// Feather disable all

/// Returns the y-coordinate of where the cursor was when the primary input was last pressed. This
/// function will work in all input modes but, for example, in the mouse input mode this function
/// would return where the cursor was when the mouse was last clicked.
/// 
/// @param [layerOrName=current]

function BentoCursorGetPressY(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        return __inputModePointer? __pointerPressY : __navigationLastY;
    }
    
    return 0;
}