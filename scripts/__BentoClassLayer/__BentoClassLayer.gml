// Feather disable all

/// @param environment
/// @param name

function __BentoClassLayer(_environment, _name) constructor
{
    static _system = __BentoSystem();
    
    __environment = _environment;
    __name        = _name;
    
    if (BENTO_DEBUG_LEVEL >= 1)
    {
        __BentoTrace($"Creating layer {__BentoGetStructPointer(self)} called \"{__name}\" in environment {__BentoGetStructPointer(__environment)}");
    }
    
    ////////
    // Gemeral state
    ////////
    
    __rootElement = BENTO_NO_ELEMENT;
    
    __isTopLayer = true;
    __drawWhenBackgrounded = true;
    __runStep = true;
    
    __animPlayingArray      = [];
    __animPlayingMap        = ds_map_create();
    __animBlockingMap       = ds_map_create();
    __animAnyBlocking       = false;
    __animUnblockedCallback = undefined;
    __animUnblockedMetadata = undefined;
    __animUnblockedPersist  = false;
    
    //Set starting input mode from the environment
    __inputMode = __environment.__envInputMode;
    
    //Explicitly using a mouse or touch input
    __inputModePointer = ((__inputMode == BENTO_MODE_MOUSE) || (__inputMode == BENTO_MODE_TOUCH));
    
    //Explicitly using a keyboard or gamepad
    __inputModeNavigation = ((__inputMode == BENTO_MODE_KEYBOARD) || (__inputMode == BENTO_MODE_GAMEPAD));
    
    ////////
    // Input state
    ////////
    
    __pointerX            = 0;
    __pointerY            = 0;
    __pointerPrimaryState = __BENTO_STATE_OFF;
    __pointerPrevX        = 0;
    __pointerPrevY        = 0;
    __pointerPressX       = 0;
    __pointerPressY       = 0;
    
    __pointerTravelled = false;
    
    __pointerScrolled = false;
    __pointerScrollingElement = BENTO_NO_ELEMENT;
    
    __navigationDX           = 0;
    __navigationDY           = 0;
    __navigationPrimaryState = __BENTO_STATE_OFF;
    __navigationLastX        = 0;
    __navigationLastY        = 0;
    
    __cursorLastL = 0;
    __cursorLastT = 0;
    __cursorLastR = 0;
    __cursorLastB = 0;
    
    __turboState = new __BentoClassTurbo();
    
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
    
    __hoverElement       = BENTO_NO_ELEMENT;
    __hoverElementSoft   = BENTO_NO_ELEMENT;
    __hoverElementStored = undefined;
    __primaryState       = __BENTO_STATE_OFF;
    __primaryConsumed    = false;
    __holdElement        = BENTO_NO_ELEMENT;
    
    __carryNextItemElement = BENTO_NO_ELEMENT;
    __carryItemElement     = BENTO_NO_ELEMENT;
    
    __updateElementArray = [];
    
    __focusStack = [];
    __focusTop   = undefined;
    
    
    
    
    
    static __Destroy = function()
    {
        if (BENTO_DEBUG_LEVEL >= 1)
        {
            __BentoTrace($"Destroying layer {__BentoGetStructPointer(self)} called \"{__name}\" in environment {__BentoGetStructPointer(__environment)}");
        }
        
        BentoDestroy(__rootElement);
        __environment.__RemoveLayer(self);
    }
    
    static __ClearHoverElement = function()
    {
        __hoverElement = BENTO_NO_ELEMENT;
            
        //So long as we have a drag & drop element, set its target
        if (BentoExists(__carryItemElement))
        {
            __carryItemElement.BENTO_VARS.__carryTargetElement = BENTO_NO_ELEMENT;
        }
    }
    
    static __SetBackgroundedState = function()
    {
        __isTopLayer = false;
        
        __pointerX = -__BENTO_VERY_LARGE;
        __pointerY = -__BENTO_VERY_LARGE;
        
        __navigationDX = 0;
        __navigationDY = 0;
        
        __pointerTravelled = false;
        
        __ClearScrollingElement();
        
        //If this layer has the current text handler then abort its use
        if ((__environment.__textElement != undefined) && (__environment.__textElement.BENTO_VARS.__layer == self))
        {
            __environment.__textHandler.__Terminate(BENTO_TEXT_ABORT);
        }
        
        if (BentoExists(__hoverElement))
        {
            __hoverElementStored = weak_ref_create(__hoverElement);
            
            var _backgroundHover = __hoverElement.BENTO_VARS.__backgroundHover;
            if ((_backgroundHover == BENTO_MAINTAIN_NEVER)
            ||  (_backgroundHover == BENTO_MAINTAIN_POINTER) && (not __inputModePointer)
            ||  (_backgroundHover == BENTO_MAINTAIN_NAVIGATION) && (not __inputModeNavigation)) 
            {
                __ClearHoverElement();
            }
        }
        else
        {
            __hoverElementStored = BENTO_NO_ELEMENT;
        }
        
        __holdElement = BENTO_NO_ELEMENT;
        __ClearDraggedItem();
    }
    
    static __SetForegroundedState = function()
    {
        __isTopLayer = true;
        
        if ((__hoverElementStored != undefined) && weak_ref_alive(__hoverElementStored) && BentoExists(__hoverElementStored.ref))
        {
            __BentoSetHover(__hoverElementStored.ref, false);
        }
        
        __hoverElementStored = undefined;
    }
    
    static __ClearDraggedItem = function()
    {
        if (__carryItemElement != BENTO_NO_ELEMENT)
        {
            __carryItemElement = BENTO_NO_ELEMENT;
            
            if (BentoExists(__carryItemElement))
            {
                __carryItemElement.BENTO_VARS.__carryTargetElement = BENTO_NO_ELEMENT;
            }
            
            __dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
        }
    }
    
    static __ClearScrollingElement = function()
    {
        __pointerScrolled = false;
        __pointerScrollingElement = BENTO_NO_ELEMENT;
    }
    
    static __UpdateInputMode = function()
    {
        var _newMode = __environment.__envInputMode;
        if (__inputMode == _newMode) return;
        
        //Changing input mode may change whether elements execute their step event and are hoverable
        //when focused
        __dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
        
        if ((_newMode == BENTO_MODE_KEYBOARD) || (_newMode == BENTO_MODE_GAMEPAD))
        {
            if (__inputModePointer)
            {
                //Reset mouse variables if we've swapped mouse <-> touch
                __navigationLastX = __pointerX;
                __navigationLastY = __pointerY;
                
                __pointerPrevX = __pointerX;
                __pointerPrevY = __pointerY;
            }
            
            __inputModePointer     = false;
            __inputModeNavigation = true;
        }
        else if ((_newMode == BENTO_MODE_MOUSE) || (_newMode == BENTO_MODE_TOUCH))
        {
            //Find any focused element that needs to be closed if we've swapped to a pointer mode
            var _focusStack = __focusStack;
            var _i = 0;
            repeat(array_length(_focusStack))
            {
                var _element = _focusStack[_i].__focusElement;
                if (_element.BENTO_VARS.__focusType == BENTO_FOCUS_POINTER_CANCEL_ALWAYS)
                {
                    BentoFocusClose(_element);
                    break;
                }
                
                ++_i;
            }
            
            __inputModePointer     = true;
            __inputModeNavigation = false;
            
            __pointerPressX = __pointerX;
            __pointerPressY = __pointerY;
            
            __navigationDX = 0;
            __navigationDY = 0;
            
            __turboState.__Update(0, 0, _system.__frame);
        }
        else
        {
            //Some undefined input mode, perhaps `BENTO_MODE_UNKNOWN`
            __inputModePointer     = false;
            __inputModeNavigation = false;
        }
        
        __carryNextItemElement = BENTO_NO_ELEMENT;
        
        if (BentoExists(__carryItemElement))
        {
            __carryItemElement.BENTO_VARS.__carryItemContinuous = true;
        }
        
        __pointerTravelled = false;
        
        __primaryConsumed = false;
        
        __ClearScrollingElement();
        
        __inputMode = _newMode;
    }
    
    static __UpdateInputStateAsTopLevel = function()
    {
        //A full input state update. Player input is collected and passed into layer state
        
        static _hotkeyArray = [];
        
        var _environment = __environment;
        
        if (__inputModePointer)
        {
            var _pointerX = _environment.__envMouseX;
            var _pointerY = _environment.__envMouseY;
            
            var _prevPrimaryState = __pointerPrimaryState;
            var _envPrimaryState = _environment.__envMouseState;
            
            if (__primaryConsumed)
            {
                if (_envPrimaryState == __BENTO_STATE_START)
                {
                    __primaryConsumed = false;
                }
                else
                {
                    _envPrimaryState = __BENTO_STATE_OFF;
                }
            }
            
            if ((_prevPrimaryState == __BENTO_STATE_END) && (_envPrimaryState & __BENTO_STATE_START))
            {
                //Catch situations where we think we've released but the environment thinks we're held
                __pointerPrimaryState = __BENTO_STATE_START;
            }
            else if ((_prevPrimaryState == __BENTO_STATE_OFF) && (_envPrimaryState == __BENTO_STATE_START))
            {
                //Only allow us to start pressing when the environment is pressed
                __pointerPrimaryState = __BENTO_STATE_START;
            }
            else if (_prevPrimaryState & __BENTO_STATE_START) && (_envPrimaryState & __BENTO_STATE_START)
            {
                //Sustain primary hold
                __pointerPrimaryState = __BENTO_STATE_ON;
            }
            else
            {
                //Release primary
                __pointerPrimaryState = _prevPrimaryState >> 1;
            }
            
            if (__pointerPrimaryState == __BENTO_STATE_START)
            {
                //Set some variable state if we've clicked the mouse
                __pointerPressX = _pointerX;
                __pointerPressY = _pointerY;
                
                __pointerPrevX = _pointerX;
                __pointerPrevY = _pointerY;
            }
            else
            {
                __pointerPrevX = __pointerX;
                __pointerPrevY = __pointerY;
            }
            
            if ((__inputMode == BENTO_MODE_TOUCH) && (not (__pointerPrimaryState & __BENTO_STATE_START)))
            {
                __pointerX = -__BENTO_VERY_LARGE;
                __pointerY = -__BENTO_VERY_LARGE;
            }
            else
            {
                __pointerX = _pointerX;
                __pointerY = _pointerY;
                
                //Update mouse drag information
                if (__pointerPrimaryState & __BENTO_STATE_START)
                {
                    if (point_distance(__pointerPressX, __pointerPressY, __pointerX, __pointerY) > BENTO_POINTER_DRAG_THRESHOLD)
                    {
                        __pointerTravelled = true;
                    }
                }
            }
        }
        else
        {
            __pointerPrimaryState = __pointerPrimaryState >> 1;
        }
        
        if (__inputModeNavigation)
        {
            var _prevPrimaryState = __navigationPrimaryState;
            var _envPrimaryState = _environment.__envNavigationState;
            
            if (__primaryConsumed)
            {
                if (_envPrimaryState == __BENTO_STATE_START)
                {
                    __primaryConsumed = false;
                }
                else
                {
                    _envPrimaryState = __BENTO_STATE_OFF;
                }
            }
            
            if ((_prevPrimaryState == __BENTO_STATE_END) && (_envPrimaryState & __BENTO_STATE_START))
            {
                //Catch situations where we think we've released but the environment thinks we've held
                __navigationPrimaryState = __BENTO_STATE_START;
            }
            else if ((_prevPrimaryState == __BENTO_STATE_OFF) && (_envPrimaryState == __BENTO_STATE_START))
            {
                //Only allow us to start pressing when the environment is pressed
                __navigationPrimaryState = __BENTO_STATE_START;
            }
            else if (_prevPrimaryState & __BENTO_STATE_START) && (_envPrimaryState & __BENTO_STATE_START)
            {
                //Sustain primary hold
                __navigationPrimaryState = __BENTO_STATE_ON;
            }
            else
            {
                //Release primary
                __navigationPrimaryState = _prevPrimaryState >> 1;
            }
            
            //Update navigation input
            __navigationDX = _environment.__envNavigationDX;
            __navigationDY = _environment.__envNavigationDY;
            
            __turboState.__Update(__navigationDX, __navigationDY, _system.__frame);
        }
        else
        {
            __navigationPrimaryState = __navigationPrimaryState >> 1;
        }
        
        //Update hotkey input
        var _globalHotkeyInputMap = _environment.__envHotkeyInputMap;
        ds_map_keys_to_array(_globalHotkeyInputMap, _hotkeyArray);
        var _i = 0;
        repeat(array_length(_hotkeyArray))
        {
            var _key = _hotkeyArray[_i];
            
            var _state = (__hotkeyStateMap[? _key] ?? __BENTO_STATE_OFF) >> 1;
            if (_globalHotkeyInputMap[? _key] ?? false) _state |= __BENTO_STATE_START;
            __hotkeyStateMap[? _key] = _state;
            
            if (_state == __BENTO_STATE_START)
            {
                __hotkeyConsumedMap[? _key] = false;
            }
            
            ++_i;
        }
        
        array_resize(_hotkeyArray, 0);
    }
    
    static __UpdateInputStateAsBackgrounded = function()
    {
        //A partial update of input state. This artificially forces all player inputs to "off" or "null"
        //in some sense.
        
        static _hotkeyArray = [];
        
        var _environment = __environment;
        
        __pointerPrimaryState = __pointerPrimaryState >> 1;
        __navigationPrimaryState = __navigationPrimaryState >> 1;
        
        __turboState.__Update(0, 0, _system.__frame);
        
        //Update hotkey input
        var _globalHotkeyInputMap = _environment.__envHotkeyInputMap;
        ds_map_keys_to_array(_globalHotkeyInputMap, _hotkeyArray);
        var _i = 0;
        repeat(array_length(_hotkeyArray))
        {
            var _key = _hotkeyArray[_i];
            __hotkeyStateMap[? _key] = (__hotkeyStateMap[? _key] ?? __BENTO_STATE_OFF) >> 1;
            ++_i;
        }
        
        array_resize(_hotkeyArray, 0);
    }
    
    static __Ensure = function(_rootX, _rootY, _rootWidth, _rootHeight)
    {
        //Ensure our root element is the same size as the overall Bento space
        BentoSetOffset(_rootX, _rootY, __rootElement);
        BentoLayoutSetSize(_rootWidth, _rootHeight, __rootElement);
        
        //Keep our layout and step order updated as necessary. Updating the layer and step order here
        //catches any weird stuff the dev might've done between calls to `BentoSystemStep()`
        __BentoEnsureLayout();
        __BentoEnsureStepOrder();
        __BentoEnsureScrollLimits();
        __BentoEnsureOffset();
        __BentoEnsureHoverableOrder();
    }
    
    static __Update = function(_rootX, _rootY, _rootWidth, _rootHeight, _timeStep)
    {
        var _isTopLayer = __isTopLayer;
        
        //This is the main update function for a layer. It handles hovering elements, holding elements,
        //scrolling containers, disabling focus etc.
        
        __BentoLayerTargetPush(self);
        
        ///////
        // Animations
        ///////
        
        var _animPlayingArray = __animPlayingArray;
        var _i = array_length(_animPlayingArray)-1;
        repeat(array_length(_animPlayingArray))
        {
            with(_animPlayingArray[_i])
            {
                __animElapsed += _timeStep;
                
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
        
        if (not ds_map_empty(__animBlockingMap))
        {
            //If anything has a blocking animating, consume all input
            if (_isTopLayer)
            {
                BentoInputConsume(self);
            }
        }
        else
        {
            //Otherwise check if we need to execute the unblocked callback
            __CheckUnblocked();
        }
        
        if (_isTopLayer)
        {
            __UpdateInputMode();
        }
        
        ///////
        // Drag & drop
        ///////
        
        if (BentoExists(__carryNextItemElement))
        {
            //Incoming new item element
            
            if (__carryNextItemElement != __carryItemElement)
            {
                //The item element has changed
                
                if (BentoExists(__carryItemElement))
                {
                    //To avoid bugs, reset the target for the existing item element
                    __carryItemElement.BENTO_VARS.__carryTargetElement = BENTO_NO_ELEMENT;
                }
                
                __carryItemElement = __carryNextItemElement;
                
                //We're going to scroll using edge detection so we don't need to actively track grabbing a scrollable element
                __ClearScrollingElement();
                
                with(__carryItemElement.BENTO_VARS)
                {
                    __carryPointerDX = other.__pointerPressX - __attachedElement.bentoX;
                    __carryPointerDY = other.__pointerPressY - __attachedElement.bentoY;
                    
                    __carryTargetElement = BENTO_NO_ELEMENT;
                    __BentoSetAsUpdating();
                }
                
                __dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            }
            
            __carryNextItemElement = BENTO_NO_ELEMENT;
        }
        else if (__carryItemElement != BENTO_NO_ELEMENT)
        {
            //No new item element
            
            if ((not BentoExists(__carryItemElement)) || __carryItemElement.BENTO_VARS.__carryItemContinuous)
            {
                //If we have no new drag & drop item element and the current item is continuous then we've lost the item
                __carryItemElement = BENTO_NO_ELEMENT;
                __dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            }
        }
        
        ///////
        // Ensure various orders
        ///////
        
        __Ensure(_rootX, _rootY, _rootWidth, _rootHeight);
        
        ///////
        // Input
        ///////
        
        if (_isTopLayer)
        {
            __UpdateInputStateAsTopLevel();
            
            //Reset the drag & drop element if it has been destroyed for some reason or its channel has
            //been set to `undefined`
            if ((__carryItemElement != BENTO_NO_ELEMENT)
            &&  ((not __BentoGetHoverableInternal(__carryItemElement, false)) || (__carryItemElement.BENTO_VARS.__carryItemChannel == undefined)))
            {
                __ClearDraggedItem();
            }
        }
        else
        {
            __UpdateInputStateAsBackgrounded();
        }
        
        if (__inputModePointer)
        {
            //Update the primary button state based on mouse input
            __primaryState = __pointerPrimaryState;
        }
        else if (__inputModeNavigation)
        {
            //Update the primary button state based on navigation input
            __primaryState = __navigationPrimaryState;
        }
        else
        {
            __primaryState = __primaryState << 1;
        }
        
        if (_isTopLayer)
        {
            ///////
            // Pointer and Navigation
            ///////
            
            __BentoScissorReset();
            
            if (__inputModePointer)
            {
                if ((__pointerPrimaryState & __BENTO_STATE_START) && BentoExists(__pointerScrollingElement))
                {
                    //Handle scrolling as a priority. This will block out hovering new elements
                    BentoScrollAddPos(__pointerX - __pointerPrevX, __pointerY - __pointerPrevY, infinity, __pointerScrollingElement);
                }
                else
                {
                    //Verify that the currently held element is still held
                    if (not __BentoGetHoverableInternal(__holdElement, false))
                    {
                        if (__holdElement != BENTO_NO_ELEMENT)
                        {
                            __holdElement = BENTO_NO_ELEMENT;
                        }
                    }
                    
                    if ((not (__pointerPrimaryState & __BENTO_STATE_START)) //Hover if the primary isn't held
                    ||  (__carryItemElement != BENTO_NO_ELEMENT) //Hover if we have a drag & drop item
                    ||  (__inputMode == BENTO_MODE_TOUCH)) //Always hover if we're in touch mode
                    {
                        __BentoSetHoverFromPointer(__pointerX, __pointerY);
                    }
                    
                    //Now handle primary press
                    if (__pointerPrimaryState == __BENTO_STATE_START)
                    {
                        if (__environment.__textHandler != undefined) //Detect clicking off of an input box
                        {
                            if ((__environment.__textElement != __hoverElement)
                            &&  (not BentoIsAncestor(__environment.__textElement, __hoverElement))
                            &&  __environment.__textHandler.__cancelOnClick)
                            {
                                __environment.__textHandler.__Terminate(BENTO_TEXT_ABORT);
                                __ClearHoverElement();
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
                                    __ClearHoverElement();
                                }
                                else if (_focusType == BENTO_FOCUS_POINTER_DESTROY_ON_CLICK)
                                {
                                    BentoDestroy(__focusTop);
                                    __ClearHoverElement();
                                }
                            }
                        }
                    }
                    
                    //Handle scrolling when the pointer is near the edge of a scrolling element
                    if (__carryItemElement != BENTO_NO_ELEMENT)
                    {
                        var _pointerScrollingElement = __BentoFindScrollElement(__hoverElement);
                        if (_pointerScrollingElement != BENTO_NO_ELEMENT)
                        {
                            var _hotspotWidth  = min(60, _pointerScrollingElement.bentoWidth/2); //TODO - Make this a macro
                            var _hotspotHeight = min(60, _pointerScrollingElement.bentoHeight/2);
                            
                            var _dX = 0;
                            
                            if ((__pointerX > _pointerScrollingElement.bentoLeft) && (__pointerX <= _pointerScrollingElement.bentoLeft + _hotspotWidth))
                            {
                                var _dX = 4; //TODO - Make this a macro
                            }
                            else if ((__pointerX >= _pointerScrollingElement.bentoRight - _hotspotWidth) && (__pointerX < _pointerScrollingElement.bentoRight))
                            {
                                var _dX = -4;
                            }
                            else
                            {
                                var _dX = 0;
                            }
                            
                            if ((__pointerY > _pointerScrollingElement.bentoTop) && (__pointerY <= _pointerScrollingElement.bentoTop + _hotspotHeight))
                            {
                                var _dY = 4; //TODO - Make this a macro
                            }
                            else if ((__pointerY >= _pointerScrollingElement.bentoBottom - _hotspotHeight) && (__pointerY < _pointerScrollingElement.bentoBottom))
                            {
                                var _dY = -4;
                            }
                            else
                            {
                                var _dY = 0;
                            }
                            
                            BentoScrollAddPos(_dX, _dY, infinity, _pointerScrollingElement);
                        }
                    }
                }
                
                if (__pointerPrimaryState == __BENTO_STATE_END)
                {
                    //Reset the travelled state
                    __pointerTravelled = false;
                }
            }
            else if (__inputModeNavigation)
            {
                //If the held element cannot be held then proactively reset the state variable
                if (not __BentoGetHoverableInternal(__holdElement, false)) __holdElement = BENTO_NO_ELEMENT;
                
                //Move the cursor and hover a new element (maybe)
                __BentoSetHoverFromNavigation(__hoverElement, __turboState.__outputX, __turboState.__outputY);
            }
            else //Some other input mode, perhaps `BENTO_MODE_UNKNOWN`
            {
                __holdElement = BENTO_NO_ELEMENT;
                __BentoSetHover(BENTO_NO_ELEMENT, false);
            }
        }
        
        //Always run Step events if we're the top layer
        __runStep = _isTopLayer;
        
        //Update elements of interest. `__runStep` is also set to `true` in here too depending on what
        //state elements are in
        array_resize(__updateElementArray, array_filter_ext(__updateElementArray, function(_elementVars)
        {
            return __BentoUpdateActiveElement(_elementVars);
        }));
        
        //Reset this mouse state after we update element state. This ensures we set the correct
        //state when releasing after dragging a scrollable container
        if (__primaryState == __BENTO_STATE_END)
        {
            __ClearScrollingElement();
        }
        
        if (__runStep)
        {
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
        __BentoAnimateScroll(_timeStep);
        __BentoEnsureOffset();
        
        //And we're done
        __BentoLayerTargetPop();
    }
    
    static __UpdatePartialOnCreate = function(_rootX, _rootY, _rootWidth, _rootHeight)
    {
        __BentoLayerTargetPush(self);
        
        //Initialize all the animations
        var _animPlayingArray = __animPlayingArray;
        var _i = array_length(_animPlayingArray)-1;
        repeat(array_length(_animPlayingArray))
        {
            with(_animPlayingArray[_i])
            {
                __animMethod(__attachedElement, 0, __animMetadata);
            }
            
            --_i;
        }
        
        __Ensure(_rootX, _rootY, _rootWidth, _rootHeight);
        
        __BentoLayerTargetPop();
    }
    
    static __Draw = function()
    {
        __BentoLayerTargetPush(self);
        
        __BentoEnsureTransforms();
        __BentoEnsureDrawOrder();
        
        if (__isTopLayer || __drawWhenBackgrounded)
        {
            var _drawOrder = __drawOrder;
            var _i = 0;
            repeat(array_length(_drawOrder))
            {
                _drawOrder[_i]();
                ++_i;
            }
        }
        
        //Draw the hovered element if it's not inside a scissor. If the hovered element is inside
        //a scissor then it'll be drawn by `__BentoScissorPop()`
        if (BentoExists(__hoverElement))
        {
            var _hoverElementVars = __hoverElement.BENTO_VARS;
            if (_hoverElementVars.__scissorParent == __rootElement.BENTO_VARS)
            {
                _hoverElementVars.__eventDrawHover();
            }
        }
        
        if (__isTopLayer)
        {
            //Draw the dragged item element, if we have one
            with(__carryItemElement)
            {
                //Store the current exposed position variables
                var _oldBentoLeft   = bentoLeft;
                var _oldBentoTop    = bentoTop;
                var _oldBentoRight  = bentoRight;
                var _oldBentoBottom = bentoBottom;
                var _oldBentoX      = bentoX;
                var _oldBentoY      = bentoY;
                
                //Calculate the vector from the old cursor position to the new cursor position
                if (other.__inputModePointer)
                {
                    var _dX = other.__pointerX - bentoX - BENTO_VARS.__carryPointerDX;
                    var _dY = other.__pointerY - bentoY - BENTO_VARS.__carryPointerDY;
                }
                else if (other.__inputModeNavigation)
                {
                    var _dX = other.__navigationLastX - 0.5*(_oldBentoLeft + _oldBentoRight);
                    var _dY = other.__navigationLastY - 0.5*(_oldBentoTop + _oldBentoBottom);
                }
                else
                {
                    var _dX = 0;
                    var _dY = 0;
                }
                
                //Move the exposed position to the wherever the cursor is
                bentoLeft   += _dX;
                bentoTop    += _dY;
                bentoRight  += _dX;
                bentoBottom += _dY;
                bentoX      += _dX;
                bentoY      += _dY;
                //Allow downstream code to set whatever variables it needs
                BENTO_VARS.__eventReposition();
                
                //Do the actual draw
                BENTO_VARS.__eventDrawDragged();
                
                //Restore the old position
                bentoLeft   = _oldBentoLeft;
                bentoTop    = _oldBentoTop;
                bentoRight  = _oldBentoRight;
                bentoBottom = _oldBentoBottom;
                bentoX      = _oldBentoX;
                bentoY      = _oldBentoY;
                BENTO_VARS.__eventReposition();
            }
        }
        
        __BentoLayerTargetPop();
    }
    
    static __DrawWireframe = function()
    {
        __BentoEnsureTransforms();
        
        var _func = function(_func, _elementVars, _baseAlpha)
        {
            //N.B. - This should match `__BentoEnsureDrawOrderInner()`
            
            with(_elementVars)
            {
                if (__disable) return;
                
                if (__transformMatrix != undefined)
                {
                    matrix_stack_push(__transformMatrix);
                    matrix_set(matrix_world, matrix_stack_top());
                }
                
                if (__visible)
                {
                    with(__attachedElement)
                    {
                        draw_set_alpha(_baseAlpha * ((BentoGetClickable() && BentoCursorGetHover())? 0.2 : 0.1));
                        draw_rectangle(bentoLeft, bentoTop, bentoRight, bentoBottom, false);
                        draw_set_alpha(_baseAlpha);
                        
                        draw_rectangle(bentoLeft, bentoTop, bentoRight, bentoBottom, true);
                        BentoDrawCross(bentoX, bentoY);
                    }
                }
                
                if (__scissorEnabled)
                {
                    __BentoDrawScissorPushFromVars();
                }
                
                //Add children created inside the parent to the Draw order
                var _array = __childDrawArray;
                var _i = 0;
                repeat(array_length(_array))
                {
                    _func(_func, _array[_i], _baseAlpha);
                    ++_i;
                }
                
                if (__scissorEnabled)
                {
                    __BentoDrawScissorPop();
                }
                
                BentoScrollbarDrawPlaceholder(BentoScrollbarGetHoriData(__attachedElement), __attachedElement);
                BentoScrollbarDrawPlaceholder(BentoScrollbarGetVertData(__attachedElement), __attachedElement);
                
                if (__transformMatrix != undefined)
                {
                    matrix_stack_pop();
                    matrix_set(matrix_world, matrix_stack_top());
                }
            }
        }
        
        var _oldAlpha = draw_get_alpha();
        _func(_func, __rootElement.BENTO_VARS, _oldAlpha);
        draw_set_alpha(_oldAlpha);
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
            if (__inputModeNavigation) return _focusTop;
            
            var _focusType = _focusTop.BENTO_VARS.__focusType;
            
            if ((_focusType == BENTO_FOCUS_POINTER_CONSTRAIN)
            ||  (_focusType == BENTO_FOCUS_POINTER_CANCEL_ON_CLICK)
            ||  (_focusType == BENTO_FOCUS_POINTER_DESTROY_ON_CLICK))
            {
                return _focusTop;
            }
        }
        
        return __rootElement;
    }
    
    static __CheckUnblocked = function()
    {
        if (__animAnyBlocking)
        {
            __animAnyBlocking = false;
            
            if (is_callable(__animUnblockedCallback))
            {
                __animUnblockedCallback(__name, __animUnblockedMetadata);
                
                //Reset values, including the metadata in case that should be GC'd
                if (not __animUnblockedPersist)
                {
                    __animUnblockedCallback = undefined;
                    __animUnblockedMetadata = undefined;
                    __animUnblockedPersist  = false;
                }
            }
        }
    }
}