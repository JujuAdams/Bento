// Feather disable all

/// Sets the width and height of a GUI instance. If that instance has any children (inside or
/// outside) then the children will follow the parent.
/// 
/// @param width
/// @param height
/// @param [instance=id]
/// @param [hAlign]
/// @param [vAlign]

function GuiSetSize(_width, _height, _instance = id, _hAlign = undefined, _vAlign = undefined)
{
    with(_instance)
    {
        if (_hAlign == fa_left)
        {
            var _dX = 0.5*(_width - sprite_width);
        }
        else if (_hAlign == fa_center)
        {
            var _dX = (((x - bbox_left) / (bbox_right - bbox_left)) - 0.5)*(_width - sprite_width);
        }
        else if (_hAlign == fa_right)
        {
            var _dX = 0.5*(sprite_width - _width);
        }
        else
        {
            var _dX = 0;
        }
        
        if (_vAlign == fa_top)
        {
            var _dY = 0.5*(_height - sprite_height);
        }
        else if (_vAlign == fa_middle)
        {
            var _dY = (((y - bbox_top) / (bbox_bottom - bbox_top)) - 0.5)*(_height - sprite_height);
        }
        else if (_vAlign == fa_bottom)
        {
            var _dY = 0.5*(sprite_height - _height);
        }
        else
        {
            var _dY = 0;
        }
        
        image_xscale = _width / sprite_get_width(sprite_index);
        image_yscale = _height / sprite_get_height(sprite_index);
        
        if ((_dX != 0) || (_dY != 0))
        {
            GuiMove(_dX, _dY);
        }
    }
}