// Feather disable all

/// Updates library state for instances that need it.

function __GuiUpdateInstanceState()
{
    static _updateInstanceArray = __GuiSystem().__updateInstanceArray;
    
    //Reset instance state for updating instances
    array_resize(_updateInstanceArray, array_filter_ext(_updateInstanceArray, function(_instance)
    {
        static _system = __GuiSystem();
        
        with(_instance)
        {
            var _clickOnPress = (GuiNavUsingDirectional() ||
                                 (GUI_POINTER_CLICK_ON_PRESS
                               && _system.__navPointer
                               && (not instance_exists(__GuiScrollFindParent(id)))));
            
            __click = false;
            
            //Manage over state
            if (_system.__overInstance == id)
            {
                //System says this instance is selected
                
                if (__overState == GUI_ENTER)
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(id)}: enter -> over");
                    __overState = GUI_OVER;
                }
                else if (__overState == GUI_OVER)
                {
                    //Do nothing
                }
                else
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(id)}: -> enter");
                    __overState = GUI_ENTER;
                }
            }
            else
            {
                //System says this instance is not selected
                
                if (__overState == GUI_LEAVE)
                {
                    __overState = GUI_OFF;
                }
                else
                {
                    if (GUI_VERBOSE_OVER_STATE) __GuiTrace($"{real(id)}: over -> leave");
                    __overState = GUI_LEAVE;
                }
            }
            
            //Manage hold state
            if (_system.__holdState == GUI_PRESS)
            {
                //System says the player has clicked
                
                if (GuiNavGetOver() && (not GuiNavGetHold()))
                {
                    __holdState = GUI_PRESS;
                    _system.__holdInstance = _instance;
                    
                    //Pass through a click signal to the instance if we're clicking on press
                    if (_clickOnPress) __click = true;
                }
            }
            else
            {
                if ((_system.__holdState == GUI_HOLD) && (_system.__holdInstance == id))
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
                    if (_system.__holdInstance == id) _system.__holdInstance = noone;
                    
                    if (__holdState == GUI_RELEASE)
                    {
                        __holdState = GUI_OFF;
                    }
                    else if (__holdState != GUI_OFF)
                    {
                        __holdState = GUI_RELEASE;
                        
                        //Pass through a click signal to the instance if we're clicking on released (and the instance is still selected)
                        if ((not _clickOnPress) && (_system.__holdState == GUI_RELEASE))
                        {
                            if (_system.__navMode == GUI_NAV_TOUCH)
                            {
                                //Touch mode triggers the leave state early
                                if (__overState == GUI_LEAVE) __click = true;
                            }
                            else
                            {
                                if (GuiNavGetOver()) __click = true;
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