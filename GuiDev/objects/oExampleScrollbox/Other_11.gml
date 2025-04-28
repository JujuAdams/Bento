/// @desc Draw

// Feather disable all

// Inherit the parent event
event_inherited();

if (GuiNavGetHold() && (not (focusable && GuiNavUsingDirectional())))
{
    var _fgColor = c_gray;
    var _bgColor = c_white;
}
else if (GuiNavGetOver())
{
    var _fgColor = c_white;
    var _bgColor = c_dkgray;
}
else
{
    var _fgColor = c_white;
    var _bgColor = c_gray;
}

if (focusable && GuiNavUsingDirectional())
{
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _fgColor, image_alpha);
}
else
{
    draw_self();
}