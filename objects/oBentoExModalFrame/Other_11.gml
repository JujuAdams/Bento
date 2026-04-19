/// @param Draw

BentoDrawClear();

draw_sprite_ext(sprite_index, image_index, x + BENTO_EXAMPLE_SHADOW_OFFSET, y + BENTO_EXAMPLE_SHADOW_OFFSET, image_xscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA*image_alpha);
draw_sprite_ext(sBentoExButton, image_index, x, y, image_xscale, image_yscale, image_angle, BENTO_EXAMPLE_DARK_BLUE, image_alpha);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);