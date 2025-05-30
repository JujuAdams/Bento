// Feather disable all

/// Updates library state for instances that need it.
/// 
/// Must be called in the scope of `__GuiClassLayer`.

function __GuiUpdateElementState()
{
    //Reset instance state for updating instances
    array_resize(__updateElementArray, array_filter_ext(__updateElementArray, function(_element)
    {
        if (not GuiExists(_element)) return false;
        
        with(_element.GUI_VARS)
        {
            var _clickOnPress = (GuiUsingDirectional() ||
                                 (GUI_POINTER_CLICK_ON_PRESS
                               && other.__navPointer
                               && (not GuiExists(__GuiScrollFindParent(_element)))));
            
            __click = false;
            
            //Manage over state
            if (other.__overElement == _element)
            {
                //System says this instance is hovered
                
                if (__overState == __GUI_START)
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(_element)}: enter -> over");
                    __overState = __GUI_ON;
                }
                else if (__overState == __GUI_ON)
                {
                    //Do nothing
                }
                else
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(_element)}: -> enter");
                    __overState = __GUI_START;
                }
            }
            else
            {
                //System says this instance is not hovered
                
                if (__overState == __GUI_END)
                {
                    __overState = __GUI_OFF;
                }
                else if (__overState != __GUI_OFF)
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(_element)}: over -> leave");
                    __overState = __GUI_END;
                }
            }
            
            //Manage hold state
            if (other.__primaryState == __GUI_START)
            {
                //System says the player has clicked
                
                if (GuiCursorGetOver(_element) && (not GuiPrimaryGetHold(_element)))
                {
                    __primaryState = __GUI_START;
                    other.__holdElement = _element;
                    
                    //Pass through a click signal to the instance if we're clicking on press
                    if (_clickOnPress) __click = true;
                }
            }
            else
            {
                if ((other.__primaryState == __GUI_ON) && (other.__holdElement == _element))
                {
                    //If we're being continuously held move into the HOLD state
                    if (__primaryState == __GUI_START)
                    {
                        __primaryState = __GUI_ON;
                    }
                }
                else
                {
                    //Unset the system's hold instance if it's us
                    if (other.__holdElement == _element) other.__holdElement = noone;
                    
                    if (__primaryState == __GUI_END)
                    {
                        __primaryState = __GUI_OFF;
                    }
                    else if (__primaryState != __GUI_OFF)
                    {
                        __primaryState = __GUI_END;
                        
                        //Pass through a click signal to the instance if we're clicking on released (and the instance is still selected)
                        if ((not _clickOnPress) && (other.__primaryState == __GUI_END))
                        {
                            if (other.__navMode == GUI_MODE_TOUCH)
                            {
                                //Touch mode triggers the leave state early
                                if (__overState == __GUI_END) __click = true;
                            }
                            else
                            {
                                if (GuiCursorGetOver(_element)) __click = true;
                            }
                        }
                    }
                }
            }
            
            //Remove this instance from the update loop if it's inactive
            if ((__overState == __GUI_OFF) && (__primaryState == __GUI_OFF))
            {
                __updating = false;
                return false;
            }
            else
            {
                return true;
            }
        }
        
        return false;
    }));
}