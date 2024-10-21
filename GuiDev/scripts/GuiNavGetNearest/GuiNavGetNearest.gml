// Feather disable all

/// Returns the nearest instance to the given coordinate. The `excludeArray` argument can be set to
/// an array of instance IDs that should be ignored by this function.
/// 
/// @param x
/// @param y
/// @param [excludeArray]

function GuiNavGetNearest(_x, _y, _excludeArray = [])
{
    static _system    = __GuiSystem();
    static _stepOrder = __GuiSystem().__stepOrder;
    
    var _instance = noone;
    
    var _nearestDistance = infinity;
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
            
            if (__GuiGetHoverableInner(id))
            {
                var _distance = point_distance(x, y, _x, _y);
                if (_distance < _nearestDistance)
                {
                    _nearestDistance = _distance;
                    _instance = id;
                }
            }
        }
        
        ++_i;
    }
    
    return _instance;
}