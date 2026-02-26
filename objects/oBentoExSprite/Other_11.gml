/// @desc Draw

// This event is executed downstream of `BentoSystemDraw()`.
// 
// We use a simple `draw_self()` call here because we are correctly setting the instance's
// position and scale in the Reposition user event.

if (sprite_exists(sprite_index))
{
    draw_self();
}