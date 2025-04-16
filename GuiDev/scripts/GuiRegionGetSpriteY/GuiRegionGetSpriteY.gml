/// @param sprite
/// @param top
/// @param height
/// @param vAlign

function GuiRegionGetSpriteY(_sprite, _pos, _size, _align = fa_center)
{
    if (_align == fa_top)
    {
        return (_pos + sprite_get_yoffset(_sprite));
    }
    else if (_align == fa_middle)
    {
        return (_pos + 0.5*_size);
    }
    else if (_align == fa_top)
    {
        return (_pos + _size - sprite_get_height(_sprite) + sprite_get_yoffset(_sprite));
    }
    else
    {
        //Default to stretch
        return (_pos + (_size / sprite_get_height(_sprite))*sprite_get_yoffset(_sprite));
    }
}