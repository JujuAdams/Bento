// Feather disable all

/// Updates library state for instances that need it.
/// 
/// Must be called in the scope of `__GuiClassLayer`.

function __GuiUpdateElementState()
{
    //Reset instance state for updating instances
    array_resize(__updateElementArray, array_filter_ext(__updateElementArray, function(_element)
    {
        if (not __GuiExists(_element)) return false;
        
        with(_element.GUI_VARS)
        {
            var _clickOnPress = (GuiUsingDirectional() ||
                                 (GUI_POINTER_CLICK_ON_PRESS
                               && other.__navPointer
                               && (not __GuiExists(__GuiScrollFindParent(_element)))));
            
            __click = false;
            
            //Manage over state
            if (other.__overElement == _element)
            {
                //System says this instance is hovered
                
                if (__overState == GUI_ENTER)
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(_element)}: enter -> over");
                    __overState = GUI_OVER;
                }
                else if (__overState == GUI_OVER)
                {
                    //Do nothing
                }
                else
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(_element)}: -> enter");
                    __overState = GUI_ENTER;
                }
            }
            else
            {
                //System says this instance is not hovered
                
                if (__overState == GUI_LEAVE)
                {
                    __overState = GUI_OFF;
                }
                else if (__overState != GUI_OFF)
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(_element)}: over -> leave");
                    __overState = GUI_LEAVE;
                }
            }
            
            //Manage hold state
            if (other.__primaryState == GUI_PRESS)
            {
                //System says the player has clicked
                
                if (GuiCursorGetOver(_element) && (not GuiPrimaryGetHold(_element)))
                {
                    __primaryState = GUI_PRESS;
                    other.__holdElement = _element;
                    
                    //Pass through a click signal to the instance if we're clicking on press
                    if (_clickOnPress) __click = true;
                }
            }
            else
            {
                if ((other.__primaryState == GUI_HOLD) && (other.__holdElement == _element))
                {
                    //If we're being continuously held move into the HOLD state
                    if (__primaryState == GUI_PRESS)
                    {
                        __primaryState = GUI_HOLD;
                    }
                }
                else
                {
                    //Unset the system's hold instance if it's us
                    if (other.__holdElement == _element) other.__holdElement = noone;
                    
                    if (__primaryState == GUI_RELEASE)
                    {
                        __primaryState = GUI_OFF;
                    }
                    else if (__primaryState != GUI_OFF)
                    {
                        __primaryState = GUI_RELEASE;
                        
                        //Pass through a click signal to the instance if we're clicking on released (and the instance is still selected)
                        if ((not _clickOnPress) && (other.__primaryState == GUI_RELEASE))
                        {
                            if (other.__navMode == GUI_MODE_TOUCH)
                            {
                                //Touch mode triggers the leave state early
                                if (__overState == GUI_LEAVE) __click = true;
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
            if ((__overState == GUI_OFF) && (__primaryState == GUI_OFF))
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