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
    
    __animPlayingArray = [];
    __animPlayingMap   = ds_map_create();
    __animBlockingMap  = ds_map_create();
    __animAnyBlocking  = false;
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
    
    __mouseX      = 0;
    __mouseY      = 0;
    __mouseHold   = false;
    __mousePrevX  = 0;
    __mousePrevY  = 0;
    __mousePressX = undefined;
    __mousePressY = undefined;
    
    __directionalDX    = 0;
    __directionalDY    = 0;
    __directionalHold  = false;
    __directionalLastX = 0;
    __directionalLastY = 0;
    
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
    
    __hoverElement     = BENTO_NO_ELEMENT;
    __hoverElementSoft = BENTO_NO_ELEMENT;
    __primaryState     = __BENTO_OFF;
    __primaryConsumed  = false;
    __holdElement      = BENTO_NO_ELEMENT;
    __dndItemElement   = BENTO_NO_ELEMENT;
    
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
    
    static __SetHoverElement = function(_hoverElement)
    {
        __hoverElement = _hoverElement;
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
                //Reset mouse variables
                __mouseHold = false;
                
                __directionalLastX = __mouseX;
                __directionalLastY = __mouseY;
                
                __mousePrevX = __mouseX;
                __mousePrevY = __mouseY;
            }
            
            __navPointer     = false;
            __navDirectional = true;
            
            __mousePressX = undefined;
            __mousePressY = undefined;
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
        }
        else
        {
            //Some undefined input mode, perhaps `BENTO_MODE_UNKNOWN`
            __navPointer     = false;
            __navDirectional = false;
            
            __mousePressX = undefined;
            __mousePressY = undefined;
        }
        
        __navMode = _newMode;
    }
    
    static __Update = function(_rootX, _rootY, _rootWidth, _rootHeight, _isTopLayer, _timeStep)
    {
        static _hotkeyArray = [];
        
        var _environment = __environment;
        
        __BentoLayerTargetPush(self);
        
        ///////
        // Animations
        ///////
        
        var _i = array_length(__animPlayingArray)-1;
        repeat(array_length(__animPlayingArray))
        {
            with(__animPlayingArray[_i])
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
            ///////
            // Input handling
            ///////
            
            __UpdateInputMode();
            
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
            
            __turboState.__Update(__directionalDX, __directionalDY, _system.__frame);
            
            //Update hotkey input
            var _globalHotkeyInputMap = __environment.__envHotkeyInputMap;
            ds_map_keys_to_array(_globalHotkeyInputMap, _hotkeyArray);
            var _i = 0;
            repeat(array_length(_hotkeyArray))
            {
                var _key = _hotkeyArray[_i];
                
                var _state = (__hotkeyStateMap[? _key] ?? __BENTO_OFF) >> 1;
                if (_globalHotkeyInputMap[? _key] ?? false) _state |= __BENTO_START;
                __hotkeyStateMap[? _key] = _state;
                
                if (_state == __BENTO_START)
                {
                    __hotkeyConsumedMap[? _key] = false;
                }
                
                ++_i;
            }
            
            array_resize(_hotkeyArray, 0);
            
        }
        
        //Reset the drag & drop element if it has been destroyed for some reason or its channel has
        //been set to `undefined`. We also reset if this layer isn't the top layer
        //TODO - Does this need to use a hoverability check?
        if (__dndItemElement !=  BENTO_NO_ELEMENT)
        {
            if ((not _isTopLayer) || (not BentoExists(__dndItemElement)) || (__dndItemElement.BENTO_VARS.__dndItemChannel == undefined))
            {
                __dndItemElement = BENTO_NO_ELEMENT;
                __dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            }
        }
        
        ///////
        // Layout and step order
        ///////
        
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
        
        if (_isTopLayer)
        {
            ///////
            // Navigation
            ///////
            
            __BentoScissorReset();
            
            __primaryState = (__primaryState >> 1);
            
            if (__navPointer)
            {
                //Update the primary button state based on mouse input
                if (__mouseHold) __primaryState |= __BENTO_START;
                
                //Verify that the currently held element is still held
                if (not __BentoGetHoverableInternal(__holdElement, false)) __holdElement = BENTO_NO_ELEMENT;
                
                //Try to hover a new element (maybe)
                if ((not __mouseHold)
                ||  (__mouseHold && (__dndItemElement != BENTO_NO_ELEMENT))
                ||  ((__navMode == BENTO_MODE_TOUCH) && (__primaryState == __BENTO_START)))
                {
                    __BentoSetHoverFromPointer(__mouseX, __mouseY);
                }
                
                if (__primaryState == __BENTO_START) //On primary press
                {
                    if (__environment.__textHandler != undefined) //Detect clicking off of an input box
                    {
                        if ((__environment.__textElement != __hoverElement)
                        &&  (not BentoIsAncestor(__environment.__textElement, __hoverElement))
                        &&  __environment.__textHandler.__cancelOnClick)
                        {
                            __environment.__textHandler.__Terminate(BENTO_TEXT_ABORT);
                            __SetHoverElement(BENTO_NO_ELEMENT);
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
                                __SetHoverElement(BENTO_NO_ELEMENT);
                            }
                            else if (_focusType == BENTO_FOCUS_POINTER_DESTROY_ON_CLICK)
                            {
                                BentoDestroy(__focusTop);
                                __SetHoverElement(BENTO_NO_ELEMENT);
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
                __BentoSetHoverFromDirectional(__hoverElement, __turboState.__outputX, __turboState.__outputY);
            }
            else //Some other input mode, perhaps `BENTO_MODE_UNKNOWN`
            {
                __holdElement = BENTO_NO_ELEMENT;
                __BentoSetHover(BENTO_NO_ELEMENT, false);
            }
            
            if (__primaryState == __BENTO_START)
            {
                __primaryConsumed = false;
            }
            
            __BentoUpdateElementState();
            
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
        
        if (BentoExists(__hoverElement))
        {
            var _hoverElementVars = __hoverElement.BENTO_VARS;
            if (_hoverElementVars.__scissorParent == __rootElement.BENTO_VARS)
            {
                _hoverElementVars.__eventDrawHover();
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
            if (_focusType == BENTO_FOCUS_POINTER_CONSTRAIN) return _focusTop;
            
            if (BENTO_FOCUS_BLOCKS_POINTER_HOVER
            &&  ((_focusType == BENTO_FOCUS_POINTER_CANCEL_ON_CLICK) || (_focusType == BENTO_FOCUS_POINTER_CANCEL_ON_CLICK)))
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