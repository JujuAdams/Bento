// Feather disable all

/// This constructor defines a simple sprite element that can be used within a Bento UI layout.
/// 
/// Example:
/// ```
/// new BentoConstrSprite(sprite_index);
/// ```
///
/// @param sprite
/// @param [parent=self]

function BentoConstrSprite(_sprite, _parent = other) : BentoConstrAncestor(_parent) constructor
{
    sprite = _sprite;
    
    BentoLayoutSetSize(sprite_get_width(sprite), sprite_get_height(sprite));
    BentoSetOrigin(sprite_get_xoffset(sprite) / sprite_get_width(sprite),
                   sprite_get_yoffset(sprite) / sprite_get_height(sprite));
    
    funcDraw = function()
    {
        BentoDrawSprite(sprite);
    }
}