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
    "text", "Item",
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

BentoCarrySetItemChannel(1);

funcDraw = function()
{
    //Draw ourselves. Bento positions and sizes the instance automatically
    draw_sprite_ext(sprite_index, image_index, x+5, y+5, image_xscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA*image_alpha);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    
    // If we have some text then draw it centred on the button
    if (text != "")
    {
        draw_set_color(textColor);
        draw_set_alpha(image_alpha);
        draw_set_font(BENTO_EXAMPLE_DEFAULT_FONT);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        draw_text(0.5*(bentoLeft + bentoRight), 0.5*(bentoTop + bentoBottom), text);
        
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_set_font(-1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}