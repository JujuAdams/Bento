// Feather disable all

event_inherited();

GuiSetIfNotDefined("text", "");
GuiSetIfNotDefined("clickFunc", function()
{
    show_debug_message($"Button {id} clicked");
});

//Ensure the click function is scoped to this instance
clickFunc = method(self, clickFunc);

GuiSetBehavior(GUI_BEHAVIOR_BUTTON);