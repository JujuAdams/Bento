/// @desc Reposition

// This event is called whenever the library decides that the element needs to be moved. This is
// typically when the element is created, the layout changes, or when the player has scrolled a
// element.

if (sprite_exists(sprite_index))
{
    image_xscale = bentoWidth  / sprite_get_width(sprite_index);
    image_yscale = bentoHeight / sprite_get_height(sprite_index);
}
else
{
    image_xscale = 1;
    image_yscale = 1;
}

x = bentoX;
y = bentoY;