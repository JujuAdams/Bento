// Feather disable all

/// Convenience function that draws a sprite stretched to fit a Bento element.
/// 
/// @param sprite
/// @param [image=-1]
/// @param [blend=white]
/// @param [alpha=1]
/// @param [element=self]

function BentoDrawSprite(_sprite, _image = -1, _blend = c_white, _alpha = 1, _element = self)
{
    with(_element)
    {
        draw_sprite_ext(_sprite, _image,
                        bentoX, bentoY,
                        bentoWidth/sprite_get_width(_sprite), bentoHeight/sprite_get_height(_sprite), 0,
                        _blend, _alpha);
    }
}