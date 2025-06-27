// Feather disable all

/// @param sprite
/// @param [parent=self]

function BentoConstrSprite(_sprite, _parent = other) : BentoConstrAncestor(_parent) constructor
{
    sprite = _sprite;
    
    BentoLayoutSetSize(sprite_get_width(sprite), sprite_get_height(sprite));
    BentoLayoutSetOrigin(sprite_get_xoffset(_sprite) / sprite_get_width(_sprite),
                       sprite_get_yoffset(_sprite) / sprite_get_height(_sprite));
    
    funcDraw = function()
    {
        draw_sprite_ext(sprite, 0,
                        guiX, guiY,
                        guiWidth/sprite_get_width(sprite), guiHeight/sprite_get_height(sprite), 0,
                        c_white, 1);
    }
}