// Feather disable all

/// @param [instance=id]

function GuiScrollOnMouse(_instance = id)
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
                    GuiScrollMove(_parent, GuiNavGetDX(), GuiNavGetDY());
                }
                else
                {
                    __GuiNavStartHold(_parent);
                }
            }
        }
        else if (GuiNavGetOver(_instance))
        {
            if (GuiNavGetButton(GUI_BUTTON_MOUSE_WHEEL_UP  )) GuiScrollMove(_instance, -GUI_MOUSE_WHEEL_SCROLL_SPEED, GUI_MOUSE_WHEEL_SCROLL_SPEED);
            if (GuiNavGetButton(GUI_BUTTON_MOUSE_WHEEL_DOWN)) GuiScrollMove(_instance, GUI_MOUSE_WHEEL_SCROLL_SPEED, -GUI_MOUSE_WHEEL_SCROLL_SPEED);
        }
    }
}