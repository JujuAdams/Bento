// Feather disable all

// TODO - Mouse-over detection and tracking needs improvement. This function may get expensive.

/// Returns whether the top-most layer for the given environment wants to block mouse input to
/// other parts of your game. This can happen in the following situations:
/// 
/// - Any `BENTO_BUTTON_POINTER` or `BENTO_BUTTON_ALWAYS` element is being hovered.
/// - Any element has been pressed and the primary button is being held.
/// - Any element has been focused in a way that restricts the pointer.
/// - The environment is receiving text input using `BentoTextOpen()`.
///
/// Additionally, if the topmost layer is **not** using a pointer input mode, this function will
/// always return `false`.
/// 
/// @param [environmentName=current]

function BentoGetBlocksMouse(_environmentName = undefined)
{
    static _system = __BentoSystem();
    
    if (_system.__textHandlerEnvironment != undefined) return true;
    
    with(__BentoEnvironmentEnsure(_environmentName))
    {
        with(__layerCurrent)
        {
            if (not __inputModePointer) return false;
            
            var _focusType = (__focusTop != undefined)? __focusTop.BENTO_VARS.__focusType : BENTO_FOCUS_POINTER_IGNORE;
            if ((_focusType != BENTO_FOCUS_POINTER_IGNORE) && (_focusType != BENTO_FOCUS_POINTER_CANCEL_ALWAYS))
            {
                return true;
            }
            
            if (BentoExists(__holdElement))
            {
                return true;
            }
            
            __BentoEnsureHoverableOrder();
            
            if (BentoExists(__hoverElement) && (__hoverElement.BENTO_VARS.__hoverableIndex == __hoverableRegenCount))
            {
                return true;
            }
        }
    }
    
    return false;
}