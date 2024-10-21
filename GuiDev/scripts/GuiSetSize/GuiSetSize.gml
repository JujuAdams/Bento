// Feather disable all

/// Sets the width and height of a GUI instance. If that instance has any children (inside or
/// outside) then the children will follow the parent.
/// 
/// @param width
/// @param height
/// @param [instance=id]
/// @param [hAlign=fa_center]
/// @param [vAlign=fa_middle]

function GuiSetSize(_width, _height, _instance = id, _hAlign = fa_center, _vAlign = fa_middle)
{
    with(_instance)
    {
        var _dX = 0;
        var _dY = 0;
        
        if (_hAlign == fa_left)
        {
            _dX = 0.5*(_width - width);
        }
        else if (_hAlign == fa_right)
        {
            _dX = 0.5*(width - _width);
        }
        
        if (_vAlign == fa_top)
        {
            _dY = 0.5*(_height - height);
        }
        else if (_vAlign == fa_bottom)
        {
            _dY = 0.5*(height - _height);
        }
        
        width  = _width;
        height = _height;
        
        if ((_dX != 0) || (_dY != 0))
        {
            GuiMove(_dX, _dY);
        }
    }
}