// Feather disable all

// An example that demonstrates how to make a carousel of discrete qualitative options. It
// can be manipulated using pointer input or directional input. Clicking on the left or right
// sides will scroll through options. Directional input uses the x-axis movement to trigger
// scrolling through options (in this example project, that means pressing the left and right
// arrow keys).

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

// Disables raycasting in particular axes. This only applies to directional input where raycasting
// is used to work out which element to jump to when pushing in a particular direction. This does
// not apply to navigation links created with `BentoLink*()` functions. We disable horizontal
// raycasting so that it doesn't interfere with scrolling through options.
BentoSetRaycastEnable(false, true);

BentoVarEnsureMany(
    "text",        "Example",
    "reference",   undefined,
    "optionArray", [],
    "func",        function(){},
);

var _width  = string_width(text);
var _height = string_height(text);

var _optionWidth  = 0;
var _optionHeight = 0;

var _i = 0;
repeat(array_length(optionArray))
{
    _optionWidth  = max(_optionWidth,  string_width(optionArray[_i]) + 40);
    _optionHeight = max(_optionHeight, string_height(optionArray[0]));
    ++_i;
}

BentoLayoutSetSize(max(_width, _optionWidth) + 30, _height + _optionHeight + 10);