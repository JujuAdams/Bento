/// @desc Draw

gpu_set_tex_filter(false); //Make the map pixel art look nicer
draw_sprite_part(sBentoExMap, 0, mapX, mapY, bentoWidth-10, bentoHeight-10, x+5, y+5);
gpu_set_tex_filter(true);

//Draw the frame around the map
draw_sprite_ext(sprite_index, image_index, x+5, y+5, image_xscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA*image_alpha);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle,  BentoGetFocused()? BENTO_EXAMPLE_RED : image_blend, image_alpha);