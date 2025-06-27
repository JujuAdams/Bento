// Feather disable all

/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureOffset()
{
    var _dirtyOffsetArray = __dirtyOffsetArray;
    if (array_length(_dirtyOffsetArray) <= 0) return;
    
    //Sort from newest instance to oldest instance. This will usually get the following loop to
    //execute from the most senior node to the most junior leaf.
    array_sort(_dirtyOffsetArray, function(_a, _b)
    {
        return -sign(_a.BENTO_VARS.__envIndex - _b.BENTO_VARS.__envIndex);
    });
    
    while(array_length(_dirtyOffsetArray) > 0)
    {
        var _element = array_shift(_dirtyOffsetArray);
        if (BentoExists(_element))
        {
            var _parent = _element.BENTO_VARS.__parent;
            if (not BentoExists(_parent))
            {
                //No parent, probably the root node?
                __BentoMarkScrollPosDirtyInner(_dirtyOffsetArray, _element,
                                             0, 0,
                                             -infinity, -infinity, infinity, infinity,
                                             BENTO_VISIBLE_FULL);
            }
            else
            {
                with(_parent.BENTO_VARS)
                {
                    //FIXME - Refactor to pass down the scissor parent
                    __BentoMarkScrollPosDirtyInner(_dirtyOffsetArray, _element,
                                                 __scrollX, __scrollY,
                                                 __scissorWorldLeft, __scissorWorldTop, __scissorWorldRight, __scissorWorldBottom,
                                                 __scissorVisibility);
                }
            }
        }
    }
}

/// @param dirtyOffsetArray
/// @param element
/// @param offsetX
/// @param offsetY
/// @param scissorLeft
/// @param scissorTop
/// @param scissorRight
/// @param scissorBottom
/// @param scissorVisibility

function __BentoMarkScrollPosDirtyInner(_dirtyOffsetArray, _element, _offsetX, _offsetY, _scissorL, _scissorT, _scissorR, _scissorB, _scissorVisibility)
{
    with(_element.BENTO_VARS)
    {
        if (__offsetDirty)
        {
            __offsetDirty = false;
            
            var _index = array_get_index(_dirtyOffsetArray, _element);
            if (_index >= 0) array_delete(_dirtyOffsetArray, _index, 1);
        }
        
        var _width  = __solvedWidth;
        var _height = __solvedHeight;
        
        //Calculate where our center is on the parent
        var _leftWorld   = __solvedLeft + __offsetX + _offsetX;
        var _topWorld    = __solvedTop  + __offsetY + _offsetY;
        var _rightWorld  = _leftWorld + _width;
        var _bottomWorld = _topWorld  + _height;
        
        //Ensure the UI element sits inside the root boundary before we transform
        if (__layoutClampInside)
        {
            var _rootBento    = __layer.__rootElement.BENTO_VARS;
            var _rootWidth  = _rootBento.__solvedWidth;
            var _rootHeight = _rootBento.__solvedHeight;
            
            if (_width <= _rootWidth)
            {
                var _deltaLeft  = max(0, -_leftWorld);
                var _deltaRight = min(0, _rootWidth - _rightWorld);
                var _deltaX     = (_deltaLeft > -_deltaRight)? _deltaLeft : _deltaRight;
            }
            else
            {
                var _deltaX = _leftWorld - 0.5*(_width - _rootWidth);
            }
            
            if (_height <= _rootHeight)
            {
                var _deltaTop    = max(0, -_topWorld);
                var _deltaBottom = min(0, _rootHeight - _bottomWorld);
                var _deltaY      = (_deltaTop > -_deltaBottom)? _deltaTop : _deltaBottom;
            }
            else
            {
                var _deltaY = _topWorld - 0.5*(_height - _rootHeight);
            }
            
            _leftWorld   += _deltaX;
            _topWorld    += _deltaY;
            _rightWorld  += _deltaX;
            _bottomWorld += _deltaY;
        }
        
        if (__layoutOriginAuto)
        {
            //If we're in auto mode, try to calculate the origin based on the instance's sprite
            var _sprite = __attachedElement.sprite_index;
            if (sprite_exists(_sprite))
            {
                var _xPerc = sprite_get_xoffset(_sprite) / sprite_get_width(_sprite);
                var _yPerc = sprite_get_yoffset(_sprite) / sprite_get_height(_sprite);
            }
            else
            {
                //Fall back on the default alignment if we have no sprite
                var _xPerc = BENTO_DEFAULT_LAYOUT_ALIGN_H;
                var _yPerc = BENTO_DEFAULT_LAYOUT_ALIGN_V;
            }
            
            var _xWorld = _leftWorld + _xPerc*_width;
            var _yWorld = _topWorld  + _yPerc*_height;
        }
        else
        {
            //Otherwise use the static layout origin
            var _xWorld = _leftWorld + __layoutOriginX;
            var _yWorld = _topWorld  + __layoutOriginY;
        }
        
        //Set final variables ready for the reposition user event
        with(_element)
        {
            bentoLeft   = _leftWorld;
            bentoTop    = _topWorld;
            bentoRight  = _rightWorld;
            bentoBottom = _bottomWorld;
            bentoX      = _xWorld;
            bentoY      = _yWorld;
            bentoWidth  = _width;
            bentoHeight = _height;
            
        }
        
        if (_scissorVisibility != BENTO_VISIBLE_NONE)
        {
            _scissorVisibility = rectangle_in_rectangle(_leftWorld, _topWorld, _rightWorld, _bottomWorld,
                                                        _scissorL, _scissorT, _scissorR, _scissorB);
        }
        
        if (__scissorEnabled)
        {
            _scissorL = max(_scissorL, _leftWorld   + __scissorPadLeft   + __scissorScrollbarLeft  );
            _scissorT = max(_scissorT, _topWorld    + __scissorPadTop    + __scissorScrollbarTop   );
            _scissorR = min(_scissorR, _rightWorld  - __scissorPadRight  - __scissorScrollbarRight );
            _scissorB = min(_scissorB, _bottomWorld - __scissorPadBottom - __scissorScrollbarBottom);
        }
        
        __scissorWorldLeft   = _scissorL;
        __scissorWorldTop    = _scissorT;
        __scissorWorldRight  = _scissorR;
        __scissorWorldBottom = _scissorB;
        __scissorVisibility  = _scissorVisibility;
        
        __eventReposition();
        
        //Pass values on to our children
        var _childArray = __childArray;
        if (array_length(_childArray) > 0)
        {
            _offsetX += __scrollX;
            _offsetY += __scrollY;
            
            var _childArray = __childArray;
            var _i = 0;
            repeat(array_length(_childArray))
            {
                __BentoMarkScrollPosDirtyInner(_dirtyOffsetArray, _childArray[_i], _offsetX, _offsetY, _scissorL, _scissorT, _scissorR, _scissorB, _scissorVisibility);
                ++_i;
            }
        }
    }
}