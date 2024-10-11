// Feather disable all

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
            
            var _nearestX = clamp(_x, x - 0.5*width,  x + 0.5*width );
            var _nearestY = clamp(_y, y - 0.5*height, y + 0.5*height);
            
            var _dot = dot_product(_dX, _dY, _nearestX, _nearestY) - _baseDist;
            if (_dot > 0)
            {
                var _weight = point_distance(_x, _y, _nearestX, _nearestY);
                if (_weight < _minWeight)
                {
                    if (__GuiGetSelectableByGamepad(id))
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