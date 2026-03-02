// Feather disable all

/// Convenience function that draws a sprite stretched to fit a Bento element.
/// 
/// @param sprite
/// @param [image=-1]
/// @param [blend=white]
/// @param [alpha=image_alpha]
/// @param [xOffset]
/// @param [yOffset]
/// @param [element=self]

function BentoDrawSprite(_sprite, _image = -1, _blend = c_white, _alpha = image_alpha, _xOffset = 0, _yOffset = 0, _element = self)
{
    with(_element)
    {
        draw_sprite_stretched_ext(_sprite, _image, bentoLeft + _xOffset, bentoTop + _yOffset, bentoWidth, bentoHeight, _blend, _alpha);
    }
}