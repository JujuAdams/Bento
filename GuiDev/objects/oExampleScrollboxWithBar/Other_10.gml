/// @desc Step

width   = 10;
padding =  5;

var _bodyL = guiRight - width - padding;
var _bodyT = guiTop + padding;
var _bodyR = guiRight - padding;
var _bodyB = guiBottom - padding;

var _handleH = (_bodyB - _bodyT) * clamp(guiHeight / GuiScrollGetHeight(), 0.1, 1);
var _handleT = lerp(_bodyT, _bodyB - _handleH, GuiScrollGetParamY());
var _handleB = _handleT + _handleH;

if (GuiUsingDirectional())
{
    if (GuiPrimaryGetClick() && focusable)
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
    if (not point_in_rectangle(GuiCursorGetX(), GuiCursorGetY(), _bodyL, _bodyT, _bodyR, _bodyB))
    {
        //Pointer isn't over the scrollbar, use standard logic
        if (not handleGrabbed)
        {
            GuiScrollOnPointer();
        }
    }
    else
    {
        //Still allow use of mouse wheel whilst hovering the scrollbar
        if (not handleGrabbed)
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
        
        if (GuiPrimaryGetPress() && (GuiCursorGetY() >= _handleT) && (GuiCursorGetY() <= _handleB))
        {
            //Allow grabbing of the handle
            handleGrabbed = true;
        }
        else if (GuiPrimaryGetClick())
        {
            //Otherwise allow a single click to teleport the scroll handle
            GuiScrollSetParamY((GuiCursorGetY() - _bodyT) / (_bodyB - _bodyT));
        }
    }
    
    if (handleGrabbed && GuiPrimaryGetHold())
    {
        GuiScrollSetParamY((GuiCursorGetY() - _bodyT) / (_bodyB - _bodyT));
    }
}

if (not GuiPrimaryGetHold())
{
    handleGrabbed = false;
}