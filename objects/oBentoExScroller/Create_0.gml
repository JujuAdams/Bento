// Feather disable all

// An example that demonstrates how to make a carousel of discrete qualitative options. It
// can be manipulated using pointer input or directional input. Clicking on the left or right
// sides will scroll through options. Directional input uses the x-axis movement to trigger
// scrolling through options (in this example project, that means pressing the left and right
// arrow keys).

event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

// Disables raycasting in particular axes. This only applies to directional input where raycasting
// is used to work out which element to jump to when pushing in a particular direction. This does
// not apply to navigation links created with `BentoLink*()` functions. We disable horizontal
// raycasting so that it doesn't interfere with scrolling through options.
BentoSetRaycastEnable(false, true);

BentoVarEnsure("title",     "Example");
BentoVarEnsure("valueStep", 1);
BentoVarEnsure("valueMin",  0);
BentoVarEnsure("valueMax",  100);
BentoVarEnsure("value",     valueMax);
BentoVarEnsure("func",      function(){});

draw_set_font(fntDebug);
BentoLayoutSetSize(string_width(title) + 20, string_height(title) + 20);