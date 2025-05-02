// Feather disable all

// Juju: An example that demonstrates how to make a carousel of discrete qualitative options. It
//       can be manipulated using pointer input or directional input. Clicking on the left or right
//       sides will scroll through options. Directional input uses the x-axis movement to trigger
//       scrolling through options (in this example project, that means pressing the left and right
//       arrow keys).

event_inherited();

GuiSetBehavior(GUI_BEHAVIOR_BUTTON);

// Disables raycasting in particular axes. This only applies to directional input where raycasting
// is used to work out which instance to jump to when pushing in a particular direction. This does
// not apply to navigation links created with `GuiNavLink*()` functions. We disable horizontal
// raycasting so that it doesn't interfere with scrolling through options.
GuiNavRaycastSetDisable(true, false);

GuiSetIfNotDefined("title",       "Example");
GuiSetIfNotDefined("optionArray", []);
GuiSetIfNotDefined("option",      0);
GuiSetIfNotDefined("func",        function(){});

var _width  = string_width(title);
var _height = string_height(title);

var _i = 0;
repeat(array_length(optionArray))
{
    _width   = max(_width, string_width(optionArray[_i]) + 40);
    _height += string_height(optionArray[0]);
    ++_i;
}

GuiLayoutSetSize(_width + 20, _height + 20);