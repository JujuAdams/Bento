// Feather disable all

/// Returns the nearest instance to the given coordinate. The `excludeArray` argument can be set to
/// an array of instance IDs that should be ignored by this function.
/// 
/// @param x
/// @param y
/// @param [excludeArray]
/// @param [layer=current]

function __GuiGetNearest(_x, _y, _excludeArray = [], _layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    var _hoverableOrder = _layer.__hoverableOrder;
    
    var _element = GUI_NO_ELEMENT;
    var _nearestDistance = infinity;
    var _i = 0;
    repeat(array_length(_hoverableOrder))
    {
        with(_hoverableOrder[_i])
        {
            if (array_get_index(_excludeArray, self) < 0)
            {
                if (__GuiGetHoverableInternal(self, true))
                {
                    var _distance = point_distance(0.5*(guiLeft + guiRight), 0.5*(guiTop + guiBottom), _x, _y);
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