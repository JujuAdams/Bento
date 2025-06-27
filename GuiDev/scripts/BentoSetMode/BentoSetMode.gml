// Feather disable all

/// Sets the current navigation mode. This should be one of the following constants:
/// 
/// - `GUI_MODE_UNKNOWN`
/// - `GUI_MODE_MOUSE`
/// - `GUI_MODE_KEYBOARD`
/// - `GUI_MODE_GAMEPAD`
/// - `GUI_MODE_TOUCH`
/// 
/// @param mode
/// @param [layer=current]

function BentoSetMode(_newMode, _layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__navMode == _newMode) return;
        
        //Changing navigation mode may change whether elements execute their step event and are hoverable
        //when focused
        __dirtyFlags |= __GUI_DIRTY_STEP | __GUI_DIRTY_HOVERABLE;
        
        if ((_newMode == GUI_MODE_KEYBOARD) || (_newMode == GUI_MODE_GAMEPAD))
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
        else if ((_newMode == GUI_MODE_MOUSE) || (_newMode == GUI_MODE_TOUCH))
        {
            //Find any focused element that needs to be closed if we've swapped to a pointer mode
            var _focusStack = __focusStack;
            var _i = 0;
            repeat(array_length(_focusStack))
            {
                var _element = _focusStack[_i];
                if (_element.GUI_VARS.__focusType == GUI_FOCUS_POINTER_CANCEL_ALWAYS)
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
            //Some undefined navigation mode, perhaps `GUI_MODE_UNKNOWN`
            __navPointer     = false;
            __navDirectional = false;
            
            __mousePressX = undefined;
            __mousePressY = undefined;
        }
        
        __navMode = _newMode;
    }
}