// Feather disable all

/// Updates library state for elements that need it.
/// 
/// Must be called in the scope of `__BentoClassLayer`.

function __BentoUpdateElementState()
{
    //Reset state for updating elements
    array_resize(__updateElementArray, array_filter_ext(__updateElementArray, function(_elementVars)
    {
        with(_elementVars)
        {
            var _element = __attachedElement;
            if (not BentoExists(_element)) return false;
            
            if (other.__navDirectional)
            {
                //Keyboard and gamepad input always uses click-on-press
                var _clickOnPress = true;
            }
            else if (BentoExists(__BentoScrollFindParent(_element)))
            {
                var _clickOnPress = false;
            }
            else if (__dndItemChannel != undefined)
            {
                var _clickOnPress = false;
            }
            else
            {
                var _clickOnPress = other.__navPointer && (BENTO_POINTER_CLICK_ON_PRESS || (other.__navMode == BENTO_MODE_TOUCH));
            }
            
            __click = false;
            
            ///////
            // Hover state
            ///////
            
            //Advance our state
            __hoverState = __hoverState >> 1;
            
            if ((other.__hoverElement != BENTO_NO_ELEMENT) && (other.__hoverElement.BENTO_VARS == self))
            {
                __hoverState |= __BENTO_START;
            }
            
            if (__hoverState != __BENTO_START)
            {
                __byNavigation = false;
            }
            
            ///////
            // Hold state
            ///////
            
            if (other.__primaryState == __BENTO_START)
            {
                //System says the player has clicked
                
                if (BentoCursorGetHover(_element) && (not BentoPrimaryGetHold(_element)))
                {
                    __primaryState = __BENTO_START;
                    other.__holdElement = _element;
                    
                    if (other.__navDirectional || BENTO_DRAG_ALWAYS_TOGGLES)
                    {
                        //Directional input modes toggle on the primary button
                        if (other.__dndItemElement == _element)
                        {
                            //Defer cancelling until the next update tick
                            other.__dndItemCancel = true;
                        }
                        else
                        {
                            other.__dndItemElement = _element;
                            other.__dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
                        }
                    }
                    else if (other.__navPointer)
                    {
                        //Pointer input modes and click-and-hold
                        //TODO - Do we want to change the drag & drop to trigger when the pointer has moved a certain distance?
                        if (__dndItemChannel != undefined)
                        {
                            other.__dndItemElement = _element;
                            other.__dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
                        }
                    }
                    
                    //Pass through a click signal to the element if we're clicking on press
                    if (_clickOnPress) __click = true;
                }
            }
            else
            {
                //Advance our state
                __primaryState = __primaryState >> 1;
                
                //Compare hold element to ourselves using a BENTO_VARS check - this is because GameMaker sometimes
                //gets confused with comparing instance references. It appears that comparisons between `id` and
                //`self` will occasionally return false positives. However, comparing the `BENTO_VARS` structs is
                //stable and returns accurate information.
                var _isLayerHoldElement = (other.__holdElement != BENTO_NO_ELEMENT) && (other.__holdElement.BENTO_VARS == self);
                var _isLayerItemElement = (other.__dndItemElement != BENTO_NO_ELEMENT) && (other.__dndItemElement.BENTO_VARS == self);
                
                if ((other.__primaryState == __BENTO_ON) && (_isLayerHoldElement || _isLayerItemElement))
                {
                    //Primary button is still down, we're still held
                    __primaryState |= __BENTO_START;
                }
                else
                {
                    //Primary button is released or off, or the hold element changed away from us unexpectedly.
                    
                    if (_isLayerHoldElement)
                    {
                        //Unset the system's hold element since that's us
                        other.__holdElement = BENTO_NO_ELEMENT;
                        
                        //Pass through a click signal to the element if we're clicking on release
                        if ((not _clickOnPress) && (__primaryState == __BENTO_END) && (other.__primaryState == __BENTO_END))
                        {
                            if (other.__navMode == BENTO_MODE_TOUCH)
                            {
                                //Because we set the mouse x/y position to large negative numbers before running this function, the
                                //hover state for the held element will always be in the leaving (END) state.
                                if (__hoverState == __BENTO_END) __click = true;
                            }
                            else
                            {
                                //Only click if we're hovered.
                                if (BentoCursorGetHover(_element)) __click = true;
                            }
                        }
                    }
                    
                    //Unset the drag & drop element on release for pointers
                    if (_isLayerItemElement && other.__navPointer && (not BENTO_DRAG_ALWAYS_TOGGLES))
                    {
                        //Defer cancelling until the next update tick
                        other.__dndItemCancel = true;
                    }
                }
            }
            
            //Remove this element from the update loop if it's inactive
            if ((__hoverState == __BENTO_OFF) && (__primaryState == __BENTO_OFF))
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