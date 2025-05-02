// Feather disable all

/// Sets the scroll offset.
/// 
/// @param scrollTargetX
/// @param scrollTargetY
/// @param [scrollSpeed]
/// @param [instance=id]

function GuiScrollSet(_scrollTargetX, _scrollTargetY, _scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _instance = id)
{
    var _scroller = __GuiScrollFindParent(_instance);
    if (not instance_exists(_scroller)) return;
    
    with(_scroller.GUI_STRUCT)
    {
        if (not __scrollHori) _scrollTargetX = 0;
        if (not __scrollVert) _scrollTargetY = 0;
        
        if ((_scrollTargetX == __scrollX) && (_scrollTargetY == __scrollY)) return;
        
        _scrollTargetX = clamp(_scrollTargetX, __scrollMinX, __scrollMaxX);
        _scrollTargetY = clamp(_scrollTargetY, __scrollMinY, __scrollMaxY);
        
        if ((_scrollTargetX == __scrollTargetX) && (_scrollTargetY == __scrollTargetY)) return;
        
        if (array_get_index(__environment.__scrollDirtyArray, _scroller) < 0)
        {
            array_push(__environment.__scrollDirtyArray, _scroller);
        }
        
        __scrollTargetX = _scrollTargetX;
        __scrollTargetY = _scrollTargetY;
        __scrollSpeed   = _scrollSpeed;
        
        __GuiMarkTransformAndScrollDirty(_scroller)
    }
}