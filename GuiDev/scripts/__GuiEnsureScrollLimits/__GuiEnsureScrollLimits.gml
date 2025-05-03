// Feather disable all

/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureScrollLimits()
{
    array_foreach(__dirtyScrollLimitsArray, _funcApply);
    array_resize(__dirtyScrollLimitsArray, 0);
    
    static _funcApply = function(_parent)
    {
        if (not __GuiExists(_parent)) return;
        
        with(_parent.GUI_VARS)
        {
            if (not __scrollLimitsDirty) return;
            __scrollLimitsDirty = false;
            
            var _newX = __scrollX;
            var _newY = __scrollY;
            
            if (__scrollHori || __scrollVert)
            {
                //Only do hard work if we have to!
                
                //Calculate the physical bounds of the children of this parent. Positions are in world-space
                var _bounds = __GuiGetChildrenBounds(0, _parent);
                
                if (__scrollHori)
                {
                    //Calculate how much visible width we have to play with
                    var _visibleSize = __scissorEnabled? __solvedWidth - (__scissorPadLeft + __scissorPadRight) : __solvedWidth;
                    _visibleSize -= __layoutPadLeft + __layoutPadRight;
                    
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
                    var _visibleSize = __scissorEnabled? __solvedHeight - (__scissorPadTop + __scissorPadBottom) : __solvedHeight;
                    _visibleSize -= __layoutPadTop + __layoutPadBottom;
                    
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
                
                _newX = clamp(_newX, __scrollMinX, __scrollMaxX);
                _newY = clamp(_newY, __scrollMinY, __scrollMaxY);
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
            
            GuiScrollSet(_newX, _newY, undefined, _parent);
        }
    }
}