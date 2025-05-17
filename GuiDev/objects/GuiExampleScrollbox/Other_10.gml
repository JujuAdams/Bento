/// @desc Step

var _bodyT = y + 1 + padding;
var _bodyB = y + height-2 - padding;

if (showScrollbar)
{
    if (GuiUsingDirectional())
    {
        if (GuiPrimaryGetClick())
        {
            GuiSetFocus(true);
        }
        
        if (GuiHotkeyGetPress("escape"))
        {
            GuiInputConsume();
            GuiSetFocus(false);
        }
    }
    else if (GuiUsingPointer())
    {
        if (GuiCursorGetX() == x + width-1 - padding)
        {
            if (not handleGrabbed)
            {
                if (GuiPrimaryGetClick())
                {
                    if (GuiCursorGetY() == y + padding)
                    {
                        GuiScrollMove(0, 1);
                    }
                    else if (GuiCursorGetY() == y + height-1 - padding)
                    {
                        GuiScrollMove(0, -1);
                    }
                }
                
                if (GuiCursorGetOver())
                {
                    if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_UP))
                    {
                        GuiScrollMove(0, 1);
                    }
                    
                    if (GuiHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_DOWN))
                    {
                        GuiScrollMove(0, -1);
                    }
                }
            }
            
            var _handlePos = round(lerp(_bodyT, _bodyB, GuiScrollGetParamY()));
            
            if (GuiCursorGetY() >= _bodyT) && (GuiCursorGetY() <= _bodyB)
            {
                if (GuiPrimaryGetPress() && (GuiCursorGetY() == _handlePos))
                {
                    handleGrabbed = true;
                }
                else if (GuiPrimaryGetClick())
                {
                    GuiScrollSetParamY((GuiCursorGetY() - _bodyT) / (_bodyB - _bodyT));
                }
            }
        }
        else
        {
            if (not handleGrabbed)
            {
                GuiScrollOnPointer();
            }
        }
        
        if (showScrollbar && handleGrabbed && GuiPrimaryGetHold())
        {
            GuiScrollSetParamY((GuiCursorGetY() - _bodyT) / (_bodyB - _bodyT));
        }
    }
    
    if (not GuiPrimaryGetHold())
    {
        handleGrabbed = false;
    }
}