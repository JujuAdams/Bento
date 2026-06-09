// Feather disable all

// An example that demonstrates how to make a stepper for numerical values. This is commonly used
// for audio volumes, mouse sensitivity etc.  It can be manipulated using pointer input or
// navigation input. Clicking on the left or right sides will scroll through options. Navigation
// input uses the x-axis movement to trigger scrolling through options (in this example project,
// that means pressing the left and right arrow keys).

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

BentoVarEnsureMany(
    "text",      "Example",
    "font",      fntBentoExCandyBeans,
    "reference", undefined,
    "valueStep", 1,
    "valueMin",  0,
    "valueMax",  100,
    "useFocus",  true,
    "func",      function(){},
);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

if (not useFocus)
{
    // We disable horizontal navigation so that players can scroll through values without jumping
    // to another element
    BentoSetNavigationEnable(false, true);
}

//Ensure the click function is scoped to this instance
func = method(self, func);

var _oldFont = draw_get_font();
draw_set_font(fntBentoExCandyBeans);
BentoLayoutSetSize(max(string_width(text), string_width(valueMax)) + 70, string_height(text) + string_height(valueMax) + 20);
draw_set_font(_oldFont);