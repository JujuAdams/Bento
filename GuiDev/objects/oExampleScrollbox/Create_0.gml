// Feather disable all

event_inherited();

GuiSetIfNotDefined("showScrollbar", true);
GuiSetIfNotDefined("focusable",     true);

handleGrabbed = false;

GuiScissorSetEnabled(true);
GuiScrollSetEnabled(true, true);

if (focusable)
{
    GuiSetBehavior(GUI_BEHAVIOR_BUTTON);
    GuiNavSetFocusable(true);
}