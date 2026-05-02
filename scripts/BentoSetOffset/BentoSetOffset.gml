// Feather disable all

/// Sets the x and y offset for an element. You may use a value of `undefined` to indicate that a
/// value in a particular axis should not be changed from its current value. Changing the offset
/// value in either axis will trigger the Reposition user event / callback to be executed for the
/// target element and any descendents of that element.
/// 
/// @param [x]
/// @param [y]
/// @param [element=self]

function BentoSetOffset(_x, _y, _element = self)
{
    with(__BentoGetVars(_element))
    {
        var _dirty = false;
        
        if (_x != undefined)
        {
            if (__offsetX != _x)
            {
                __offsetX = _x;
                _dirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__offsetY != _y)
            {
                __offsetY = _y;
                _dirty = true;
            }
        }
        
        if (_dirty)
        {
            __BentoOffsetMarkDirty();
        }
    }
}