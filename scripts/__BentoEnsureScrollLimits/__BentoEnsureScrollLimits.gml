// Feather disable all

/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureScrollLimits()
{
    array_foreach(__dirtyScrollLimitsArray, _funcApply);
    array_resize(__dirtyScrollLimitsArray, 0);
    
    static _funcApply = function(_parent)
    {
        if (not BentoExists(_parent)) return;
        
        with(_parent.BENTO_VARS)
        {
            if (not __scrollLimitsDirty) return;
            __scrollLimitsDirty = false;
            
            var _newX = __scrollX;
            var _newY = __scrollY;
            
            if (__scrollHori || __scrollVert)
            {
                //Only do hard work if we have to!
                
                //Calculate the physical bounds of the children of this parent. Positions are in world-space
                var _bounds = __BentoGetChildrenBounds(0, _parent);
                __scrollContentWidth  = _bounds.width;
                __scrollContentHeight = _bounds.height;
                
                if (__scrollHori)
                {
                    //Calculate how much visible width we have to play with
                    __scrollVisibleWidth = __scissorEnabled? (__solvedWidth - (__scissorPadLeft + __scissorPadRight + __scissorScrollbarLeft + __scissorScrollbarRight)) : __solvedWidth;
                    __scrollVisibleWidth -= __layoutPadLeft + __layoutPadRight;
                    
                    //Compare the children's width to the total scrollable area
                    if (__scrollContentWidth > __scrollVisibleWidth - (__scrollPadLeft + __scrollPadRight))
                    {
                        //Children overlow, set up limits
                        __scrollMinX = -((__scrollContentWidth - __scrollVisibleWidth) + __scrollPadRight);
                        __scrollMaxX = __scrollPadLeft;
                        
                        //Correct for child alignment
                        var _dX = (__scissorEnabled? __scissorPadLeft : 0) + __layoutPadLeft + (__solvedLeft - _bounds.left);
                        __scrollMinX += _dX;
                        __scrollMaxX += _dX;
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
                    __scrollVisibleHeight = __scissorEnabled? (__solvedHeight - (__scissorPadTop + __scissorPadBottom + __scissorScrollbarTop + __scissorScrollbarBottom)) : __solvedHeight;
                    __scrollVisibleHeight -= __layoutPadTop + __layoutPadBottom;
                    
                    if (__scrollContentHeight > __scrollVisibleHeight - (__scrollPadTop + __scrollPadBottom))
                    {
                        __scrollMinY = -((__scrollContentHeight - __scrollVisibleHeight) + __scrollPadBottom);
                        __scrollMaxY = __scrollPadTop;
                        
                        //Correct for child alignment
                        var _dY = (__scissorEnabled? __scissorPadTop : 0) + __layoutPadTop + (__solvedTop - _bounds.top);
                        __scrollMinY += _dY;
                        __scrollMaxY += _dY;
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
                
                __scrollMinX  = 0;
                __scrollMinY  = 0;
                __scrollMaxX  = 0;
                __scrollMaxY  = 0;
                
                __scrollContentWidth  = 0;
                __scrollContentHeight = 0;
                __scrollVisibleWidth  = 0;
                __scrollVisibleHeight = 0;
            }
            
            BentoScrollSetPos(_newX, _newY, infinity, _parent);
        }
    }
}