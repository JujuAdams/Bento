// Feather disable all

/// @param timeStep

function __BentoAnimateScroll(_timeStep)
{
    var _scrollAnimatingArray = __scrollAnimatingArray;
    var _i = array_length(_scrollAnimatingArray)-1;
    repeat(array_length(_scrollAnimatingArray))
    {
        var _element = _scrollAnimatingArray[_i];
        if (not BentoExists(_element))
        {
            //Remove this scroller if the element no longer exists
            array_delete(_scrollAnimatingArray, _i, 1);
        }
        else
        {
            with(_element.BENTO_VARS)
            {
                var _dX = __scrollTargetX - __scrollX;
                var _dY = __scrollTargetY - __scrollY;
                
                var _distance = sqrt(_dX*_dX + _dY*_dY);
                if (_distance <= 0)
                {
                    //Remove this scroller if the scroll has reached its target
                    array_delete(_scrollAnimatingArray, _i, 1);
                }
                else
                {
                    _dX *= min(1, min(999999, _timeStep*__scrollSpeed) / _distance);
                    _dY *= min(1, min(999999, _timeStep*__scrollSpeed) / _distance);
                    
                    __scrollX += _dX;
                    __scrollY += _dY;
                    
                    __BentoOffsetMarkDirty();
                }
            }
        }
        
        --_i;
    }
}