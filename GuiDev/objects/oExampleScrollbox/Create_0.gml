// Feather disable all

event_inherited();

GuiSetIfNotDefined("padding",       0);
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