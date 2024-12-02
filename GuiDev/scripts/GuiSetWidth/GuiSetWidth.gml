// Feather disable all

/// Sets the width of a GUI instance. If that instance has any children (inside or outside) then
/// the children will follow the parent.
/// 
/// @param width
/// @param [instance=id]
/// @param [hAlign]

function GuiSetWidth(_width, _instance = id, _hAlign = undefined)
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
        
        image_xscale = _width / sprite_get_width(sprite_index);
        
        if (_dX != 0)
        {
            GuiMove(_dX, 0);
        }
    }
}