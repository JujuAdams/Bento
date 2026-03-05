// Feather disable all

/// @desc Draw

var _offset = BentoPrimaryGetHold()? 2 : 0;

var _x = 0.5*(bentoLeft + bentoRight);
var _y = 0.5*(bentoTop + bentoBottom);

draw_sprite_ext(sprite_index, image_index, x + BENTO_EXAMPLE_SHADOW_OFFSET, y + BENTO_EXAMPLE_SHADOW_OFFSET, image_xscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA*image_alpha);
draw_sprite_ext(sBentoExButton, image_index, x + _offset, y + _offset, image_xscale, image_yscale, image_angle, BENTO_EXAMPLE_DARK_BLUE, image_alpha);
draw_sprite_ext(sprite_index, image_index, x + _offset, y + _offset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (BentoTextGetTargeted())
{
    var _text = __displayText;
    if ((BentoTextGetOpenDuration() mod 30) < 15) _text += "|";
    draw_set_color(c_white);
}
else
{
    if (__displayText == "")
    {
        var _text = emptyText;
        draw_set_color(BENTO_EXAMPLE_BLUE);
    }
    else
    {
        var _text = __displayText;
        draw_set_color(BENTO_EXAMPLE_YELLOW);
    }
}

draw_set_font(font);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(bentoLeft + 10 + _offset, _y + _offset, _text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(-1);