// Feather disable all

/// Sets the current navigation mode. This should be one of the following constants:
/// 
/// - `GUI_NAV_UNKNOWN`
/// - `GUI_NAV_MOUSE`
/// - `GUI_NAV_DIRECTIONAL`
/// - `GUI_NAV_TOUCH`
/// 
/// @param mode

function GuiNavSetMode(_newMode)
{
    with(GUI_ENVIRONMENT)
    {
        if (__navMode == _newMode) return;
        
        //Changing navigation mode may change whether elements are selectable underneath focusable parents
        __stepDirty = true;
        
        if (_newMode == GUI_NAV_DIRECTIONAL)
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
        }
        else
        {
            GuiNavClearFocus();
        }
        
        __navMode = _newMode;
        __navPointer = ((_newMode == GUI_NAV_MOUSE) || (_newMode == GUI_NAV_TOUCH));
    }
}