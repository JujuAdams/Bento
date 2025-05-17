// Feather disable all

event_inherited();

if (focusable)
{
    GuiSetButton(GuiUsingDirectional()? GUI_BUTTON_ALWAYS : GUI_BUTTON_NEVER);
}