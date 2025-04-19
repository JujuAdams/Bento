/// @desc Reposition

if (sprite_exists(sprite_index))
{
    image_xscale = layoutWidth  / sprite_get_width(sprite_index);
    image_yscale = layoutHeight / sprite_get_height(sprite_index);
    
    x = layoutLeft - image_xscale*sprite_get_xoffset(sprite_index);
    y = layoutTop  - image_yscale*sprite_get_yoffset(sprite_index);
}
else
{
    image_xscale = 1;
    image_yscale = 1;
    
    x = layoutLeft + 0.5*layoutWidth;
    y = layoutTop  + 0.5*layoutHeight;
}