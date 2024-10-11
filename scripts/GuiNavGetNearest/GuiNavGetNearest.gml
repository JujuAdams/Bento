// Feather disable all

/// @param x
/// @param y
/// @param [excludeArray]

function GuiNavGetNearest(_x, _y, _excludeArray = [])
{
    static _system    = __GuiSystem();
    static _stepOrder = __GuiSystem().__stepOrder;
    
    var _instance = noone;
    
    var _popUpRoot = _system.__popUpRoot;
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
            
            if ((__behavior == GUI_BEHAVIOR_BUTTON)
            &&  ((not instance_exists(_popUpRoot)) || GuiIsAncestor(_popUpRoot, id)))
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