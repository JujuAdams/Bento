// Feather disable all

/// Must be called in the scope of `__BentoClassLayer`.

function __BentoUpdateActiveElement(_elementVars)
{
    with(_elementVars)
    {
        var _element = __attachedElement;
        if (not BentoExists(_element)) return false;
        
        if (other.__inputModeNavigation)
        {
            if (__clickTiming != undefined)
            {
                var _clickOnPress = (__clickTiming == BENTO_CLICK_ON_PRESS);
            }
            else
            {
                var _clickOnPress = true;
            }
        }
        else if (BentoExists(__BentoFindScrollElement(_element))
                || (__carryItemChannel != undefined)
                || __longPressEnabled)
        {
            var _clickOnPress = false;
        }
        else
        {
            if (__clickTiming != undefined)
            {
                var _clickOnPress = (__clickTiming == BENTO_CLICK_ON_PRESS);
            }
            else
            {
                var _clickOnPress = (other.__inputModePointer && (BENTO_POINTER_CLICK_ON_PRESS || (other.__inputMode == BENTO_MODE_TOUCH)));
            }
        }
            
        __clickState = 0b00;
            
        ///////
        // Drag & drop
        ///////
            
        __carryItemState = __carryItemState >> 1;
            
        var _isLayerItemElement = (other.__carryItemElement != BENTO_NO_ELEMENT) && (other.__carryItemElement.BENTO_VARS == self);
        if (_isLayerItemElement)
        {
            __carryItemState = __carryItemState | __BENTO_STATE_START;
        }
        else if (__carryItemState == __BENTO_STATE_OFF)
        {
            __carryTargetElement = BENTO_NO_ELEMENT;
        }
            
        ///////
        // Hover state
        ///////
            
        //Advance our hover state
        __hoverState = __hoverState >> 1;
            
        if ((other.__hoverElement != BENTO_NO_ELEMENT) && (other.__hoverElement.BENTO_VARS == self))
        {
            __hoverState |= __BENTO_STATE_START;
        }
            
        if (__hoverState != __BENTO_STATE_START)
        {
            //Reset the "by player" state
            __byPlayer = false;
        }
            
        ///////
        // Hold state
        ///////
            
        if (other.__primaryState == __BENTO_STATE_START)
        {
            //System says the player has clicked
                
            if (((__hoverState & __BENTO_STATE_START) || _isLayerItemElement)
            &&  (not (__primaryState & __BENTO_STATE_START)))
            {
                __primaryState = __BENTO_STATE_START;
                __pressTime = current_time;
                    
                if (not _isLayerItemElement)
                {
                    other.__holdElement = _element; 
                        
                    //Pass through a click signal to the element if we're clicking on press
                    if (_clickOnPress) __clickState = 0b01;
                }
            }
        }
        else
        {
            //Advance our state
            __primaryState = __primaryState >> 1;
            __primaryLongState = __primaryLongState >> 1;
                
            //Compare hold element to ourselves using a BENTO_VARS check - this is because GameMaker sometimes
            //gets confused with comparing instance references. It appears that comparisons between `id` and
            //`self` will occasionally return false positives. However, comparing the `BENTO_VARS` structs is
            //stable and returns accurate information.
            var _isLayerHoldElement = (other.__holdElement != BENTO_NO_ELEMENT) && (other.__holdElement.BENTO_VARS == self);
            if ((other.__primaryState == __BENTO_STATE_ON) && (_isLayerHoldElement || _isLayerItemElement))
            {
                //Primary button is still down, we're still held
                __primaryState |= __BENTO_STATE_START;
                    
                //Trigger a long click
                if (__longPressEnabled && (current_time - __pressTime >= BENTO_LONG_CLICK_TIME))
                {
                    __primaryLongState |= __BENTO_STATE_START;
                }
            }
            else
            {
                //Primary button is released or off, or the hold element changed away from us unexpectedly.
                    
                if (_isLayerHoldElement)
                {
                    //Unset the system's hold element since that's us
                    other.__holdElement = BENTO_NO_ELEMENT;
                        
                    //Pass through a click signal to the element if we're clicking on release
                    if ((not _clickOnPress)
                    &&  (not _isLayerItemElement)
                    &&  (__primaryState == __BENTO_STATE_END)
                    &&  (other.__primaryState == __BENTO_STATE_END)
                    &&  (not other.__pointerScrolled))
                    {
                        if (other.__inputMode == BENTO_MODE_TOUCH)
                        {
                            //Because we set the mouse x/y position to large negative numbers before running this function, the
                            //hover state for the held element will always be in the leaving (END) state.
                            if (__hoverState == __BENTO_STATE_END)
                            {
                                __clickState = (__primaryLongState > 0)? 0b10 : 0b01;
                            }
                        }
                        else
                        {
                            //Only click if we're hovered.
                            if (__hoverState & __BENTO_STATE_START)
                            {
                                __clickState = (__primaryLongState > 0)? 0b10 : 0b01;
                            }
                        }
                    }
                }
            }
        }
        
        ///////
        // Scrolling
        ///////
        
        //Scrolling when in navigation input mode is handled when an element is hovered
        
        if (other.__inputModePointer && (__hoverState & __BENTO_STATE_START))
        {
            if (other.__pointerTravelled
            &&  ((BENTO_SCROLL_ON_MOUSE_DRAG || (other.__inputMode == BENTO_MODE_TOUCH)) && (__primaryState == __BENTO_STATE_ON)))
            {
                //Click & drag
                    
                var _pressX = other.__pointerPressX;
                var _pressY = other.__pointerPressY;
                    
                if ((not __holdBlocksDragScroll) && (__carryItemState == __BENTO_STATE_OFF))
                {
                    var _overScrollbar = false;
                        
                    with(__scrollbarVert)
                    {
                        if (point_in_rectangle(_pressX, _pressY, barLeft, barTop, barRight, barBottom))
                        {
                            _overScrollbar = true;
                        }
                    }
                        
                    with(__scrollbarHori)
                    {
                        if (point_in_rectangle(_pressX, _pressY, barLeft, barTop, barRight, barBottom))
                        {
                            _overScrollbar = true;
                        }
                    }
                        
                    if (not _overScrollbar)
                    {
                        var _parent = __BentoFindScrollElement(_element);
                        if (BentoExists(_parent))
                        {
                            //Start scrolling the parent
                            other.__pointerScrolled = true;
                            other.__pointerScrollingElement = _parent;
                                
                            //Unhover and unhold us. This makes it clear that the player is no longer interacting
                            //with us and instead is interacting with the scrolling parent
                            other.__holdElement = BENTO_NO_ELEMENT;
                            other.__ClearHoverElement();
                        }
                    }
                }
            }
            else
            {
                //Allow the mouse wheel to scroll when hovering over a container or its children
                    
                var _dX = 0;
                var _dY = 0;
                    
                //Mouse wheel input can be pretty noisy so we filter out as much as possible
                    
                if (BentoHotkeyGetPress(BENTO_HOTKEY_MOUSE_WHEEL_UP) || BentoHotkeyGetHold(BENTO_HOTKEY_MOUSE_WHEEL_UP))
                {
                    _dX -= BENTO_MOUSE_WHEEL_SCROLL_SPEED;
                    _dY += BENTO_MOUSE_WHEEL_SCROLL_SPEED;
                }
                    
                if (BentoHotkeyGetPress(BENTO_HOTKEY_MOUSE_WHEEL_DOWN) || BentoHotkeyGetHold(BENTO_HOTKEY_MOUSE_WHEEL_DOWN))
                {
                    _dX += BENTO_MOUSE_WHEEL_SCROLL_SPEED;
                    _dY -= BENTO_MOUSE_WHEEL_SCROLL_SPEED;
                }
                    
                if ((_dX != 0) || (_dY != 0))
                {
                    BentoScrollAddPos(_dX, _dY, BENTO_DEFAULT_SCROLL_SPEED, _element);
                }
            }
        }
        
        //Remove this element from the update loop if it's inactive
        if ((__primaryState != __BENTO_STATE_OFF)
        ||  (__primaryLongState != __BENTO_STATE_OFF)
        ||  (__carryItemState != __BENTO_STATE_OFF)
        ||  (__carryTargetElement != BENTO_NO_ELEMENT))
        {
            //We're updating states that are "dangerous" so we must run Step events
            other.__runStep = true;
            
            //Keep us in the array
            return true;
        }
        else if (__hoverState != __BENTO_STATE_OFF)
        {
            if ((__backgroundHover == BENTO_MAINTAIN_NEVER)
            ||  (__backgroundHover == BENTO_MAINTAIN_POINTER) && (not other.__inputModePointer)
            ||  (__backgroundHover == BENTO_MAINTAIN_NAVIGATION) && (not other.__inputModeNavigation)) 
            {
                //If we're *not* maintaining background hover then elements lose the opportunity
                //to catch the "hover end" (leave) state unless we run Step events
                other.__runStep = true;
            }
            
            //Keep us in the array
            return true;
        }
        else // if (__hoverState == __BENTO_STATE_OFF)
        {
            //Nothing interesting is happening! Remove us from the array
            __updating = false;
            return false;
        }
    }
    
    return false;
}