/// @desc Step

event_inherited();

if (GuiUsingDirectional())
{
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
    GuiScrollOnPointer();
}