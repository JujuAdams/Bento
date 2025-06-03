// Feather disable all

/// @param environment
/// @param name

function __GuiClassLayer(_environment, _name) constructor
{
    static _system = __GuiSystem();
    
    __environment = _environment;
    __name        = _name;
    
    ////////
    // Gemeral state
    ////////
    
    __frozen = false;
    __rootElement = GUI_NO_ELEMENT;
    
    ////////
    // Set up a default navigation mode for convenience
    ////////
    
    if ((os_type == os_switch) || (os_type == os_ps4) || (os_type == os_ps5) || (os_type == os_xboxone) || (os_type == os_xboxseriesxs))
    {
        __navMode = GUI_MODE_GAMEPAD;
    }
    else if ((os_type == os_android) || (os_type == os_ios) || (os_type == os_tvos))
    {
        __navMode = GUI_MODE_TOUCH;
    }
    else if ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))
    {
        __navMode = GUI_DESKTOP_DEFAULT_NAV_MODE;
    }
    else
    {
        __navMode = GUI_MODE_MOUSE;
    }
    
    //Explicitly using a mouse or touch input
    __navPointer = ((__navMode == GUI_MODE_MOUSE) || (__navMode == GUI_MODE_TOUCH));
    
    //Explicitly using a keyboard or gamepad
    __navDirectional = ((__navMode == GUI_MODE_KEYBOARD) || (__navMode == GUI_MODE_GAMEPAD));
    
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
    
    __directionalStateX = new __GuiClassDirectionalState();
    __directionalStateY = new __GuiClassDirectionalState();
    
    __hotkeyStateMap    = ds_map_create();
    __hotkeyConsumedMap = ds_map_create();
    
    ////////
    // Update tracking
    ////////
    
    __layoutOrder = [];
    __layoutDirty = true;
    
    __stepOrder = [];
    __stepDirty = true;
    
    __hoverableOrder = [];
    __hoverableDirty = true;
    __hoverableRegenCount = 0;
    
    __drawOrder = [];
    __drawDirty = true;
    
    __dirtyChildOrderArray   = [];
    __dirtyScrollLimitsArray = [];
    __dirtyScrollPosArray    = [];
    __dirtyTransformsArray   = [];
    __scrollAnimatingArray   = [];
    
    __overElement     = GUI_NO_ELEMENT;
    __overElementSoft = GUI_NO_ELEMENT;
    __primaryState    = __GUI_OFF;
    __primaryConsumed = false;
    __holdElement     = GUI_NO_ELEMENT;
    
    __updateElementArray = [];
    
    __nameMap = ds_map_create();
    
    __focusStack = [];
    __focusTop   = undefined;
    
    
    
    
    
    static __Destroy = function()
    {
        instance_destroy(__rootElement);
        __environment.__RemoveLayer(self);
    }
    
    static __Update = function(_rootWidth, _rootHeight, _ensureOnly)
    {
        var _environment = __environment;
        
        __GuiLayerTargetPush(self);
        
        if (not _ensureOnly)
        {
            ///////
            // Input handling
            ///////
            
            //Update mouse (pointer) input
            __mousePrevX = __mouseX;
            __mousePrevY = __mouseY;
            
            __mouseHold = _environment.__envMouseHold;
            
            if ((__navMode == GUI_MODE_TOUCH) && (not __mouseHold))
            {
                __mouseX = -__GUI_VERY_LARGE;
                __mouseY = -__GUI_VERY_LARGE;
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
                
                var _state = (__hotkeyStateMap[? _key] ?? __GUI_OFF) >> 1;
                if (_globalHotkeyInputMap[? _key] ?? false) _state |= __GUI_START;
                __hotkeyStateMap[? _key] = _state;
                
                if (_state == __GUI_START)
                {
                    __hotkeyConsumedMap[? _key] = false;
                }
                
                ++_i;
            }
        }
        
        ///////
        // Layout and step order
        ///////
        
        //Ensure our root instance is the same size as the overall GUI space
        GuiLayoutSetSize(_rootWidth, _rootHeight, __rootElement);
        
        //Keep our layout and step order updated as necessary. Updating the layer and step order here
        //catches any weird stuff the dev might've done between calls to `GuiSystemStep()`
        __GuiEnsureLayout();
        __GuiEnsureStepOrder();
        __GuiEnsureHoverableOrder();
        
        if (not _ensureOnly)
        {
            ///////
            // Navigation
            ///////
            
            __GuiScissorReset();
            
            if (not __frozen)
            {
                __primaryState = (__primaryState >> 1);
                
                if (__navPointer)
                {
                    //Update the primary button state based on mouse input
                    if (__mouseHold) __primaryState |= __GUI_START;
                    
                    //Start hovering an element if we're not currently holding an element
                    if (not GuiGetHoverable(__holdElement, false))
                    {
                        __GuiStartOver(__GuiGetPointerOver(__mouseX, __mouseY));
                    }
                    
                    //Detect clicking off of a pop-up
                    if ((__primaryState == __GUI_START)
                    &&  GuiExists(__focusTop)
                    &&  (__focusTop.GUI_VARS.__focusType == GUI_FOCUS_POINTER_CANCEL_ON_CLICK)
                    &&  (__focusTop != __overElement) //Don't destroy a pop-up if we're hovering directly over it
                    &&  (not GuiIsAncestor(__focusTop, __overElement))) //Also don't destroy if we're hovering over a child of the pop-up
                    {
                        GuiDestroy(__focusTop);
                        __primaryState = __GUI_OFF;
                    }
                    
                    if (__primaryState == __GUI_START)
                    {
                        //Set some variable state if we've clicked the mouse
                        __mousePressX = __mouseX;
                        __mousePressY = __mouseY;
                        
                        __mousePrevX = __mouseX;
                        __mousePrevY = __mouseY;
                    }
                    else if (__primaryState == __GUI_END)
                    {
                        //And reset the mouse state when we release
                        __mousePressX = undefined;
                        __mousePressY = undefined;
                    }
                }
                else if (__navDirectional)
                {
                    //Update the primary button state based on directional input
                    if (__directionalHold) __primaryState |= __GUI_START;
                    
                    //If the held element cannot be held then proactively reset the state variable
                    if (not GuiGetHoverable(__holdElement, false)) __holdElement = GUI_NO_ELEMENT;
                    
                    //Move the cursor and hover a new element (maybe)
                    __GuiStartOver(__GuiGetDirectionalOver(__overElement, __directionalStateX.__output, __directionalStateY.__output));
                }
                else //Some other navigation mode, perhaps `GUI_MODE_UNKNOWN`
                {
                    __holdElement = GUI_NO_ELEMENT;
                    __GuiStartOver(GUI_NO_ELEMENT);
                }
                
                if (__primaryState == __GUI_START)
                {
                    __primaryConsumed = false;
                }
                
                __GuiUpdateElementState();
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
        __GuiEnsureLayout();
        __GuiEnsureStepOrder();
        __GuiEnsureScrollLimits();
        __GuiEnsureScroll();
        
        //And we're done
        __GuiLayerTargetPop();
    }
    
    static __Draw = function()
    {
        __GuiLayerTargetPush(self);
        
        __GuiEnsureDrawOrder();
        __GuiEnsureTransforms();
        
        var _drawOrder = __drawOrder;
        var _i = 0;
        repeat(array_length(_drawOrder))
        {
            _drawOrder[_i]();
            ++_i;
        }
        
        __GuiLayerTargetPop();
    }
    
    static __GetFocusRoot = function()
    {
        //Determine where to start the Step order processing
        //FIXME - Walk up focus stack to find a pointer constrain element rather than only looking at the top one
        var _focusTop = __focusTop;
        if (GuiExists(_focusTop) && (__navDirectional || (_focusTop.GUI_VARS.__focusType == GUI_FOCUS_POINTER_CONSTRAIN)))
        {
            return _focusTop;
        }
        else
        {
            return __rootElement;
        }
    }
}