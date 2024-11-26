// Feather disable all

/// Updates the GUI system based on the navigation mode (`GuiNavSetMode()`) and user input:
/// 
/// - `GuiInputPointer()`
/// - `GuiInputGamepad()`
/// - `GuiInputButton()`

function GuiStep()
{
    static _system = __GuiSystem();
    
    __GuiScissorReset();
    var _stepOrder = __GuiEnsureStepOrder();
    
    with(_system)
    {
        ++__frame;
        
        // Calculate gamepad x/y deltas
        __gamepadStateX.__Update(__gamepadDX, __frame);
        __gamepadStateY.__Update(__gamepadDY, __frame);
        
        if (not GuiFreezeGetAny())
        {
            var _i = 0;
            repeat(array_length(__buttonArray))
            {
                var _key = __buttonArray[_i];
                
                var _prev  = __buttonPrevMap[?  _key] ?? false;
                var _input = __buttonInputMap[? _key] ?? false;
                
                if (_input && (not _prev))
                {
                    __buttonConsumedMap[? _key] = false;
                }
                
                __buttonPrevMap[?  _key] = _input;
                __buttonStateMap[? _key] = _prev? (_input? GUI_HOLD : GUI_RELEASE) : (_input? GUI_PRESS : GUI_OFF);
                
                ++_i;
            }
            
            if (not __navPointer) //Not using a pointer
            {
                __holdState = __gamepadPrevHold? (__gamepadHold? GUI_HOLD : GUI_RELEASE) : (__gamepadHold? GUI_PRESS : GUI_OFF);
                if (not GuiGetHoverable(__holdInstance)) __holdInstance = noone;
                __GuiNavStartOver(__GuiGetGamepadOver(__overInstance, __gamepadStateX.__output, __gamepadStateY.__output));
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
    
}