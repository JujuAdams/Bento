// Feather disable all

/// Returns the nearest instance along the given ray. This is not a true raycast as instances near
/// the ray will be considered (which is better UX when navigating using directional input). The
/// `excludeArray` argument can be set to an array of instance IDs that should be ignored by this
/// function.
/// 
/// @param x
/// @param y
/// @param directionX
/// @param directionY
/// @param [excludeArray]

function GuiNavGetRaycast(_x, _y, _dX, _dY, _excludeArray = [])
{
    static _stepOrder = __GuiSystem().__stepOrder;
   
    var _baseDist = dot_product(_dX, _dY, _x, _y);
    
    var _instance = noone;
    
    var _minWeight = infinity;
    var _i = 0;
    repeat(array_length(_stepOrder))
    {
        with(method_get_self(_stepOrder[_i]))
        {
            if (array_get_index(_excludeArray, id) >= 0)
            {
                //Skip this instance
                continue;
            }
            
            var _nearestX = clamp(_x, bbox_left, bbox_right);
            var _nearestY = clamp(_y, bbox_top, bbox_bottom);
            
            var _dot = dot_product(_dX, _dY, _nearestX, _nearestY) - _baseDist;
            if (_dot > 0)
            {
                var _weight = point_distance(_x, _y, _nearestX, _nearestY);
                if (_weight < _minWeight)
                {
                    if (GuiGetHoverable(id))
                    {
                        _instance = id;
                        _minWeight = _weight;
                    }
                }
            }
        }
        
        ++_i;
    }
    
    return _instance;
}