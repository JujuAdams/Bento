// Feather disable all

// This object defines a carousel of discrete options. It can be manipulated using pointer input or
// directional input. Clicking on the left or right sides will scroll through options. Directional
// input uses the x-axis movement to trigger scrolling through options (typically left/right arrow
// keys or thumbstick/dpad input).
// 
// Carousels are connected to a variable using a "Bento reference". A Bento reference contains the
// information necessary to change a value stored in your code when the carousel changes value. 
// Please see `BentoRef()` for more information.
// 
// You may specify the following variables when creating an instance of this object with
// `BentoCreate()`.
// 
// .text
//     The text title to display on the carousel. This should be a string. If not specified, no text is
//     drawn.
// 
// .reference
//     A Bento reference, created by `BentoRef()`, that stores the value for the carousel. When the
//     carousel changes value, this variable will be modified.
// 
// .optionArray
//     An array of options that the above Bento reference may contain. The carousel will cycle through
//     these options.
// 
// .func
//     The function to execute when the carousel changes value. This function will always be re-scaoped
//     such that the function is executed in the scope of the carousel instance.
// 
// Example:
// ```
// BentoCreate(oBentoExCarousel, {
//     text: "Interface Color",
//     reference: BentoRef(global.settings, "uiColor"),
//     optionArray: ["Red", "Green", "Blue"],
//     func: function() {
//         SetUIColor(global.settings.uiColor);
//     },
// });
// ```

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoSetButton(BENTO_BUTTON_ALWAYS);

// Disables raycasting in particular axes. This only applies to directional input where raycasting
// is used to work out which element to jump to when pushing in a particular direction. This does
// not apply to navigation links created with `BentoLink*()` functions. We disable horizontal
// raycasting so that it doesn't interfere with scrolling through options.
BentoSetRaycastEnable(false, true);

BentoVarEnsureMany(
    "reference",   undefined,
    "optionArray", [],
    "text",        "Example",
    "font",        fntBentoExCandyBeans,
    "func",        function(){},
);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

var _oldFont = draw_get_font();
draw_set_font(font);

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

BentoLayoutSetSize(max(_width, _optionWidth) + 70, _height + _optionHeight + 20);

draw_set_font(_oldFont);