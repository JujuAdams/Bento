// Feather disable all

/// Updates the GUI system based on the navigation mode (`GuiNavSetMode()`) and user input:
/// 
/// - `GuiInputPointer()`
/// - `GuiInputDirectional()`
/// - `GuiInputHotkey()`

function GuiStep()
{
    static _system = __GuiSystem();
    
    with(GUI_ROOT)
    {
        GuiLayoutSetSize(room_width, room_height);
    }
    
    __GuiEnsureLayout();
    __GuiEnsureAnimAndScroll();
    
    __GuiScissorReset();
    var _stepOrder = __GuiEnsureStepOrder();
    
    with(_system)
    {
        ++__frame;
        
        // ulate directional x/y deltas
        __directionalStateX.__Update(__directionalDX, __frame);
        __directionalStateY.__Update(__directionalDY, __frame);
        
        if (not GuiFreezeGetAny())
        {
            var _i = 0;
            repeat(array_length(__hotkeyArray))
            {
                var _key = __hotkeyArray[_i];
                
                var _prev  = __hotkeyPrevMap[?  _key] ?? false;
                var _input = __hotkeyInputMap[? _key] ?? false;
                
                if (_input && (not _prev))
                {
                    __hotkeyConsumedMap[? _key] = false;
                }
                
                __hotkeyPrevMap[?  _key] = _input;
                __hotkeyStateMap[? _key] = _prev? (_input? GUI_HOLD : GUI_RELEASE) : (_input? GUI_PRESS : GUI_OFF);
                
                ++_i;
            }
            
            if (not __navPointer) //Not using a pointer
            {
                __holdState = __directionalPrevHold? (__directionalHold? GUI_HOLD : GUI_RELEASE) : (__directionalHold? GUI_PRESS : GUI_OFF);
                if (not GuiGetHoverable(__holdInstance)) __holdInstance = noone;
                __GuiNavStartOver(__GuiGetDirectionalOver(__overInstance, __directionalStateX.__output, __directionalStateY.__output));
            }
            else //Using a pointer
            {
                __holdState = __mousePrevHold? (__mouseHold? GUI_HOLD : GUI_RELEASE) : (__mouseHold? GUI_PRESS : GUI_OFF);
                if (not GuiGetHoverable(__holdInstance)) __holdInstance = noone;
                __GuiNavStartOver(__GuiGetPointerOver(__mouseX, __mouseY));
                
                //Detect clicking off of a pop-up
                if ((__holdState == GUI_PRESS)
                &&  instance_exists(__popUpRoot)
                &&  (__popUpRoot != __overInstance) //Don't destroy a pop-up if we're hovering directly over it
                &&  (not GuiIsAncestor(__popUpRoot, __overInstance))) //Also don't destroy if we're hovering over a child of the pop-up
                {
                    GuiDestroy(__popUpRoot);
                    if (not GUI_POP_UP_CLICK_THROUGH) __holdState = GUI_OFF;
                }
                
                if (__holdState == GUI_PRESS)
                {
                    __mousePressX = __mouseX;
                    __mousePressY = __mouseY;
                
                    __mousePrevX = __mouseX;
                    __mousePrevY = __mouseY;
                }
            }
            
            if (__holdState == GUI_PRESS)
            {
                __primaryConsumed = false;
            }
        }
        
        __GuiUpdateInstanceState();
    }
    
    //Surprise! We go in reverse
    var _i = array_length(_stepOrder)-1;
    repeat(array_length(_stepOrder))
    {
        _stepOrder[_i]();
        --_i;
    }
    
    __GuiEnsureScrollLimits();
}