// Feather disable all

function __GuiClassEnvironment() constructor
{
    static _system               = __GuiSystem();
    static _globalHotkeyInputMap = _system.__globalHotkeyInputMap;
    static _globalHotkeyArray    = _system.__globalHotkeyArray;
    
    ////////
    // Gemeral state
    ////////
    
    __frozen = false;
    __rootInstance = noone;
    
    ////////
    // Set up a default navigation mode for convenience
    ////////
    
    if ((os_type == os_switch) || (os_type == os_ps4) || (os_type == os_ps5) || (os_type == os_xboxone) || (os_type == os_xboxseriesxs))
    {
        __navMode = GUI_NAV_DIRECTIONAL;
    }
    else if ((os_type == os_android) || (os_type == os_ios) || (os_type == os_tvos))
    {
        __navMode = GUI_NAV_TOUCH;
    }
    else if ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))
    {
        __navMode = GUI_DESKTOP_DEFAULT_TO_DIRECTIONAL? GUI_NAV_DIRECTIONAL : GUI_NAV_MOUSE;
    }
    else
    {
        __navMode = GUI_NAV_MOUSE;
    }
    
    __navPointer = ((__navMode == GUI_NAV_MOUSE) || (__navMode == GUI_NAV_TOUCH));
    
    ////////
    // Input state
    ////////
    
    __mouseX        = 0;
    __mouseY        = 0;
    __mousePrevHold = false;
    __mouseHold     = false;
    __mousePrevX    = 0;
    __mousePrevY    = 0;
    __mousePressX   = undefined;
    __mousePressY   = undefined;
    
    __directionalDX       = 0;
    __directionalDY       = 0;
    __directionalPrevHold = false;
    __directionalHold     = false;
    __directionalLastX    = 0;
    __directionalLastY    = 0;
    
    __directionalStateX = new __GuiClassDirectionalState();
    __directionalStateY = new __GuiClassDirectionalState();
    
    __hotkeyPrevMap     = ds_map_create();
    __hotkeyStateMap    = ds_map_create();
    __hotkeyConsumedMap = ds_map_create();
    
    ////////
    // Update tracking
    ////////
    
    __layoutOrder = [];
    __layoutDirty = true;
    
    __transformAndScrollDirtyArray = [];
    __scrollDirtyArray = [];
    
    __stepRootStack = [];
    __stepOrder     = [];
    __stepDirty     = true;
    
    __drawOrder = [];
    __drawDirty = true;
    
    __dirtyChildOrderArray = [];
    
    __dirtyScrollLimitsArray = [];
    
    __overInstance     = noone;
    __overInstanceSoft = noone;
    __holdState        = GUI_OFF;
    __holdInstance     = noone;
    __popUpRoot        = noone;
    
    __primaryConsumed = false;
    
    __updateInstanceArray = [];
    
    __nameMap = ds_map_create();
    
    __tabDict = {};
    
    
    
    
    
    static __Update = function(_rootWidth, _rootHeight)
    {
        var _prevEnvironment = _system.__environmentCurrent;
        _system.__environmentCurrent = self;
        
        GuiLayoutSetSize(_rootWidth, _rootHeight, __rootInstance);
        
        //Update mouse (pointer) input
        __mousePrevHold = __mouseHold;
        __mouseHold     = _system.__globalMouseHold;
        
        if ((__navMode == GUI_NAV_TOUCH) && (not __mouseHold))
        {
            var _mouseX = -__GUI_VERY_LARGE;
            var _mouseY = -__GUI_VERY_LARGE;
        }
        else
        {
            var _mouseX = _system.__globalMouseX;
            var _mouseY = _system.__globalMouseY;
        }
        
        __mousePrevX = __mouseX;
        __mousePrevY = __mouseY;
        
        __mouseX = _mouseX;
        __mouseY = _mouseY;
        
        if (__mouseHold && (not __mousePrevHold))
        {
            __mousePressX = _mouseX;
            __mousePressY = _mouseY;
            
            __mousePrevX = _mouseX;
            __mousePrevY = _mouseY;
        }
        
        //Update directional input
        __directionalPrevHold = __directionalHold;
        __directionalHold     = _system.__globalDirectionalHold;
        
        __directionalDX = _system.__globalDirectionalDX;
        __directionalDY = _system.__globalDirectionalDY;
        
        __directionalStateX.__Update(__directionalDX, _system.__frame);
        __directionalStateY.__Update(__directionalDY, _system.__frame);
        
        //Update hotkey input
        var _i = 0;
        repeat(array_length(_globalHotkeyArray))
        {
            var _key = _globalHotkeyArray[_i];
            
            var _prev  = __hotkeyPrevMap[? _key] ?? false;
            var _input = _globalHotkeyInputMap[? _key] ?? false;
            
            if (_input && (not _prev))
            {
                __hotkeyConsumedMap[? _key] = false;
            }
            
            __hotkeyPrevMap[?  _key] = _input;
            __hotkeyStateMap[? _key] = _prev? (_input? GUI_HOLD : GUI_RELEASE) : (_input? GUI_PRESS : GUI_OFF);
            
            ++_i;
        }
        
        __GuiEnsureLayout();
        __GuiEnsureStepOrder();
        
        __GuiScissorReset();
        
        if (not __frozen)
        {
            if (not __navPointer) //Not using a pointer
            {
                if (__directionalPrevHold)
                {
                    __holdState = (__directionalHold? GUI_HOLD : GUI_RELEASE);
                }
                else
                {
                    __holdState = (__directionalHold? GUI_PRESS : GUI_OFF);
                }
                
                if (not GuiGetHoverable(__holdInstance, false)) __holdInstance = noone;
                __GuiNavStartOver(__GuiGetDirectionalOver(__overInstance, __directionalStateX.__output, __directionalStateY.__output));
            }
            else //Using a pointer
            {
                if (__mousePrevHold)
                {
                    __holdState = (__mouseHold? GUI_HOLD : GUI_RELEASE);
                }
                else
                {
                    __holdState = (__mouseHold? GUI_PRESS : GUI_OFF);
                }
                
                if (not GuiGetHoverable(__holdInstance, false)) __holdInstance = noone;
                __GuiNavStartOver(__GuiGetPointerOver(__mouseX, __mouseY));
                
                //Detect clicking off of a pop-up
                if ((__holdState == GUI_PRESS)
                &&  GUI_EXISTS(__popUpRoot)
                &&  (__popUpRoot != __overInstance) //Don't destroy a pop-up if we're hovering directly over it
                &&  (not GuiIsAncestor(__popUpRoot, __overInstance))) //Also don't destroy if we're hovering over a child of the pop-up
                {
                    GuiDestroy(__popUpRoot);
                    if (not GUI_POP_UP_CLICK_THROUGH) __holdState = GUI_OFF;
                }
            }
            
            if (__holdState == GUI_PRESS)
            {
                __primaryConsumed = false;
            }
            
            __GuiUpdateInstanceState();
        }
        
        //Surprise! We go in reverse
        var _stepOrder = __stepOrder;
        var _i = array_length(_stepOrder)-1;
        repeat(array_length(_stepOrder))
        {
            _stepOrder[_i]();
            --_i;
        }
        
        __GuiEnsureScrollLimits();
        __GuiEnsureTransformAndScroll();
        
        _system.__environmentCurrent = _prevEnvironment;
    }
    
    static __Draw = function()
    {
        __GuiEnsureDrawOrder();
        
        var _drawOrder = __drawOrder;
        var _i = 0;
        repeat(array_length(_drawOrder))
        {
            _drawOrder[_i]();
            ++_i;
        }
    }
}