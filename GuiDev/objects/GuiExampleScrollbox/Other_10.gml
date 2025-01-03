/// @desc Step

var _bodyT = y + 1 + padding;
var _bodyB = y + height-2 - padding;

if (showScrollbar)
{
    if (GuiNavUsingDirectional())
    {
        if (GuiNavGetClick())
        {
            GuiNavSetFocus(true);
        }
        
        if (GuiButtonGetPress("escape"))
        {
            GuiNavConsume();
            GuiNavSetFocus(false);
        }
    }
    else if (GuiNavUsingPointer())
    {
        if (GuiNavGetCursorX() == x + width-1 - padding)
        {
            if (not handleGrabbed)
            {
                if (GuiNavGetClick())
                {
                    if (GuiNavGetCursorY() == y + padding)
                    {
                        GuiScrollMove(0, 1);
                    }
                    else if (GuiNavGetCursorY() == y + height-1 - padding)
                    {
                        GuiScrollMove(0, -1);
                    }
                }
                
                if (GuiNavGetOver())
                {
                    if (GuiButtonGetPress(GUI_BUTTON_MOUSE_WHEEL_UP))
                    {
                        GuiScrollMove(0, 1);
                    }
                    
                    if (GuiButtonGetPress(GUI_BUTTON_MOUSE_WHEEL_DOWN))
                    {
                        GuiScrollMove(0, -1);
                    }
                }
            }
            
            var _handlePos = round(lerp(_bodyT, _bodyB, GuiScrollGetParamY()));
            
            if (GuiNavGetCursorY() >= _bodyT) && (GuiNavGetCursorY() <= _bodyB)
            {
                if (GuiNavGetPress() && (GuiNavGetCursorY() == _handlePos))
                {
                    handleGrabbed = true;
                }
                else if (GuiNavGetClick())
                {
                    GuiScrollSetParamY((GuiNavGetCursorY() - _bodyT) / (_bodyB - _bodyT));
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
        
        if (showScrollbar && handleGrabbed && GuiNavGetHold())
        {
            GuiScrollSetParamY((GuiNavGetCursorY() - _bodyT) / (_bodyB - _bodyT));
        }
    }
    
    if (not GuiNavGetHold())
    {
        handleGrabbed = false;
    }
}