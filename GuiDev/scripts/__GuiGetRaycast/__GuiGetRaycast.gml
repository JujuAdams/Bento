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
/// @param [scrollParent]
/// @param [layer=current]

function __GuiGetRaycast(_x, _y, _dX, _dY, _excludeArray = [], _scrollParent = undefined, _layer = undefined)
{
    static _system = __GuiSystem();
    
    var _baseDist = dot_product(_dX, _dY, _x, _y);
    
    _layer ??= _system.__layerCurrent;
    var _stepOrder = _layer.__stepOrder;
   
    var _element  = noone;
    var _minWeight = infinity;
    
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
            
            var _nearestX = clamp(_x, guiLeft, guiRight);
            var _nearestY = clamp(_y, guiTop, guiBottom);
            
            var _dot = dot_product(_dX, _dY, _nearestX, _nearestY) - _baseDist;
            if (_dot > 0)
            {
                var _weight = point_distance(_x, _y, _nearestX, _nearestY);
                if (_weight < _minWeight)
                {
                    //FIXME - This should be the joint scissor and scroll parent
                    if (GuiGetHoverable(self, (not GuiExists(_scrollParent)) || (_scrollParent != __GuiScrollFindParent(self))))
                    {
                        _element = self;
                        _minWeight = _weight;
                    }
                }
            }
        }
        
        ++_i;
    }
    
    return _element;
}