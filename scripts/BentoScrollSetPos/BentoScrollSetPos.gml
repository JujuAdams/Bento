// Feather disable all

/// Sets the scroll target per axis, and the overall scroll speed. Bento will smoothly animate
/// towards the target. You may use a value of `undefined` for either axis to indicate that the
/// current value should not change.
/// 
/// @param [scrollTargetX]
/// @param [scrollTargetY]
/// @param [scrollSpeed=BENTO_DEFAULT_SCROLL_SPEED]
/// @param [element=self]

function BentoScrollSetPos(_scrollTargetX, _scrollTargetY, _scrollSpeed = BENTO_DEFAULT_SCROLL_SPEED, _element = self)
{
    var _scroller = __BentoScrollFindParent(_element);
    if (not BentoExists(_scroller)) return;
    
    with(_scroller.BENTO_VARS)
    {
        if (not __scrollHori) _scrollTargetX = 0;
        if (not __scrollVert) _scrollTargetY = 0;
        
        _scrollTargetX ??= __scrollX;
        _scrollTargetY ??= __scrollY;
        
        if ((_scrollTargetX == __scrollX) && (_scrollTargetY == __scrollY)) return;
        
        _scrollTargetX = clamp(_scrollTargetX, __scrollMinX, __scrollMaxX);
        _scrollTargetY = clamp(_scrollTargetY, __scrollMinY, __scrollMaxY);
        
        if ((_scrollTargetX == __scrollTargetX) && (_scrollTargetY == __scrollTargetY)) return;
        
        if (array_get_index(__layer.__scrollAnimatingArray, _scroller) < 0)
        {
            array_push(__layer.__scrollAnimatingArray, _scroller);
        }
        
        __scrollTargetX = _scrollTargetX;
        __scrollTargetY = _scrollTargetY;
        __scrollSpeed   = _scrollSpeed;
        
        //Mark our offset as dirty so we can update our children
        if (not __offsetDirty)
        {
            __offsetDirty = true;
            array_push(__layer.__dirtyOffsetArray, _scroller);
        }
    }
}