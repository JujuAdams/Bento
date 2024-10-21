// Feather disable all

/// Sets the absolute position of a GUI instance. This function, unlike `GuiSetPosition()`, will
/// not move the target instance's children.
/// 
/// @param x
/// @param y
/// @param [instance=id]
/// @param [hAlign=fa_center]
/// @param [vAlign=fa_middle]
/// @param [relative=false]

function GuiSetPositionSolo(_x, _y, _instance = id, _hAlign = fa_center, _vAlign = fa_middle, _relative = false)
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
            _x += width/2;
        }
        else if (_hAlign == fa_right)
        {
            _x -= width/2;
        }
        
        if (_vAlign == fa_top)
        {
            _y += height/2;
        }
        else if (_hAlign == fa_bottom)
        {
            _y -= height/2;
        }
        
        xstart = x;
        ystart = y;
        
        GuiMoveSolo(_x - x, _y - y);
    }
}