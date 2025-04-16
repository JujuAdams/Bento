/// @param sprite
/// @param left
/// @param width
/// @param hAlign

function GuiRegionGetSpriteX(_sprite, _pos, _size, _align = fa_center)
{
    if (_align == fa_left)
    {
        return (_pos + sprite_get_xoffset(_sprite));
    }
    else if (_align == fa_center)
    {
        return (_pos + 0.5*_size);
    }
    else if (_align == fa_right)
    {
        return (_pos + _size - sprite_get_width(_sprite) + sprite_get_xoffset(_sprite));
    }
    else
    {
        //Default to stretch
        return (_pos + (_size / sprite_get_width(_sprite))*sprite_get_xoffset(_sprite));
    }
}