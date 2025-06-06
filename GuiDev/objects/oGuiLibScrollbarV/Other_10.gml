/// @desc Step

var _handleHeight = (guiBottom - guiTop) * clamp(guiHeight / GuiScrollGetHeight(target), 0.1, 1);

handleTop    = lerp(guiTop, guiBottom - _handleHeight, GuiScrollGetParamY(target));
handleBottom = handleTop + _handleHeight;

if (GuiUsingPointer())
{
    var _rangeHeight = max(1, guiHeight - _handleHeight);
    
    if (handleGrabbed)
    {
        if (GuiPrimaryGetHold())
        {
            var _top = GuiCursorGetY() + handleGrabbedRelativeY - guiTop;
            GuiScrollSetParamY(_top / _rangeHeight, infinity, target);
        }
    }
    else if (not GuiCursorGetHover())
    {
        //Pointer isn't hovering the scrollbar at all
        handleHover = false;
    }
    else
    {
        handleHover = ((GuiCursorGetY() >= handleTop) && (GuiCursorGetY() <= handleBottom));
        
        if (handleHover && GuiPrimaryGetPress())
        {
            //Allow grabbing of the handle
            handleGrabbed = true;
            handleGrabbedRelativeY = handleTop - GuiCursorGetY();
        }
        else if (GuiPrimaryGetClick())
        {
            //Otherwise allow a single click to teleport the scroll handle
            var _param = GuiScrollGetParamY();
            
            if (GuiCursorGetY() > handleBottom)
            {
                _param += (GuiCursorGetY() - handleBottom) / _rangeHeight;
            }
            else if (GuiCursorGetY() < handleTop)
            {
                _param += (GuiCursorGetY() - handleTop) / _rangeHeight;
            }
            
            GuiScrollSetParamY(_param, infinity, target);
        }
        else
        {
            if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_UP))
            {
                GuiScrollMove(0, GUI_MOUSE_WHEEL_SCROLL_SPEED, undefined, target);
            }
            
            if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_DOWN))
            {
                GuiScrollMove(0, -GUI_MOUSE_WHEEL_SCROLL_SPEED, undefined, target);
            }
        }
    }
}
else
{
    handleHover = false;
}

if (not GuiPrimaryGetHold())
{
    handleGrabbed = false;
}