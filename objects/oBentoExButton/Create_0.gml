// Feather disable all

// This object defines a simple text button that can be used within a Bento UI layout. The button
// will execute a callback function when clicked.
// 
// You may specify the following variables when creating an instance of this object with
// `BentoCreate()`.
// 
// .text
//     The text to display on the button. This should be a string. If not specified, no text is drawn.
// 
// .func
//     The function to execute when the button is clicked. This function will always be re-scaoped such
//     that the function is executed in the scope of the button instance.
// 
// Example:
// ```
// BentoCreate(oBentoButton, {
//     text: "Quit to Desktop",
//     func: function() {
//         game_end();
//     }
// });
// ```

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

//Allow Bento to focus this element
BentoSetButton(inoperative? BENTO_BUTTON_NEVER : BENTO_BUTTON_ALWAYS);

//If we have some valid text then force the size of the element
if (text != "")
{
    draw_set_font(BENTO_EXAMPLE_DEFAULT_FONT);
    BentoLayoutSetSize(string_width(text) + 20, string_height(text) + 20);
    draw_set_font(-1);
}