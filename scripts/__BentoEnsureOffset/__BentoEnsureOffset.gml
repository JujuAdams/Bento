// Feather disable all

/// Must be called in the scope of `__BentoClassLayer`.

function __BentoEnsureOffset()
{
    var _dirtyOffsetArray = __dirtyOffsetArray;
    if (array_length(_dirtyOffsetArray) <= 0) return;
    
    //Sort from newest element to oldest element. This will usually get the following loop to
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
                __BentoEnsureOffsetInner(_dirtyOffsetArray, _element.BENTO_VARS,
                                         0, 0,
                                         _element.BENTO_VARS, -infinity, -infinity, infinity, infinity);
            }
            else
            {
                with(_parent.BENTO_VARS)
                {
                    var _scissorParent = __scissorParent;
                    __BentoEnsureOffsetInner(_dirtyOffsetArray, _element.BENTO_VARS,
                                             __scrollCumulativeX, __scrollCumulativeY,
                                             _scissorParent, _scissorParent.__scissorWorldLeft, _scissorParent.__scissorWorldTop, _scissorParent.__scissorWorldRight, _scissorParent.__scissorWorldBottom);
                }
            }
        }
    }
}

/// @param dirtyOffsetArray
/// @param elementVars
/// @param offsetX
/// @param offsetY
/// @param scissorParent
/// @param scissorLeft
/// @param scissorTop
/// @param scissorRight
/// @param scissorBottom

function __BentoEnsureOffsetInner(_dirtyOffsetArray, _elementVars, _offsetX, _offsetY, _scissorParent, _scissorL, _scissorT, _scissorR, _scissorB)
{
    with(_elementVars)
    {
        var _element = __attachedElement;
        
        if (__offsetDirty)
        {
            __offsetDirty = false;
            
            var _index = array_get_index(_dirtyOffsetArray, _element);
            if (_index >= 0) array_delete(_dirtyOffsetArray, _index, 1);
        }
        
        var _width  = __solvedWidth;
        var _height = __solvedHeight;
        
        //Add our offset contribution
        _offsetX += __offsetX;
        _offsetY += __offsetY;
        
        //Calculate where our center is on the parent
        var _leftWorld   = __solvedLeft + _offsetX;
        var _topWorld    = __solvedTop  + _offsetY;
        var _rightWorld  = _leftWorld + _width;
        var _bottomWorld = _topWorld  + _height;
        
        //Ensure the element sits inside the root boundary before we transform
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
        
        //Set final variables ready for the reposition user event
        with(_element)
        {
            bentoLeft   = _leftWorld;
            bentoTop    = _topWorld;
            bentoRight  = _rightWorld;
            bentoBottom = _bottomWorld;
            bentoWidth  = _width;
            bentoHeight = _height;
            
            __BentoUpdateElementXY();
        }
        
        __scissorParent = _scissorParent;
        __scissorVisibility = rectangle_in_rectangle(_leftWorld, _topWorld, _rightWorld, _bottomWorld,
                                                     _scissorL, _scissorT, _scissorR, _scissorB);
        
        if (__scissorEnabled)
        {
            _scissorL = max(_scissorL, _leftWorld   + __scissorPadLeft   + __scissorScrollbarLeft  );
            _scissorT = max(_scissorT, _topWorld    + __scissorPadTop    + __scissorScrollbarTop   );
            _scissorR = min(_scissorR, _rightWorld  - __scissorPadRight  - __scissorScrollbarRight );
            _scissorB = min(_scissorB, _bottomWorld - __scissorPadBottom - __scissorScrollbarBottom);
            
            __scissorWorldLeft   = _scissorL;
            __scissorWorldTop    = _scissorT;
            __scissorWorldRight  = _scissorR;
            __scissorWorldBottom = _scissorB;
            
            _scissorParent = self;
        }
        
        __eventReposition();
        
        //Pass values on to our children
        var _childArray = __childArray;
        if (array_length(_childArray) > 0)
        {
            _offsetX += __scrollX;
            _offsetY += __scrollY;
            
            __scrollCumulativeX = _offsetX;
            __scrollCumulativeY = _offsetY;
            
            var _childArray = __childArray;
            var _i = 0;
            repeat(array_length(_childArray))
            {
                __BentoEnsureOffsetInner(_dirtyOffsetArray, _childArray[_i], _offsetX, _offsetY, _scissorParent, _scissorL, _scissorT, _scissorR, _scissorB);
                ++_i;
            }
        }
    }
}