// Feather disable all

/// @param environment
/// @param name

function __BentoClassLayer(_environment, _name) constructor
{
    static _system = __BentoSystem();
    
    __environment = _environment;
    __name        = _name;
    
    ////////
    // Gemeral state
    ////////
    
    __frozen = false;
    __rootElement = BENTO_NO_ELEMENT;
    
    __animatingMap   = ds_map_create();
    __animatingArray = [];
    
    ////////
    // Set up a default input mode for convenience
    ////////
    
    if ((os_type == os_switch) || (os_type == os_ps4) || (os_type == os_ps5) || (os_type == os_xboxone) || (os_type == os_xboxseriesxs))
    {
        __navMode = BENTO_MODE_GAMEPAD;
    }
    else if ((os_type == os_android) || (os_type == os_ios) || (os_type == os_tvos))
    {
        __navMode = BENTO_MODE_TOUCH;
    }
    else if ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))
    {
        __navMode = BENTO_DESKTOP_DEFAULT_NAV_MODE;
    }
    else
    {
        __navMode = BENTO_MODE_MOUSE;
    }
    
    //Explicitly using a mouse or touch input
    __navPointer = ((__navMode == BENTO_MODE_MOUSE) || (__navMode == BENTO_MODE_TOUCH));
    
    //Explicitly using a keyboard or gamepad
    __navDirectional = ((__navMode == BENTO_MODE_KEYBOARD) || (__navMode == BENTO_MODE_GAMEPAD));
    
    ////////
    // Input state
    ////////
    
    __mouseX        = 0;
    __mouseY        = 0;
    __mouseHold     = false;
    __mousePrevX    = 0;
    __mousePrevY    = 0;
    __mousePressX   = undefined;
    __mousePressY   = undefined;
    
    __directionalDX    = 0;
    __directionalDY    = 0;
    __directionalHold  = false;
    __directionalLastX = 0;
    __directionalLastY = 0;
    
    __cursorLastL = 0;
    __cursorLastT = 0;
    __cursorLastR = 0;
    __cursorLastB = 0;
    
    __directionalStateX = new __BentoClassDirectionalState();
    __directionalStateY = new __BentoClassDirectionalState();
    
    __hotkeyStateMap    = ds_map_create();
    __hotkeyConsumedMap = ds_map_create();
    
    ////////
    // Update tracking
    ////////
    
    __layoutOrder    = [];
    __stepOrder      = [];
    __hoverableOrder = [];
    __drawOrder      = [];
    
    __dirtyFlags = __BENTO_DIRTY_ALL;
    __hoverableRegenCount = 0;
    
    __dirtyChildOrderArray   = [];
    __dirtyScrollLimitsArray = [];
    __dirtyOffsetArray       = [];
    __dirtyTransformsArray   = [];
    __scrollAnimatingArray   = [];
    
    __hoverElement     = BENTO_NO_ELEMENT;
    __hoverElementSoft = BENTO_NO_ELEMENT;
    __primaryState     = __BENTO_OFF;
    __primaryConsumed  = false;
    __holdElement      = BENTO_NO_ELEMENT;
    
    __updateElementArray = [];
    
    __nameMap = ds_map_create();
    
    __focusStack = [];
    __focusTop   = undefined;
    
    
    
    
    
    static __Destroy = function()
    {
        BentoDestroy(__rootElement);
        __environment.__RemoveLayer(self);
    }
    
    static __Update = function(_rootWidth, _rootHeight, _ensureOnly)
    {
        var _environment = __environment;
        
        __BentoLayerTargetPush(self);
        
        if (not _ensureOnly)
        {
            //Check if any animating elements have timed out
            var _i = array_length(__animatingArray)-1;
            repeat(array_length(__animPlaying))
            {
                with(__animPlaying[_i])
                {
                    ++__animElapsed;
                    
                    var _t = clamp((__animElapsed - __animDelay) / __animDuration, 0, 1);
                    if (_t >= 1)
                    {
                        BentoAnimStop(true, __attachedElement);
                    }
                    else
                    {
                        __animMethod(__attachedElement, _t, __animMetadata);
                    }
                }
                
                --_i;
            }
            
            //If anything is animating, consume all input
            if (not ds_map_empty(__animatingMap))
            {
                BentoInputConsume(self);
            }
            
            ///////
            // Input handling
            ///////
            
            //Update mouse (pointer) input
            __mousePrevX = __mouseX;
            __mousePrevY = __mouseY;
            
            __mouseHold = _environment.__envMouseHold;
            
            if ((__navMode == BENTO_MODE_TOUCH) && (not __mouseHold))
            {
                __mouseX = -__BENTO_VERY_LARGE;
                __mouseY = -__BENTO_VERY_LARGE;
            }
            else
            {
                __mouseX = _environment.__envMouseX;
                __mouseY = _environment.__envMouseY;
            }
            
            //Update directional input
            __directionalHold = _environment.__envDirectionalHold;
            __directionalDX   = _environment.__envDirectionalDX;
            __directionalDY   = _environment.__envDirectionalDY;
            
            __directionalStateX.__Update(__directionalDX, _system.__frame);
            __directionalStateY.__Update(__directionalDY, _system.__frame);
            
            //Update hotkey input
            var _globalHotkeyInputMap = __environment.__envHotkeyInputMap;
            var _globalHotkeyArray    = __environment.__envHotkeyArray;
            var _i = 0;
            repeat(array_length(_globalHotkeyArray))
            {
                var _key = _globalHotkeyArray[_i];
                
                var _state = (__hotkeyStateMap[? _key] ?? __BENTO_OFF) >> 1;
                if (_globalHotkeyInputMap[? _key] ?? false) _state |= __BENTO_START;
                __hotkeyStateMap[? _key] = _state;
                
                if (_state == __BENTO_START)
                {
                    __hotkeyConsumedMap[? _key] = false;
                }
                
                ++_i;
            }
        }
        
        ///////
        // Layout and step order
        ///////
        
        //Ensure our root element is the same size as the overall Bento space
        BentoLayoutSetSize(_rootWidth, _rootHeight, __rootElement);
        
        //Keep our layout and step order updated as necessary. Updating the layer and step order here
        //catches any weird stuff the dev might've done between calls to `BentoSystemStep()`
        __BentoEnsureLayout();
        __BentoEnsureStepOrder();
        __BentoEnsureScrollLimits();
        __BentoEnsureOffset();
        __BentoEnsureHoverableOrder();
        
        if (not _ensureOnly)
        {
            ///////
            // Navigation
            ///////
            
            __BentoScissorReset();
            
            if (not __frozen)
            {
                __primaryState = (__primaryState >> 1);
                
                if (__navPointer)
                {
                    //Update the primary button state based on mouse input
                    if (__mouseHold) __primaryState |= __BENTO_START;
                    
                    //Start hovering an element if we're not currently holding an element
                    //We also want to check what element we're hovering if we've just released
                    if (not __BentoGetHoverableInternal(__holdElement, false)) __holdElement = BENTO_NO_ELEMENT;
                    
                    //Try to hover a new element (maybe)
                    if ((not __mouseHold) || ((__navMode == BENTO_MODE_TOUCH) && (__primaryState == __BENTO_START)))
                    {
                        __BentoStartHover(__BentoGetPointerHover(__mouseX, __mouseY));
                    }
                    
                    if (__primaryState == __BENTO_START)
                    {
                        if (__environment.__textHandler != undefined) //Detect clicking off of an input box
                        {
                            if ((__environment.__textElement != __hoverElement)
                            &&  (not BentoIsAncestor(__environment.__textElement, __hoverElement))
                            &&  __environment.__textHandler.__cancelOnClick)
                            {
                                __environment.__textHandler.__Terminate(BENTO_TEXT_ABORT);
                                __hoverElement = BENTO_NO_ELEMENT;
                            }
                        }
                        else if (BentoExists(__focusTop)) //Detect clicking off of a pop-up
                        {
                            if ((__focusTop != __hoverElement) //Don't destroy a pop-up if we're hovering directly over it
                            &&  (not BentoIsAncestor(__focusTop, __hoverElement))) //Also don't destroy if we're hovering over a child of the pop-up
                            {
                                var _focusType = __focusTop.BENTO_VARS.__focusType;
                                if (_focusType == BENTO_FOCUS_POINTER_CANCEL_ON_CLICK)
                                {
                                    BentoFocusClose(__focusTop);
                                    __hoverElement = BENTO_NO_ELEMENT;
                                }
                                else if (_focusType == BENTO_FOCUS_POINTER_DESTROY_ON_CLICK)
                                {
                                    BentoDestroy(__focusTop);
                                    __hoverElement = BENTO_NO_ELEMENT;
                                }
                            }
                        }
                        
                        //Set some variable state if we've clicked the mouse
                        __mousePressX = __mouseX;
                        __mousePressY = __mouseY;
                        
                        __mousePrevX = __mouseX;
                        __mousePrevY = __mouseY;
                    }
                    else if (__primaryState == __BENTO_END)
                    {
                        //And reset the mouse state when we release
                        __mousePressX = undefined;
                        __mousePressY = undefined;
                    }
                }
                else if (__navDirectional)
                {
                    //Update the primary button state based on directional input
                    if (__directionalHold) __primaryState |= __BENTO_START;
                    
                    //If the held element cannot be held then proactively reset the state variable
                    if (not __BentoGetHoverableInternal(__holdElement, false)) __holdElement = BENTO_NO_ELEMENT;
                    
                    //Move the cursor and hover a new element (maybe)
                    __BentoStartHover(__BentoGetDirectionalHover(__hoverElement, __directionalStateX.__output, __directionalStateY.__output));
                }
                else //Some other input mode, perhaps `BENTO_MODE_UNKNOWN`
                {
                    __holdElement = BENTO_NO_ELEMENT;
                    __BentoStartHover(BENTO_NO_ELEMENT);
                }
                
                if (__primaryState == __BENTO_START)
                {
                    __primaryConsumed = false;
                }
                
                __BentoUpdateElementState();
            }
            
            ///////
            // Step user event execution
            ///////
            
            var _stepOrder = __stepOrder;
            var _i = 0;
            repeat(array_length(_stepOrder))
            {
                _stepOrder[_i]();
                ++_i;
            }
        }
        
        ///////
        // Position updates
        ///////
        
        //Check to see if we need to update the layout and step order again
        __BentoEnsureLayout();
        __BentoEnsureStepOrder();
        __BentoEnsureScrollLimits();
        __BentoAnimateScroll();
        __BentoEnsureOffset();
        
        //And we're done
        __BentoLayerTargetPop();
    }
    
    static __Draw = function()
    {
        __BentoLayerTargetPush(self);
        
        __BentoEnsureDrawOrder();
        __BentoEnsureTransforms();
        
        var _drawOrder = __drawOrder;
        var _i = 0;
        repeat(array_length(_drawOrder))
        {
            _drawOrder[_i]();
            ++_i;
        }
        
        __BentoLayerTargetPop();
    }
    
    static __GetFocusRoot = function()
    {
        //If we're inputting text then we have to focus on that element
        if (BentoExists(__environment.__textElement))
        {
            return __environment.__textElement;
        }
        
        //Determine where to start the Step order processing
        //FIXME - Walk up focus stack to find a pointer constrain element rather than only looking at the top one
        var _focusTop = __focusTop;
        if (BentoExists(_focusTop))
        {
            if (__navDirectional) return _focusTop;
            
            var _focusType = _focusTop.BENTO_VARS.__focusType;
            if (_focusType == BENTO_FOCUS_POINTER_CONSTRAIN) return _focusTop;
            
            if (BENTO_FOCUS_BLOCKS_POINTER_HOVER
            &&  ((_focusType == BENTO_FOCUS_POINTER_CANCEL_ON_CLICK) || (_focusType == BENTO_FOCUS_POINTER_CANCEL_ON_CLICK)))
            {
                return _focusTop;
            }
        }
        
        return __rootElement;
    }
}