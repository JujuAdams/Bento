// Feather disable all

/// @param parent

function __GuiUpdateScrollLimits(_parent)
{
    with(_parent)
    {
        if (not __scrollLimitsDirty) return;
        __scrollLimitsDirty = false;
        
        var _oldX = __scrollX;
        var _oldY = __scrollY;
        var _newX = _oldX;
        var _newY = _oldY;
        
        if (__scrollHori || __scrollVert)
        {
            //Only do hard work if we have to!
            
            //Calculate the physical bounds of the children of this parent. Positions are in world-space
            var _bounds = GuiGetChildrenBounds();
            
            if (__scrollHori)
            {
                //Calculate how much visible width we have to play with
                if (__scissorEnabled)
                {
                    var _scissorMin = bbox_left + __scissorPadLeft;
                    var _scissorMax = bbox_right - __scissorPadRight;
                }
                else
                {
                    var _scissorMin = bbox_left;
                    var _scissorMax = bbox_right;
                }
                
                var _visibleSize = _scissorMax - _scissorMin;
                
                //Compare the children's width to the total scrollable area
                if (_bounds.width > _visibleSize - (__scrollPadLeft + __scrollPadRight))
                {
                    //Children overlow, set up limits
                    __scrollMinX = -((_bounds.width - _visibleSize) + __scrollPadRight);
                    __scrollMaxX = __scrollPadLeft;
                }
                else
                {
                    //Children don't overflow, lock scroll values to the left padding
                    __scrollMinX = __scrollPadLeft;
                    __scrollMaxX = __scrollPadLeft;
                }
            }
            else
            {
                //No scrolling means no scrolling
                __scrollMinX = 0;
                __scrollMaxX = 0;
            }
            
            //Same as above but in the y-axis
            if (__scrollVert)
            {
                if (__scissorEnabled)
                {
                    var _scissorMin = bbox_top + __scissorPadTop;
                    var _scissorMax = bbox_bottom - __scissorPadBottom;
                }
                else
                {
                    var _scissorMin = bbox_top;
                    var _scissorMax = bbox_bottom;
                }
                
                var _visibleSize = _scissorMax - _scissorMin;
                
                if (_bounds.height > _visibleSize - (__scrollPadTop + __scrollPadBottom))
                {
                    __scrollMinY = -((_bounds.height - _visibleSize) + __scrollPadBottom);
                    __scrollMaxY = __scrollPadTop;
                }
                else
                {
                    __scrollMinY = __scrollPadTop;
                    __scrollMaxY = __scrollPadTop;
                }
            }
            else
            {
                __scrollMinY = 0;
                __scrollMaxY = 0;
            }
            
            _newX = clamp(_oldX, __scrollMinX, __scrollMaxX);
            _newY = clamp(_oldY, __scrollMinY, __scrollMaxY);
        }
        else
        {
            //If we don't have any scrolling set up, reset to zeroes across the board
            
            _newX = 0;
            _newY = 0;
            
            __scrollMinX = 0;
            __scrollMinY = 0;
            __scrollMaxX = 0;
            __scrollMaxY = 0;
        }
        
        __GuiScrollApply(id, _newX - _oldX, _newY - _oldY);
    }
}