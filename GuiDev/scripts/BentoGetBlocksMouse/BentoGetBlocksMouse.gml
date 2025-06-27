// Feather disable all

// TODO - Mouse-over detection and tracking needs improvement. This function may get expensive.
// TODO - Should check every environment for a text handler

/// Returns whether the top-most layer for the given environment wants to block mouse input to
/// other parts of your game. This can happen in the following situations:
/// 
/// - Any `GUI_BUTTON_POINTER` or `GUI_BUTTON_ALWAYS` UI element is being hovered.
/// - Any UI element has been pressed and the primary button is being held.
/// - Any UI element has been focused in a way that restricts the pointer.
/// - The environment is receiving text input using `BentoTextOpen()`.
///
/// Additionally, if the topmost layer is NOT using a pointer input mode, this function will always
/// return `false`.
/// 
/// @param [environment=current]

function BentoGetBlocksMouse(_environment = undefined)
{
    static _system = __BentoSystem();
    
    if (_system.__textHandlerEnvironment != undefined) return true;
    
    with(_environment ?? _system.__environmentCurrent)
    {
        with(__layerCurrent)
        {
            if (not __navPointer) return false;
            
            var _focusType = (__focusTop != undefined)? __focusTop.GUI_VARS.__focusType : GUI_FOCUS_POINTER_IGNORE;
            if ((_focusType != GUI_FOCUS_POINTER_IGNORE) && (_focusType != GUI_FOCUS_POINTER_CANCEL_ALWAYS))
            {
                return true;
            }
            
            if (BentoExists(__holdElement))
            {
                return true;
            }
            
            if (BentoExists(__hoverElement) && (__hoverElement.GUI_VARS.__buttonType & GUI_BUTTON_POINTER))
            {
                return true;
            }
        }
    }
    
    return false;
}