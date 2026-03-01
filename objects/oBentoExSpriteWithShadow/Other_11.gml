/// @desc Draw

// This event is executed downstream of `BentoSystemDraw()`.
// 
// We use a simple `draw_self()` call here because we are correctly setting the instance's
// position and scale in the Reposition user event.

if (sprite_exists(sprite_index))
{
    draw_sprite_ext(sprite_index, image_index, x+5, y+5, image_xscale, image_yscale, image_angle, c_black, 0.4*image_alpha);
    draw_self();
}