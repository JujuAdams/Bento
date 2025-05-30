/// @desc Step

scrollbarHandleTop    = lerp(scrollbarTop, scrollbarBottom - scrollbarHandleHeight, GuiScrollGetParamY());
scrollbarHandleBottom = scrollbarHandleTop + scrollbarHandleHeight;

if (GuiUsingDirectional())
{
    overScrollbar = false;
    overHandle = false;
    
    if (GuiPrimaryGetClick())
    {
        GuiFocusOpen(GUI_FOCUS_POINTER_CANCEL_ALWAYS);
    }
    
    if (GuiHotkeyGetPress("escape"))
    {
        GuiInputConsume();
        GuiFocusClose();
    }
}
else if (GuiUsingPointer())
{
    if (handleGrabbed)
    {
        if (GuiPrimaryGetHold())
        {
            var _top = GuiCursorGetY() + handleGrabbedRelativeY - scrollbarTop;
            GuiScrollSetParamY(_top / scrollbarRangeHeight, infinity);
            
            //var _param = GuiScrollGetParamY();
            //_param += GuiCursorGetDY() / scrollbarRangeHeight;
            //GuiScrollSetParamY(_param, infinity);
        }
    }
    else
    {
        if (not point_in_rectangle(GuiCursorGetX(), GuiCursorGetY(), scrollbarLeft, scrollbarTop, scrollbarRight, scrollbarBottom))
        {
            //Pointer isn't over the scrollbar, use standard logic
            overScrollbar = false;
            overHandle = false;
            
            GuiScrollOnPointer();
        }
        else
        {
            //Still allow use of mouse wheel whilst hovering the scrollbar
            if ((GuiCursorGetY() >= scrollbarHandleTop) && (GuiCursorGetY() <= scrollbarHandleBottom))
            {
                overScrollbar = false;
                overHandle = true;
            }
            else
            {
                overScrollbar = true;
                overHandle = false;
            }
            
            if (overHandle && GuiPrimaryGetPress())
            {
                //Allow grabbing of the handle
                handleGrabbed = true;
                handleGrabbedRelativeY = scrollbarHandleTop - GuiCursorGetY();
            }
            else if (overScrollbar && GuiPrimaryGetClick())
            {
                //Otherwise allow a single click to teleport the scroll handle
                var _param = GuiScrollGetParamY();
                
                if (GuiCursorGetY() > scrollbarHandleBottom)
                {
                    _param += (GuiCursorGetY() - scrollbarHandleBottom) / scrollbarRangeHeight;
                }
                else if (GuiCursorGetY() < scrollbarHandleTop)
                {
                    _param += (GuiCursorGetY() - scrollbarHandleTop) / scrollbarRangeHeight;
                }
                
                GuiScrollSetParamY(_param, infinity);
            }
            else
            {
                if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_UP))
                {
                    GuiScrollMove(0, GUI_MOUSE_WHEEL_SCROLL_SPEED);
                }
                
                if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_DOWN))
                {
                    GuiScrollMove(0, -GUI_MOUSE_WHEEL_SCROLL_SPEED);
                }
            }
        }
    }
}

if handleGrabbed && (not GuiPrimaryGetHold())
{
    handleGrabbed = false;
}