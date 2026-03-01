// Feather disable all

/// Convenience function that draws a sprite stretched to fit a Bento element.
/// 
/// @param padding
/// @param sprite
/// @param [image=-1]
/// @param [blend=white]
/// @param [alpha=image_alpha]
/// @param [element=self]

function BentoDrawSpriteAround(_padding, _sprite, _image = -1, _blend = c_white, _alpha = image_alpha, _element = self)
{
    with(_element)
    {
        draw_sprite_stretched_ext(_sprite, _image, bentoLeft - _padding, bentoTop - _padding, bentoWidth + 2*_padding, bentoHeight + 2*_padding, _blend, _alpha);
    }
}