// Feather disable all

/// Returns the nearest instance to the given coordinate. The `excludeArray` argument can be set to
/// an array of instance IDs that should be ignored by this function.
/// 
/// @param x
/// @param y
/// @param [excludeArray]
/// @param [layer=current]

function GuiGetNearest(_x, _y, _excludeArray = [], _layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    var _stepOrder = _layer.__stepOrder;
    
    var _element = noone;
    var _nearestDistance = infinity;
    var _i = 0;
    repeat(array_length(_stepOrder))
    {
        with(method_get_self(_stepOrder[_i]))
        {
            if (array_get_index(_excludeArray, self) >= 0)
            {
                //Skip this instance
                continue;
            }
            
            if (GuiGetHoverable(self, true))
            {
                var _distance = point_distance(0.5*(guiLeft + guiRight), 0.5*(guiTop + guiBottom), _x, _y);
                if (_distance < _nearestDistance)
                {
                    _nearestDistance = _distance;
                    _element = self;
                }
            }
        }
        
        ++_i;
    }
    
    return _element;
}