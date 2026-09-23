// Feather disable all

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

//Ensure that we have a couple variable defined. This emulates
BentoVarEnsureMany(
    "text", "",
    "textColor", BENTO_EXAMPLE_DARK_BLUE,
    "inoperative", false,
    "func", function()
    {
        show_debug_message($"Button {id} clicked");
    },
);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

if (inoperative)
{
    image_blend = BENTO_EXAMPLE_DARK_BLUE;
    textColor = BENTO_EXAMPLE_BLUE;
}

//Ensure the click function is scoped to this instance
func = method(self, func);

//Allow Bento to hover this element when using pointer input but not navigation input. This means
//that keyboard/gamepad input cannot directly interact with the button
BentoSetButton(inoperative? BENTO_BUTTON_NEVER : BENTO_BUTTON_POINTER);

//But always run the Step event! This allows us to check hotkeys
BentoSetPushStep(not inoperative);

//If we have some valid text then force the size of the element
if (text != "")
{
    draw_set_font(BENTO_EXAMPLE_DEFAULT_FONT);
    BentoLayoutSetSize(string_width(text) + 20, string_height(text) + 20);
    draw_set_font(-1);
}

tabOpen = false;