// Feather disable all

/// Sets the absolute position of a GUI instance. If that instance has any children (inside or
/// outside) then the children will follow the parent.
/// 
/// @param x
/// @param y
/// @param [instance=id]
/// @param [hAlign]
/// @param [vAlign]
/// @param [relative=false]

function GuiSetPosition(_x, _y, _instance = id, _hAlign = undefined, _vAlign = undefined, _relative = false)
{
    with(_instance)
    {
        if (_relative)
        {
            var _parent = __parent;
            if (instance_exists(_parent))
            {
                _x += _parent.x;
                _y += _parent.y;
            }
        }
        
        if (_hAlign == fa_left)
        {
            var _dX = _x - bbox_left;
        }
        else if (_hAlign == fa_center)
        {
            var _dX = _x - 0.5*(bbox_left + bbox_right);
        }
        else if (_hAlign == fa_right)
        {
            var _dX = _x - bbox_right;
        }
        else
        {
            var _dX = _x - x;
        }
        
        if (_vAlign == fa_top)
        {
            var _dY = _y - bbox_top;
        }
        else if (_vAlign == fa_middle)
        {
            var _dY = _y - 0.5*(bbox_top + bbox_bottom);
        }
        else if (_vAlign == fa_bottom)
        {
            var _dY = _y - bbox_bottom;
        }
        else
        {
            var _dY = _y - y;
        }
        
        GuiMove(_dX, _dY);
    }
}