// Feather disable all

// This object defines a checkbox. Clicking on the checkbox will toggle the value between `true`
// and `false`.
// 
// Checkboxes are connected to a variable using a "Bento reference". A Bento reference contains the
// information necessary to change a value stored in your code when the checkbox changes value. 
// Please see `BentoRef()` for more information.
// 
// You may specify the following variables when creating an instance of this object with
// `BentoCreate()`.
// 
// .text
//     The text title to display next to the checkbox. This should be a string. If not specified, no text
//     is drawn.
// 
// .reference
//     A Bento reference, created by `BentoRef()`, that stores the value for the checkbox. When the
//     checkbox changes value, this variable will be modified.
// 
// .func
//     The function to execute when the checkbox changes value. This function will always be re-scaoped
//     such that the function is executed in the scope of the checkbox instance.
// 
// Example:
// ```
// BentoCreate(oBentoExCarousel, {
//     text: "Invert y-axis",
//     reference: BentoRef(global.settings, "invertMouse"),
//     func: function() {
//         show_debug_message("Set mouse y-axis invert to " + (global.settings.invertMouse? "true" : "false"));
//     },
// });
// ```

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoVarEnsureMany(
    "reference", undefined,
    "text", "",
    "font", fntBentoExCandyBeans,
    "func", function()
    {
        show_debug_message($"Button {id} clicked");
    },
);

//Ensure the click function is scoped to this instance
func = method(self, func);

BentoSetButton(BENTO_BUTTON_ALWAYS);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

if (text != "")
{
    var _oldFont = draw_get_font();
    draw_set_font(font);
    
    var _height = max(50, string_height(text));
    BentoLayoutSetSize(string_width(text) + _height + 7, _height);
    
    draw_set_font(_oldFont);
}