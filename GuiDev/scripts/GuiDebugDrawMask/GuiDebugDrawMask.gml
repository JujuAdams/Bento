// Feather disable all

/// @param [color=c_white]
/// @param [alpha=0.5]
/// @param [instance=id]

function GuiDebugDrawMask(_color = c_white, _alpha = 0.5, _instance = id)
{
    with(_instance)
    {
        if (sprite_exists(mask_index))
        {
            draw_sprite_ext(mask_index, image_index, x, y, image_xscale, image_yscale, image_angle, _color, _alpha);
        }
        else if (sprite_exists(sprite_index))
        {
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _color, _alpha);
        }
    }
}