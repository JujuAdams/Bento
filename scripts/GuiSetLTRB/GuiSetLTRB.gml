// Feather disable all

/// @param instance
/// @param left
/// @param top
/// @param right
/// @param bottom

function GuiSetLTRB(_instance, _left, _top, _right, _bottom)
{
    with(_instance)
    {
        GuiMove(_instance, 0.5*(_left + _right), 0.5*(_top + _bottom));
        
        width  = _right - _left;
        height = _bottom - _top;
    }
}