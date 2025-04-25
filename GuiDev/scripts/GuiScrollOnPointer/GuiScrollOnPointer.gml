// Feather disable all

/// Handles scrolling behavior when using the `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH` navigation modes.
/// This function should be called in the Step user event (`GUI_USER_EVENT_STEP`) for both the
/// parent and any children.
/// 
/// @param [instance=id]

function GuiScrollOnPointer(_instance = id)
{
    static _system = __GuiSystem();
    
    if (_system.__navPointer)
    {
        if ((GUI_SCROLL_ON_MOUSE_DRAG || (_system.__navMode == GUI_NAV_TOUCH)) && GuiNavGetHold(_instance))
        {
            if (GuiNavGetDragDistance() > GUI_SCROLL_THRESHOLD)
            {
                var _parent = __GuiScrollFindParent(_instance);
                if (_instance == _parent)
                {
                    var _xScale = layoutWidth / max(1, __solvedWidth);
                    var _yScale = layoutHeight / max(1, __solvedHeight);
                    
                    if ((_xScale != 0) && (_yScale != 0))
                    {
                        var _navDX = GuiNavGetDX();
                        var _navDY = GuiNavGetDY();
                        
                        var _cos =  dcos(-layoutAngle);
                        var _sin = -dsin(-layoutAngle);
                        
                        //We need to transform the navigation delta into the local coordinate space of the UI element
                        var _dX = (_navDX*_cos - _navDY*_sin) / _xScale;
                        var _dY = (_navDX*_sin + _navDY*_cos) / _yScale;
                        
                        GuiScrollMove(_dX, _dY, _parent);
                    }
                }
                else
                {
                    __GuiNavStartHold(_parent);
                }
            }
        }
        else if (GuiNavGetOver(_instance))
        {
            //Mouse wheel input can be pretty noisy
            if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_UP  ) || GuiHotkeyGetHold(GUI_HOTKEY_MOUSE_WHEEL_UP  )) GuiScrollMove(-GUI_MOUSE_WHEEL_SCROLL_SPEED,  GUI_MOUSE_WHEEL_SCROLL_SPEED, _instance);
            if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_DOWN) || GuiHotkeyGetHold(GUI_HOTKEY_MOUSE_WHEEL_DOWN)) GuiScrollMove( GUI_MOUSE_WHEEL_SCROLL_SPEED, -GUI_MOUSE_WHEEL_SCROLL_SPEED, _instance);
        }
    }
}