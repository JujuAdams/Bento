// Feather disable all

/// Sets the absolute position of a GUI instance. This function, unlike `GuiSetPosition()`, will
/// not move the target instance's children.
/// 
/// @param x
/// @param y
/// @param [instance=id]
/// @param [hAlign]
/// @param [vAlign]
/// @param [relative=false]

function GuiSetPositionSolo(_x, _y, _instance = id, _hAlign = undefined, _vAlign = undefined, _relative = false)
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
                
                if (__inside && _parent.__scrollEnabled)
                {
                    _x += _parent.__scrollX - _parent.__scrollMaxX;
                    _y += _parent.__scrollY - _parent.__scrollMaxY;
                }
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
        
        GuiMoveSolo(_dX, _dY);
    }
}