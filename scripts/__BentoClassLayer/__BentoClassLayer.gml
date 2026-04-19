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
    
    __animPlayingArray      = [];
    __animPlayingMap        = ds_map_create();
    __animBlockingMap       = ds_map_create();
    __animAnyBlocking       = false;
    __animUnblockedCallback = undefined;
    __animUnblockedMetadata = undefined;
    __animUnblockedPersist  = false;
    
    //Set starting input mode from the environment
    __navMode = __environment.__envNavMode;
    
    //Explicitly using a mouse or touch input
    __navPointer = ((__navMode == BENTO_MODE_MOUSE) || (__navMode == BENTO_MODE_TOUCH));
    
    //Explicitly using a keyboard or gamepad
    __navDirectional = ((__navMode == BENTO_MODE_KEYBOARD) || (__navMode == BENTO_MODE_GAMEPAD));
    
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
    
    __directionalDX           = 0;
    __directionalDY           = 0;
    __directionalPrimaryState = __BENTO_STATE_OFF;
    __directionalLastX        = 0;
    __directionalLastY        = 0;
    
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
    
    __dndNextItemElement = BENTO_NO_ELEMENT;
    __dndItemElement     = BENTO_NO_ELEMENT;
    
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
        if (BentoExists(__dndItemElement))
        {
            __dndItemElement.BENTO_VARS.__dndTargetElement = BENTO_NO_ELEMENT;
        }
    }
    
    static __SetBackgroundedState = function()
    {
        __isTopLayer = false;
        
        __hoverElementStored = BentoExists(__hoverElement)? weak_ref_create(__hoverElement) : undefined;
        
        __pointerX = -__BENTO_VERY_LARGE;
        __pointerY = -__BENTO_VERY_LARGE;
        
        __directionalDX = 0;
        __directionalDY = 0;
        
        __pointerTravelled = false;
        
        __pointerScrolled = false;
        __pointerScrollingElement = BENTO_NO_ELEMENT;
        
        //If this layer has the current text handler then abort its use
        if ((__environment.__textElement != undefined) && (__environment.__textElement.BENTO_VARS.__layer == self))
        {
            __environment.__textHandler.__Terminate(BENTO_TEXT_ABORT);
        }
        
        __ClearHoverElement();
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
        if (__dndItemElement != BENTO_NO_ELEMENT)
        {
            __dndItemElement = BENTO_NO_ELEMENT;
            
            if (BentoExists(__dndItemElement))
            {
                __dndItemElement.BENTO_VARS.__dndTargetElement = BENTO_NO_ELEMENT;
            }
            
            __dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
        }
    }
    
    static __UpdateInputMode = function()
    {
        var _newMode = __environment.__envNavMode;
        if (__navMode == _newMode) return;
        
        //Changing input mode may change whether elements execute their step event and are hoverable
        //when focused
        __dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
        
        if ((_newMode == BENTO_MODE_KEYBOARD) || (_newMode == BENTO_MODE_GAMEPAD))
        {
            if (__navPointer)
            {
                //Reset mouse variables if we've swapped mouse <-> touch
                __directionalLastX = __pointerX;
                __directionalLastY = __pointerY;
                
                __pointerPrevX = __pointerX;
                __pointerPrevY = __pointerY;
            }
            
            __navPointer     = false;
            __navDirectional = true;
        }
        else if ((_newMode == BENTO_MODE_MOUSE) || (_newMode == BENTO_MODE_TOUCH))
        {
            //Find any focused element that needs to be closed if we've swapped to a pointer mode
            var _focusStack = __focusStack;
            var _i = 0;
            repeat(array_length(_focusStack))
            {
                var _element = _focusStack[_i];
                if (_element.BENTO_VARS.__focusType == BENTO_FOCUS_POINTER_CANCEL_ALWAYS)
                {
                    BentoFocusClose(_element);
                    break;
                }
                
                ++_i;
            }
            
            __navPointer     = true;
            __navDirectional = false;
            
            __pointerPressX = __pointerX;
            __pointerPressY = __pointerY;
            
            __directionalDX = 0;
            __directionalDY = 0;
            
            __turboState.__Update(0, 0, _system.__frame);
        }
        else
        {
            //Some undefined input mode, perhaps `BENTO_MODE_UNKNOWN`
            __navPointer     = false;
            __navDirectional = false;
        }
        
        __dndNextItemElement = BENTO_NO_ELEMENT;
        
        if (BentoExists(__dndItemElement))
        {
            __dndItemElement.BENTO_VARS.__dndItemContinuous = true;
        }
        
        __pointerTravelled = false;
        
        __primaryConsumed = false;
        
        __pointerScrolled = false;
        __pointerScrollingElement = BENTO_NO_ELEMENT;
        
        __navMode = _newMode;
    }
    
    static __UpdateInputStateAsTopLevel = function()
    {
        //A full input state update. Player input is collected and passed into layer state
        
        static _hotkeyArray = [];
        
        var _environment = __environment;
        
        if (__navPointer)
        {
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
            
            //Update mouse (pointer) input
            __pointerPrevX = __pointerX;
            __pointerPrevY = __pointerY;
            
            if (__pointerPrimaryState == __BENTO_STATE_START)
            {
                //Set some variable state if we've clicked the mouse
                __pointerPressX = __pointerX;
                __pointerPressY = __pointerY;
            }
            
            if ((__navMode == BENTO_MODE_TOUCH) && (not (__pointerPrimaryState & __BENTO_STATE_START)))
            {
                __pointerX = -__BENTO_VERY_LARGE;
                __pointerY = -__BENTO_VERY_LARGE;
            }
            else
            {
                __pointerX = _environment.__envMouseX;
                __pointerY = _environment.__envMouseY;
                
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
        
        if (__navDirectional)
        {
            var _prevPrimaryState = __directionalPrimaryState;
            var _envPrimaryState = _environment.__envDirectionalState;
            
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
                __directionalPrimaryState = __BENTO_STATE_START;
            }
            else if ((_prevPrimaryState == __BENTO_STATE_OFF) && (_envPrimaryState == __BENTO_STATE_START))
            {
                //Only allow us to start pressing when the environment is pressed
                __directionalPrimaryState = __BENTO_STATE_START;
            }
            else if (_prevPrimaryState & __BENTO_STATE_START) && (_envPrimaryState & __BENTO_STATE_START)
            {
                //Sustain primary hold
                __directionalPrimaryState = __BENTO_STATE_ON;
            }
            else
            {
                //Release primary
                __directionalPrimaryState = _prevPrimaryState >> 1;
            }
            
            //Update directional input
            __directionalDX = _environment.__envDirectionalDX;
            __directionalDY = _environment.__envDirectionalDY;
            
            __turboState.__Update(__directionalDX, __directionalDY, _system.__frame);
        }
        else
        {
            __directionalPrimaryState = __directionalPrimaryState >> 1;
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
        __directionalPrimaryState = __directionalPrimaryState >> 1;
        
        __turboState.__Update(0, 0, _system.__frame);
        
        //Update hotkey input
        var _globalHotkeyInputMap = _environment.__envHotkeyInputMap;
        ds_map_keys_to_array(_globalHotkeyInputMap, _hotkeyArray);
        var _i = 0;
        repeat(array_length(_hotkeyArray))
        {
            var _key = _hotkeyArray[_i];
            
            __hotkeyStateMap[? _key] = (__hotkeyStateMap[? _key] ?? __BENTO_STATE_OFF) >> 1;
            //TODO - Add "click" behaviour so the develpper can filter out release events that are out of scope
            
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
        
        if (BentoExists(__dndNextItemElement))
        {
            //Incoming new item element
            
            if (__dndNextItemElement != __dndItemElement)
            {
                //The item element has changed
                
                if (BentoExists(__dndItemElement))
                {
                    //To avoid bugs, reset the target for the existing item element
                    __dndItemElement.BENTO_VARS.__dndTargetElement = BENTO_NO_ELEMENT;
                }
                
                __dndItemElement = __dndNextItemElement;
                
                with(__dndItemElement.BENTO_VARS)
                {
                    __dndPointerDX = other.__pointerPressX - __attachedElement.bentoX;
                    __dndPointerDY = other.__pointerPressY - __attachedElement.bentoY;
                    
                    __dndTargetElement = BENTO_NO_ELEMENT;
                    __BentoSetAsUpdating();
                }
                
                __dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            }
            
            __dndNextItemElement = BENTO_NO_ELEMENT;
        }
        else if (__dndItemElement != BENTO_NO_ELEMENT)
        {
            //No new item element
            
            if ((not BentoExists(__dndItemElement)) || __dndItemElement.BENTO_VARS.__dndItemContinuous)
            {
                //If we have no new drag & drop item element and the current item is continuous then we've lost the item
                __dndItemElement = BENTO_NO_ELEMENT;
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
            if ((__dndItemElement != BENTO_NO_ELEMENT)
            &&  ((not __BentoGetHoverableInternal(__dndItemElement, false)) || (__dndItemElement.BENTO_VARS.__dndItemChannel == undefined)))
            {
                __ClearDraggedItem();
            }
        }
        else
        {
            __UpdateInputStateAsBackgrounded();
        }
        
        if (__navPointer)
        {
            //Update the primary button state based on mouse input
            __primaryState = __pointerPrimaryState;
        }
        else if (__navDirectional)
        {
            //Update the primary button state based on directional input
            __primaryState = __directionalPrimaryState;
        }
        else
        {
            __primaryState = __primaryState << 1;
        }
        
        if (_isTopLayer)
        {
            ///////
            // Navigation
            ///////
            
            __BentoScissorReset();
            
            if (__navPointer)
            {
                if ((__pointerPrimaryState & __BENTO_STATE_START) && BentoExists(__pointerScrollingElement))
                {
                    //Handle scrolling as a priority. This will block out hovering new elements
                    if (__dndItemElement == BENTO_NO_ELEMENT)
                    {
                        BentoScrollAddPos(__pointerX - __pointerPrevX, __pointerY - __pointerPrevY, infinity, __pointerScrollingElement);
                    }
                    else
                    {
                        var _pointerScrollingElement = __pointerScrollingElement;
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
                        
                        BentoScrollAddPos(_dX, _dY, infinity, __pointerScrollingElement);
                    }
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
                    ||  (__dndItemElement != BENTO_NO_ELEMENT) //Hover if we have a drag & drop item
                    ||  ((__navMode == BENTO_MODE_TOUCH) && (__pointerPrimaryState == __BENTO_STATE_START))) //Hover if we're in touch mode and we just pressed
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
                }
                
                if (__pointerPrimaryState == __BENTO_STATE_END)
                {
                    //Reset the travelled state
                    __pointerTravelled = false;
                }
            }
            else if (__navDirectional)
            {
                //If the held element cannot be held then proactively reset the state variable
                if (not __BentoGetHoverableInternal(__holdElement, false)) __holdElement = BENTO_NO_ELEMENT;
                
                //Move the cursor and hover a new element (maybe)
                __BentoSetHoverFromDirectional(__hoverElement, __turboState.__outputX, __turboState.__outputY);
            }
            else //Some other input mode, perhaps `BENTO_MODE_UNKNOWN`
            {
                __holdElement = BENTO_NO_ELEMENT;
                __BentoSetHover(BENTO_NO_ELEMENT, false);
            }
        }
        
        //Run an update so long as we are the top layer or we have elements of interest on this layer.
        //Because we force player input to "null" when a layer is backgrounded, elements will become
        //inert one or two frames after a layer is backgrounded
        if (_isTopLayer || (array_length(__updateElementArray) > 0))
        {
            //Update elements of interest
            __BentoUpdateElementState();
            
            //Reset this mouse state after we update element state. This ensures we set the correct
            //state when releasing after dragging a scrollable container
            if (__primaryState == __BENTO_STATE_END)
            {
                __pointerScrolled = false;
                __pointerScrollingElement = BENTO_NO_ELEMENT;
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
        
        var _drawOrder = __drawOrder;
        var _i = 0;
        repeat(array_length(_drawOrder))
        {
            _drawOrder[_i]();
            ++_i;
        }
        
        if (__isTopLayer)
        {
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
            
            //Draw the dragged item element, if we have one
            with(__dndItemElement)
            {
                //Store the current exposed position variables
                var _oldBentoLeft   = bentoLeft;
                var _oldBentoTop    = bentoTop;
                var _oldBentoRight  = bentoRight;
                var _oldBentoBottom = bentoBottom;
                var _oldBentoX      = bentoX;
                var _oldBentoY      = bentoY;
                
                //Calculate the vector from the old cursor position to the new cursor position
                if (other.__navPointer)
                {
                    var _dX = other.__pointerX - bentoX - BENTO_VARS.__dndPointerDX;
                    var _dY = other.__pointerY - bentoY - BENTO_VARS.__dndPointerDY;
                }
                else if (other.__navDirectional)
                {
                    var _dX = other.__directionalLastX - 0.5*(_oldBentoLeft + _oldBentoRight);
                    var _dY = other.__directionalLastY - 0.5*(_oldBentoTop + _oldBentoBottom);
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
                    __BentoScissorPushFromVars();
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
                    __BentoScissorPop();
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
            if (__navDirectional) return _focusTop;
            
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