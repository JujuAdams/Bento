/// @desc Reposition

if (sprite_exists(sprite_index))
{
    image_xscale = guiWidth  / sprite_get_width(sprite_index);
    image_yscale = guiHeight / sprite_get_height(sprite_index);
}
else
{
    image_xscale = 1;
    image_yscale = 1;
}

x = guiX;
y = guiY;