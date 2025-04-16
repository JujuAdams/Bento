/// @param left
/// @param width
/// @param hAlign

function GuiRegionGetTextX(_pos, _size, _align = fa_center)
{
    if (_align == fa_left)
    {
        return _pos;
    }
    else if (_align == fa_right)
    {
        return (_pos + _size);
    }
    else
    {
        //Default to center
        return (_pos + 0.5*_size);
    }
}