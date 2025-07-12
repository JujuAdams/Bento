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
                var _clickOnPress = true;
            }
            else if (not BentoExists(__BentoScrollFindParent(_element)))
            {
                var _clickOnPress = other.__navPointer && (BENTO_POINTER_CLICK_ON_PRESS || (other.__navMode == BENTO_MODE_TOUCH));
            }
            else
            {
                var _clickOnPress = false;
            }
            
            __click = false;
            
            ///////
            // Hover state
            ///////
            
            if (other.__hoverElement == _element)
            {
                //System says this element is hovered
                
                if (__hoverState == __BENTO_START)
                {
                    if (BENTO_VERBOSE_HOVER_STATE) __BentoTrace($"{real(_element)}: enter -> hover");
                    __hoverState = __BENTO_ON;
                }
                else if (__hoverState == __BENTO_ON)
                {
                    //Do nothing
                }
                else
                {
                    if (BENTO_VERBOSE_HOVER_STATE) __BentoTrace($"{real(_element)}: -> enter");
                    __hoverState = __BENTO_START;
                }
            }
            else
            {
                //System says this element is not hovered
                
                if (__hoverState == __BENTO_END)
                {
                    __hoverState = __BENTO_OFF;
                }
                else if (__hoverState != __BENTO_OFF)
                {
                    if (BENTO_VERBOSE_HOVER_STATE) __BentoTrace($"{real(_element)}: hover -> leave");
                    __hoverState = __BENTO_END;
                }
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
                    
                    //Pass through a click signal to the element if we're clicking on press
                    if (_clickOnPress) __click = true;
                }
            }
            else
            {
                //Compare hold element to ourselves using a BENTO_VARS check - this is because GameMaker sometimes
                //gets confused with comparing instance references. It appears that comparisons between `id` and
                //`self` will occasionally return false positives. However, comparing the `BENTO_VARS` structs is
                //stable and returns accurate information.
                var _isLayerHoldElement = (other.__holdElement != BENTO_NO_ELEMENT) && (other.__holdElement.BENTO_VARS == self);
                
                if ((other.__primaryState == __BENTO_ON) && _isLayerHoldElement)
                {
                    if (__primaryState == __BENTO_START)
                    {
                        __primaryState = __BENTO_ON;
                    }
                }
                else
                {
                    if (_isLayerHoldElement)
                    {
                        //Unset the system's hold element if it's us
                        other.__holdElement = BENTO_NO_ELEMENT;
                        
                        if (other.__primaryState & __BENTO_START)
                        {
                            __primaryState = __BENTO_END;
                            
                            //Pass through a click signal to the element if we're clicking on released (and the element is still selected)
                            if ((not _clickOnPress) && (other.__primaryState == __BENTO_END))
                            {
                                if (other.__navMode == BENTO_MODE_TOUCH)
                                {
                                    //Touch mode triggers the leave state early
                                    if (__hoverState == __BENTO_END) __click = true;
                                }
                                else
                                {
                                    if (BentoCursorGetHover(_element)) __click = true;
                                }
                            }
                        }
                        else
                        {
                            //Primary button has been released, mose us torwards the END state.
                            __primaryState = __primaryState >> 1;
                        }
                    }
                    else
                    {
                        //We not the layer's held element. Move us towards the END state.
                        __primaryState = __primaryState >> 1;
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