// Feather disable all

/// Updates library state for instances that need it.
/// 
/// Must be called in the scope of `__GuiClassEnvironment`.

function __GuiUpdateInstanceState()
{
    //Reset instance state for updating instances
    array_resize(__updateInstanceArray, array_filter_ext(__updateInstanceArray, function(_instance)
    {
        if (not GUI_EXISTS(_instance)) return false;
        
        with(_instance.GUI_VARS)
        {
            var _clickOnPress = (GuiNavUsingDirectional() ||
                                 (GUI_POINTER_CLICK_ON_PRESS
                               && other.__navPointer
                               && (not GUI_EXISTS(__GuiScrollFindParent(_instance)))));
            
            __click = false;
            
            //Manage over state
            if (other.__overInstance == _instance)
            {
                //System says this instance is hovered
                
                if (__overState == GUI_ENTER)
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(_instance)}: enter -> over");
                    __overState = GUI_OVER;
                }
                else if (__overState == GUI_OVER)
                {
                    //Do nothing
                }
                else
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(_instance)}: -> enter");
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
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(_instance)}: over -> leave");
                    __overState = GUI_LEAVE;
                }
            }
            
            //Manage hold state
            if (other.__holdState == GUI_PRESS)
            {
                //System says the player has clicked
                
                if (GuiNavGetOver(_instance) && (not GuiNavGetHold(_instance)))
                {
                    __holdState = GUI_PRESS;
                    other.__holdInstance = _instance;
                    
                    //Pass through a click signal to the instance if we're clicking on press
                    if (_clickOnPress) __click = true;
                }
            }
            else
            {
                if ((other.__holdState == GUI_HOLD) && (other.__holdInstance == _instance))
                {
                    //If we're being continuously held move into the HOLD state
                    if (__holdState == GUI_PRESS)
                    {
                        __holdState = GUI_HOLD;
                    }
                }
                else
                {
                    //Unset the system's hold instance if it's us
                    if (other.__holdInstance == _instance) other.__holdInstance = noone;
                    
                    if (__holdState == GUI_RELEASE)
                    {
                        __holdState = GUI_OFF;
                    }
                    else if (__holdState != GUI_OFF)
                    {
                        __holdState = GUI_RELEASE;
                        
                        //Pass through a click signal to the instance if we're clicking on released (and the instance is still selected)
                        if ((not _clickOnPress) && (other.__holdState == GUI_RELEASE))
                        {
                            if (other.__navMode == GUI_NAV_TOUCH)
                            {
                                //Touch mode triggers the leave state early
                                if (__overState == GUI_LEAVE) __click = true;
                            }
                            else
                            {
                                if (GuiNavGetOver(_instance)) __click = true;
                            }
                        }
                    }
                }
            }
            
            //Remove this instance from the update loop if it's inactive
            if ((__overState == GUI_OFF) && (__holdState == GUI_OFF))
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