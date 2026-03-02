// Feather disable all

/// @desc Draw

var _x = 0.5*(bbox_left + bbox_right);
var _y = 0.5*(bbox_top + bbox_bottom);

draw_self();

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
        draw_set_color(BENTO_EXAMPLE_DARK_BLUE);
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
draw_text(bbox_left + 10, _y, _text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(-1);