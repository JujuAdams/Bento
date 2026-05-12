// Feather disable all

// This object defines a stepper of discrete strings. It can be manipulated using pointer input or
// navigation input. Clicking on the left or right sides will scroll through strings. Navigation
// input uses the x-axis movement to trigger stepping through strings (typically left/right arrow
// keys or thumbstick/dpad input).
// 
// Steppers are connected to a variable using a "Bento reference". A Bento reference contains the
// information necessary to change a value stored in your code when the stepper changes value. 
// Please see `BentoRef()` for more information.
// 
// You may specify the following variables when creating an instance of this object with
// `BentoCreate()`.
// 
// .text
//     The text title to display on the stepper. This should be a string. If not specified, no text is
//     drawn.
// 
// .reference
//     A Bento reference, created by `BentoRef()`, that stores the value for the stepper. When the
//     stepper changes value, this variable will be modified.
// 
// .stringArray
//     An array of strings that the above Bento reference may contain. The stepper will cycle through
//     these strings.
// 
// .func
//     The function to execute when the stepper changes value. This function will always be re-scaoped
//     such that the function is executed in the scope of the stepper instance.
// 
// Example:
// ```
// BentoCreate(oBentoExStepperStrings, {
//     text: "Interface Color",
//     reference: BentoRef(global.settings, "uiColor"),
//     stringArray: ["Red", "Green", "Blue"],
//     func: function() {
//         SetUIColor(global.settings.uiColor);
//     },
// });
// ```

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

BentoVarEnsureMany(
    "reference",   undefined,
    "stringArray", [],
    "text",        "Example",
    "font",        fntBentoExCandyBeans,
    "useFocus",    true,
    "showMarkers", true,
    "func",        function(){},
);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

if (not useFocus)
{
    // Disables raycasting in particular axes. This only applies to navigation input where raycasting
    // is used to work out which element to jump to when pushing in a particular direction. This does
    // not apply to navigation links created with `BentoLink*()` functions. We disable horizontal
    // raycasting so that it doesn't interfere with stepping through strings.
    BentoSetRaycastEnable(false, true);
}

var _oldFont = draw_get_font();
draw_set_font(font);

var _width  = string_width(text);
var _height = string_height(text);

if (showMarkers)
{
    _height += 30;
}

var _optionWidth  = 0;
var _optionHeight = 0;

var _i = 0;
repeat(array_length(stringArray))
{
    _optionWidth  = max(_optionWidth,  string_width(stringArray[_i]) + 40);
    _optionHeight = max(_optionHeight, string_height(stringArray[0]));
    ++_i;
}

BentoLayoutSetSize(max(_width, _optionWidth) + 70, _height + _optionHeight + 20);

draw_set_font(_oldFont);