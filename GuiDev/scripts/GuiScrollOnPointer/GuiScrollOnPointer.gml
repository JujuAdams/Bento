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
        if (GuiNavGetHold(_instance))
        {
            if (GuiNavGetDragDistance() > GUI_SCROLL_THRESHOLD)
            {
                var _parent = __GuiScrollFindParent(_instance);
                if (_instance == _parent)
                {
                    GuiScrollMove(GuiNavGetDX(), GuiNavGetDY(), _parent);
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
            if (GuiButtonGetPress(GUI_BUTTON_MOUSE_WHEEL_UP  ) || GuiButtonGetHold(GUI_BUTTON_MOUSE_WHEEL_UP  )) GuiScrollMove(-GUI_MOUSE_WHEEL_SCROLL_SPEED,  GUI_MOUSE_WHEEL_SCROLL_SPEED, _instance);
            if (GuiButtonGetPress(GUI_BUTTON_MOUSE_WHEEL_DOWN) || GuiButtonGetHold(GUI_BUTTON_MOUSE_WHEEL_DOWN)) GuiScrollMove( GUI_MOUSE_WHEEL_SCROLL_SPEED, -GUI_MOUSE_WHEEL_SCROLL_SPEED, _instance);
        }
    }
}