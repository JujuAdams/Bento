// Feather disable all

// Juju: An example that demonstrates how to make a carousel of discrete qualitative options. It
//       can be manipulated using pointer input or directional input. Clicking on the left or right
//       sides will scroll through options. Directional input uses the x-axis movement to trigger
//       scrolling through options (in this example project, that means pressing the left and right
//       arrow keys).

event_inherited();

GuiSetButton(GUI_BUTTON_ALWAYS);

// Disables raycasting in particular axes. This only applies to directional input where raycasting
// is used to work out which instance to jump to when pushing in a particular direction. This does
// not apply to navigation links created with `GuiNavLink*()` functions. We disable horizontal
// raycasting so that it doesn't interfere with scrolling through options.
GuiNavRaycastSetDisable(true, false);

GuiSetIfNotDefined("title",     "Example");
GuiSetIfNotDefined("valueStep", 1);
GuiSetIfNotDefined("valueMin",  0);
GuiSetIfNotDefined("valueMax",  100);
GuiSetIfNotDefined("value",     valueMax);
GuiSetIfNotDefined("func",      function(){});

GuiLayoutSetSize(string_width(title) + 20, string_height(title) + 20);