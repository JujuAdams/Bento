// Feather disable all

/// Sets the height of a GUI instance. If that instance has any children (inside or outside) then
/// the children will follow the parent.
/// 
/// @param height
/// @param [instance=id]
/// @param [vAlign]

function GuiSetHeight(_height, _instance = id, _vAlign = undefined)
{
    with(_instance)
    {
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
        
        image_yscale = _height / sprite_get_height(sprite_index);
        
        if (_dY != 0)
        {
            GuiMove(0, _dY);
        }
    }
}