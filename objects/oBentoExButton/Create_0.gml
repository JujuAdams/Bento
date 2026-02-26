// Feather disable all

//This is an example for how to build a simple text button using Bento.

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

//Ensure that we have a couple variable defined. This emulates
BentoVarEnsureMany(
    "text",      "",
    "clickFunc", function()
    {
        show_debug_message($"Button {id} clicked");
    },
);

//Ensure the click function is scoped to this instance
clickFunc = method(self, clickFunc);

//Allow Bento to focus this element
BentoSetButton(BENTO_BUTTON_ALWAYS);

//If we have some valid text then force the size of the element
if (text != "")
{
    BentoLayoutSetSize(string_width(text) + 20, string_height(text) + 20);
}