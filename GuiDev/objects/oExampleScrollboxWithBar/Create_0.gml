// Feather disable all

event_inherited();

GuiSetIfNotDefined("focusable", true);

handleGrabbed = false;
GuiSetDrawAfter(true);

GuiScissorSetEnabled(true);
GuiScrollSetEnabled(true, true);

if (focusable)
{
    GuiSetButton(GUI_BUTTON_DIRECTIONAL);
}