// Feather disable all

/// @desc Draw

//Draw ourselves. Bento positions and sizes the instance automatically
draw_sprite_ext(sprite_index, image_index, x+5, y+5, image_xscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA*image_alpha);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

// If we have some text then draw it centred on the button
if (text != "")
{
    draw_set_color(BentoDnDIsValidTarget()? c_lime : textColor);
    draw_set_font(BENTO_EXAMPLE_DEFAULT_FONT);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(0.5*(bentoLeft + bentoRight), 0.5*(bentoTop + bentoBottom), text);
    draw_set_color(c_white);
    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}