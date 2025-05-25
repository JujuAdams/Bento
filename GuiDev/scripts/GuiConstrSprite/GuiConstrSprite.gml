// Feather disable all

/// @param sprite
/// @param [parent=self]

function GuiConstrSprite(_sprite, _parent = other) : GuiConstrAncestor(_parent) constructor
{
    sprite = _sprite;
    
    GuiLayoutSetSize(sprite_get_width(sprite), sprite_get_height(sprite));
    GuiLayoutSetOrigin(sprite_get_xoffset(_sprite) / sprite_get_width(_sprite),
                       sprite_get_yoffset(_sprite) / sprite_get_height(_sprite));
    
    funcDraw = function()
    {
        draw_sprite_ext(sprite, 0,
                        guiX, guiY,
                        guiWidth/sprite_get_width(sprite), guiHeight/sprite_get_height(sprite), 0,
                        c_white, 1);
    }
}