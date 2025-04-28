// Feather disable all

event_inherited();

if (focusable)
{
    GuiSetBehavior(GuiNavUsingDirectional()? GUI_BEHAVIOR_BUTTON : GUI_BEHAVIOR_COSMETIC);
}