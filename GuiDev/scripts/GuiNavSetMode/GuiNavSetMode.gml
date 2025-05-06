// Feather disable all

/// Sets the current navigation mode. This should be one of the following constants:
/// 
/// - `GUI_NAV_UNKNOWN`
/// - `GUI_NAV_MOUSE`
/// - `GUI_NAV_DIRECTIONAL`
/// - `GUI_NAV_TOUCH`
/// 
/// @param mode
/// @param [layer=current]

function GuiNavSetMode(_newMode, _layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__navMode == _newMode) return;
        
        //Changing navigation mode may change whether elements are hoverable when focused
        __stepDirty = true;
        
        if ((_newMode == GUI_NAV_KEYBOARD) || (_newMode == GUI_NAV_GAMEPAD))
        {
            if (__navPointer)
            {
                //Reset mouse variables
                __mouseHold = false;
                
                __directionalLastX = __mouseX;
                __directionalLastY = __mouseY;
                __mousePrevX       = __mouseX;
                __mousePrevY       = __mouseY;
                __mousePressX      = undefined;
                __mousePressY      = undefined;
            }
            
            __navPointer     = false;
            __navDirectional = true;
        }
        else if ((_newMode == GUI_NAV_MOUSE) || (_newMode == GUI_NAV_TOUCH))
        {
            //Find any focused element that needs to be closed if we've swapped to a pointer mode
            var _focusStack = __focusStack;
            var _i = 0;
            repeat(array_length(_focusStack))
            {
                var _element = _focusStack[_i];
                if (_element.GUI_VARS.__focusType == GUI_FOCUS_POINTER_CANCEL_ALWAYS)
                {
                    GuiFocusClose(_element);
                    break;
                }
                
                ++_i;
            }
            
            __navPointer     = true;
            __navDirectional = false;
        }
        else
        {
            //Some undefined navigation mode, perhaps `GUI_NAV_UNKNOWN`
            __navPointer     = false;
            __navDirectional = false;
        }
        
        __navMode = _newMode;
    }
}