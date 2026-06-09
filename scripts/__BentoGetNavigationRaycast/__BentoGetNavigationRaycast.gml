// Feather disable all

/// Returns the nearest element along the given ray. This is not a true raycast as elements near
/// the ray will be considered (which is better UX when moving between elements with navigation
/// input).
/// 
/// @param resultStruct
/// @param x
/// @param y
/// @param directionX
/// @param directionY
/// @param exclude
/// @param scrollParent

function __BentoGetNavigationRaycast(_resultStruct, _x, _y, _dX, _dY, _exclude, _scrollParent)
{
    static _system = __BentoSystem();
    
    var _baseDist  = dot_product(_dX, _dY, _x, _y);
    var _direction = point_direction(0, 0, _dX, _dY);
    
    var _layer = _system.__layerCurrent;
    var _hoverableOrder = _layer.__hoverableOrder;
    
    if (not _layer.__inputModeNavigation)
    {
        __BentoError("Can only use `__BentoGetNavigationRaycast()` in navigation mode");
    }
    
    var _minElement    = BENTO_NO_ELEMENT;
    var _minWeight     = infinity;
    var _minSameParent = false;
    
    var _i = 0;
    repeat(array_length(_hoverableOrder))
    {
        with(_hoverableOrder[_i])
        {
            if (BENTO_VARS != _exclude)
            {
                var _nearestX = clamp(_x, bentoLeft, bentoRight);
                var _nearestY = clamp(_y, bentoTop, bentoBottom);
                
                //Basic dot product check. This'll quickly reject everything behind push direction
                var _dot = dot_product(_dX, _dY, _nearestX, _nearestY) - _baseDist;
                if (_dot > 0)
                {
                    var _angleDelta = angle_difference(_direction, point_direction(_x, _y, _nearestX, _nearestY));
                    if (abs(_angleDelta) < 50) //TODO - Faster if we do this with a dot product?
                    {
                        //Reject elements that are too far away
                        var _weight = point_distance(_x, _y, _nearestX, _nearestY);
                        
                        //Add a slight penalty for being off-axis
                        _weight += abs(_angleDelta);
                        
                        //However, if we can find a button inside the same scroll parent then prefer that
                        var _sameParent = (_scrollParent == __BentoFindScrollElement(BENTO_VARS.__parent));
                        
                        if ((_weight < _minWeight) || (_sameParent && (not _minSameParent)))
                        {
                            //Check whether this element can actually be hovered. This is the most expensive part of the process
                            //due to needing to check a bunch of variables. We ignore the visibility check if the element we're
                            //jumping from is inside the same scroll parent; this allows us to scroll to an element that is
                            //outside of view but conceptually accessible from the current element.
                            //
                            //FIXME - Change to a check against the joint scissor and scroll parent
                            if (__BentoGetHoverableInternal(self, not _sameParent))
                            {
                                _minElement    = self;
                                _minWeight     = _weight;
                                _minSameParent = _sameParent;
                            }
                        }
                    }
                }
            }
        }
        
        ++_i;
    }
    
    with(_resultStruct)
    {
        __element    = _minElement;
        __weight     = _minWeight;
        __sameParent = _minSameParent;
    }
    
    return _resultStruct;
}