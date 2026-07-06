// Feather disable all

/// @param [x]
/// @param [y]
/// @param [innerCoordSpace=true]
/// @param [element=self]

function BentoSetPosition(_x, _y, _innerCoordSpace = true, _element = self)
{
    with(__BentoGetVars(_element))
    {
        var _dirty = false;
        
        if (_x != undefined)
        {
            if (__positionX != _x)
            {
                __positionX = _x;
                _dirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__positionY != _y)
            {
                __positionY = _y;
                _dirty = true;
            }
        }
        
        if (_innerCoordSpace != undefined)
        {
            if (__positionInnerCoordSpace != _innerCoordSpace)
            {
                __positionInnerCoordSpace = _innerCoordSpace;
                _dirty = true;
            }
        }
        
        if (_dirty)
        {
            __positionOverride = true;
            __BentoOffsetMarkDirty();
        }
    }
}