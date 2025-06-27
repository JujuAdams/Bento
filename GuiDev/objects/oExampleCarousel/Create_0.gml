// Feather disable all

// Juju: An example that demonstrates how to make a carousel of discrete qualitative options. It
//       can be manipulated using pointer input or directional input. Clicking on the left or right
//       sides will scroll through options. Directional input uses the x-axis movement to trigger
//       scrolling through options (in this example project, that means pressing the left and right
//       arrow keys).

event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

// Disables raycasting in particular axes. This only applies to directional input where raycasting
// is used to work out which instance to jump to when pushing in a particular direction. This does
// not apply to navigation links created with `BentoNavLink*()` functions. We disable horizontal
// raycasting so that it doesn't interfere with scrolling through options.
BentoSetRaycastDisable(true, false);

BentoSetIfNotDefined("title",       "Example");
BentoSetIfNotDefined("optionArray", []);
BentoSetIfNotDefined("option",      0);
BentoSetIfNotDefined("func",        function(){});

var _width  = string_width(title);
var _height = string_height(title);

var _i = 0;
repeat(array_length(optionArray))
{
    _width   = max(_width, string_width(optionArray[_i]) + 40);
    _height += string_height(optionArray[0]);
    ++_i;
}

BentoLayoutSetSize(_width + 20, _height + 20);