/// @param top
/// @param height
/// @param vAlign

function GuiRegionGetTextY(_pos, _size, _align = fa_center)
{
    if (_align == fa_top)
    {
        return _pos;
    }
    else if (_align == fa_bottom)
    {
        return (_pos + _size);
    }
    else
    {
        //Default to center
        return (_pos + 0.5*_size);
    }
}