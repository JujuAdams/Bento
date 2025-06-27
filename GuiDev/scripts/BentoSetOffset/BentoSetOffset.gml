// Feather disable all

/// @param [x]
/// @param [y]
/// @param [element=self]

function BentoSetOffset(_x, _y, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        var _dirty = false;
        
        if (_x != undefined)
        {
            if (__offsetX != _x)
            {
                __offsetX = _x;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
                _dirty = true;
            }
        }
        
        if (_y != undefined)
        {
            if (__offsetY != _y)
            {
                __offsetY = _y;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
                _dirty = true;
            }
        }
        
        if (_dirty)
        {
            __offsetDirty = true;
            array_push(__layer.__dirtyOffsetArray, _element);
        }
    }
}