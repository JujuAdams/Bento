// Feather disable all

/// Sets the input mode for a layer. This should be one of the following constants:
/// 
/// - `BENTO_MODE_UNKNOWN`
/// - `BENTO_MODE_MOUSE`
/// - `BENTO_MODE_KEYBOARD`
/// - `BENTO_MODE_GAMEPAD`
/// - `BENTO_MODE_TOUCH`
/// 
/// The mouse and touch input modes are considered "pointer" input modes. The keyboard and gamepad
/// input modes are considered "directional" input modes.
/// 
/// @param mode
/// @param [layerOrName=current]

// TODO - Move input mode to environment?

function BentoSetMode(_newMode, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__navMode == _newMode) return;
        
        //Changing input mode may change whether elements execute their step event and are hoverable
        //when focused
        __dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
        
        if ((_newMode == BENTO_MODE_KEYBOARD) || (_newMode == BENTO_MODE_GAMEPAD))
        {
            if (__navPointer)
            {
                //Reset mouse variables
                __mouseHold = false;
                
                __directionalLastX = __mouseX;
                __directionalLastY = __mouseY;
                
                __mousePrevX = __mouseX;
                __mousePrevY = __mouseY;
            }
            
            __navPointer     = false;
            __navDirectional = true;
            
            __mousePressX = undefined;
            __mousePressY = undefined;
        }
        else if ((_newMode == BENTO_MODE_MOUSE) || (_newMode == BENTO_MODE_TOUCH))
        {
            //Find any focused element that needs to be closed if we've swapped to a pointer mode
            var _focusStack = __focusStack;
            var _i = 0;
            repeat(array_length(_focusStack))
            {
                var _element = _focusStack[_i];
                if (_element.BENTO_VARS.__focusType == BENTO_FOCUS_POINTER_CANCEL_ALWAYS)
                {
                    BentoFocusClose(_element);
                    break;
                }
                
                ++_i;
            }
            
            __navPointer     = true;
            __navDirectional = false;
        }
        else
        {
            //Some undefined input mode, perhaps `BENTO_MODE_UNKNOWN`
            __navPointer     = false;
            __navDirectional = false;
            
            __mousePressX = undefined;
            __mousePressY = undefined;
        }
        
        __navMode = _newMode;
    }
}