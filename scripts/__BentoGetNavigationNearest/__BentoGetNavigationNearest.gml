// Feather disable all

/// Returns the nearest element to the given coordinate.
/// 
/// @param x
/// @param y
/// @param exclude

function __BentoGetNavigationNearest(_x, _y, _exclude)
{
    static _system = __BentoSystem();
    
    var _layer = _system.__layerCurrent;
    var _hoverableOrder = _layer.__hoverableOrder;
    
    if (not _layer.__inputModeNavigation)
    {
        __BentoError("Can only use `__BentoGetNavigationNearest()` in navigation mode");
    }
    
    var _element = BENTO_NO_ELEMENT;
    var _nearestDistance = infinity;
    var _i = 0;
    repeat(array_length(_hoverableOrder))
    {
        with(_hoverableOrder[_i])
        {
            if (BENTO_VARS != _exclude)
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