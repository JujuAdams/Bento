// Feather disable all

/// Handles scrolling behavior when using the `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH` navigation modes.
/// This function should be called in the Step user event (`GUI_USER_EVENT_STEP`) for both the
/// parent and any children.
/// 
/// @param [scrollSpeed]
/// @param [instance=id]

function GuiScrollOnPointer(_scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    var _environment = _instance.GUI_STRUCT.__environment;
    if (_environment.__navPointer)
    {
        if ((GUI_SCROLL_ON_MOUSE_DRAG || (_environment.__navMode == GUI_NAV_TOUCH)) && GuiNavGetHold(_instance))
        {
            if (GuiNavGetDragDistance() > GUI_SCROLL_THRESHOLD)
            {
                var _parent = __GuiScrollFindParent(_instance);
                if (_instance == _parent)
                {
                    GuiScrollMove(GuiNavGetDX(), GuiNavGetDY(), infinity, _parent);
                }
                else
                {
                    __GuiNavStartHold(_parent);
                }
            }
        }
        else if (GuiNavGetOver(_instance))
        {
            //Mouse wheel input can be pretty noisy so we filter out as much as possible
            
            var _dX = 0;
            var _dY = 0;
            
            if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_UP) || GuiHotkeyGetHold(GUI_HOTKEY_MOUSE_WHEEL_UP))
            {
                _dX -= GUI_MOUSE_WHEEL_SCROLL_SPEED;
                _dY += GUI_MOUSE_WHEEL_SCROLL_SPEED;
            }
            
            if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_DOWN) || GuiHotkeyGetHold(GUI_HOTKEY_MOUSE_WHEEL_DOWN))
            {
                _dX += GUI_MOUSE_WHEEL_SCROLL_SPEED;
                _dY -= GUI_MOUSE_WHEEL_SCROLL_SPEED;
            }
            
            GuiScrollMove(_dX, _dY, _scrollSpeed, _instance);
        }
    }
}