// Feather disable all

/// Returns the nearest element to the given coordinate. The `excludeArray` argument can be set to
/// an array of element IDs that should be ignored by this function.
/// 
/// @param x
/// @param y
/// @param excludeArray

function __BentoGetNearest(_x, _y, _excludeArray)
{
    static _system = __BentoSystem();
    
    var _layer = _system.__layerCurrent;
    var _hoverableOrder = _layer.__hoverableOrder;
    
    if (not _layer.__navDirectional)
    {
        __BentoError("Can only use `__BentoGetNearest()` in directional mode");
    }
    
    var _element = BENTO_NO_ELEMENT;
    var _nearestDistance = infinity;
    var _i = 0;
    repeat(array_length(_hoverableOrder))
    {
        with(_hoverableOrder[_i])
        {
            if (array_get_index(_excludeArray, self) < 0)
            {
                if (__BentoGetHoverableInternal(self, true))
                {
                    var _distance = point_distance(0.5*(bentoLeft + bentoRight), 0.5*(bentoTop + bentoBottom), _x, _y);
                    if (_distance < _nearestDistance)
                    {
                        _nearestDistance = _distance;
                        _element = self;
                    }
                }
            }
        }
        
        ++_i;
    }
    
    return _element;
}