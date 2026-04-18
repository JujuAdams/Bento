// Feather disable all

/// @desc Draw

if (BentoDnDIsItem())
{
    draw_sprite_ext(sBentoExFrame, image_index, x+5, y+5, image_xscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA*image_alpha);
    draw_sprite_ext(sBentoExFrame, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
else
{
    funcDraw();
}