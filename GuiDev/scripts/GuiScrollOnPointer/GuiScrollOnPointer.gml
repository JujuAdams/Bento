// Feather disable all

/// Handles scrolling behavior when using the `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH` navigation modes.
/// This function should be called in the Step user event (`GUI_USER_EVENT_STEP`) for both the
/// parent and any children.
/// 
/// @param [scrollSpeed]
/// @param [element=self]

function GuiScrollOnPointer(_scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    var _layer = _element.GUI_VARS.__layer;
    if (_layer.__navPointer)
    {
        if ((GUI_SCROLL_ON_MOUSE_DRAG || (_layer.__navMode == GUI_NAV_TOUCH)) && GuiNavGetHold(_element))
        {
            if (GuiNavGetDragDistance() > GUI_SCROLL_THRESHOLD)
            {
                var _parent = __GuiScrollFindParent(_element);
                if (_element == _parent)
                {
                    GuiScrollMove(GuiNavGetDX(), GuiNavGetDY(), infinity, _parent);
                }
                else
                {
                    __GuiNavStartHold(_parent);
                }
            }
        }
        else if (GuiNavGetOver(_element))
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
            
            GuiScrollMove(_dX, _dY, _scrollSpeed, _element);
        }
    }
}