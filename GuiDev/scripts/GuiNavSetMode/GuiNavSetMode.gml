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
        
        //Changing navigation mode may change whether elements are hoverable in branches
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
            
            __navPointer = false;
        }
        else
        {
            //Find any branch that needs to be cancelled if we've swapped to a pointer mode
            var _branchStack = __branchStack;
            var _i = 0;
            repeat(array_length(_branchStack))
            {
                var _element = _branchStack[_i];
                if (_element.GUI_VARS.__branchType == GUI_BRANCH_POINTER_CANCEL_ALWAYS)
                {
                    GuiNavBranchClose(_element);
                    break;
                }
                
                ++_i;
            }
            
            __navPointer = true;
        }
        
        __navMode = _newMode;
    }
}