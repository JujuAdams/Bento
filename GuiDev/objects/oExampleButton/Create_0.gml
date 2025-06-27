// Feather disable all

event_inherited();

BentoSetIfNotDefined("text", "");
BentoSetIfNotDefined("clickFunc", function()
{
    show_debug_message($"Button {id} clicked");
});

//Ensure the click function is scoped to this instance
clickFunc = method(self, clickFunc);

BentoSetButton(BENTO_BUTTON_ALWAYS);