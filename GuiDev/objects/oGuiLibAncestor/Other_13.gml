/// @desc Reposition

if (sprite_exists(sprite_index))
{
    image_xscale = layoutWidth  / sprite_get_width(sprite_index);
    image_yscale = layoutHeight / sprite_get_height(sprite_index);
}
else
{
    image_xscale = 1;
    image_yscale = 1;
}

x = layoutX;
y = layoutY;

image_angle = layoutAngle;