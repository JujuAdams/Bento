// Feather disable all

/// Returns the nearest element along the given ray. This is not a true raycast as elements near
/// the ray will be considered (which is better UX when navigating using directional input). The
/// `excludeArray` argument can be set to an array of element IDs that should be ignored by this
/// function.
/// 
/// @param x
/// @param y
/// @param directionX
/// @param directionY
/// @param excludeArray
/// @param scrollParent

function __BentoGetRaycast(_x, _y, _dX, _dY, _excludeArray, _scrollParent)
{
    static _system = __BentoSystem();
    
    var _baseDist  = dot_product(_dX, _dY, _x, _y);
    var _direction = point_direction(0, 0, _dX, _dY);
    
    var _layer = _system.__layerCurrent;
    var _hoverableOrder = _layer.__hoverableOrder;
    
    if (not _layer.__navDirectional)
    {
        __BentoError("Can only use `__BentoGetRaycast()` in directional mode");
    }
   
    var _element  = BENTO_NO_ELEMENT;
    var _minWeight = infinity;
    
    var _i = 0;
    repeat(array_length(_hoverableOrder))
    {
        with(_hoverableOrder[_i])
        {
            if (array_get_index(_excludeArray, self) < 0)
            {
                var _nearestX = clamp(_x, bentoLeft, bentoRight);
                var _nearestY = clamp(_y, bentoTop, bentoBottom);
                
                //Basic dot product check. This'll quickly reject everything behind push direction
                var _dot = dot_product(_dX, _dY, _nearestX, _nearestY) - _baseDist;
                if (_dot > 0)
                {
                    //Reject elements that are too far away
                    var _weight = point_distance(_x, _y, _nearestX, _nearestY);
                    if (_weight < _minWeight)
                    {
                        //Reject outside of a 60-degree cone. We do this last to avoid running expensive trig funcs
                        var _angleDelta = angle_difference(_direction, point_direction(_x, _y, _nearestX, _nearestY));
                        if (abs(_angleDelta) < 60)
                        {
                            //Check whether this element can actually be hovered. This is the most expensive part of the process
                            //due to needing to check a bunch of variables. We ignore the visibility check if the element we're
                            //jumping from is inside the same scroll parent; this allows us to scroll to an element that is
                            //outside of view but conceptually accessible from the current element.
                            //
                            //FIXME - Change to a check against the joint scissor and scroll parent
                            var _checkVisible = ((not BentoExists(_scrollParent)) || (_scrollParent != __BentoScrollFindParent(self)));
                            if (__BentoGetHoverableInternal(self, _checkVisible))
                            {
                                _element = self;
                                _minWeight = _weight;
                            }
                        }
                    }
                }
            }
        }
        
        ++_i;
    }
    
    return _element;
}