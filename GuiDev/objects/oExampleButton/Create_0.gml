// Feather disable all

event_inherited();

GuiSetIfNotDefined("text", "");
GuiSetIfNotDefined("clickFunc", function()
{
    show_debug_message($"Button {id} clicked");
});

GuiSetBehavior(GUI_BEHAVIOR_BUTTON);