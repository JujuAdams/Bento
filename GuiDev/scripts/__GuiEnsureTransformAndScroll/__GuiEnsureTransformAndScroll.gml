// Feather disable all

/// Must be called in the scope of `__GuiClassLayer`.

function __GuiEnsureTransformAndScroll()
{
    var _scrollDirtyArray = __scrollDirtyArray;
    var _i = array_length(_scrollDirtyArray)-1;
    repeat(array_length(_scrollDirtyArray))
    {
        var _element = _scrollDirtyArray[_i];
        if (not __GuiExists(_element))
        {
            array_delete(_scrollDirtyArray, _i, 1);
        }
        else
        {
            with(_element.GUI_VARS)
            {
                var _dX = __scrollTargetX - __scrollX;
                var _dY = __scrollTargetY - __scrollY;
                
                var _distance = sqrt(_dX*_dX + _dY*_dY);
                if (_distance <= 0)
                {
                    array_delete(_scrollDirtyArray, _i, 1);
                }
                else
                {
                    _dX *= min(1, min(999999, __scrollSpeed) / _distance);
                    _dY *= min(1, min(999999, __scrollSpeed) / _distance);
                    
                    __scrollX += _dX;
                    __scrollY += _dY;
                    
                    __GuiMarkTransformAndScrollDirty(_element)
                }
            }
        }
        
        --_i;
    }
    
    var _transformAndScrollDirtyArray = __transformAndScrollDirtyArray;
    if (array_length(_transformAndScrollDirtyArray) <= 0) return;
    
    __GuiEnsureChildOrder();
    
    //Sort from newest instance to oldest instance. This will usually get the following loop to
    //execute from the most senior node to the most junior leaf.
    array_sort(_transformAndScrollDirtyArray, true);
    
    while(array_length(_transformAndScrollDirtyArray) > 0)
    {
        var _element = array_shift(_transformAndScrollDirtyArray);
        if (__GuiExists(_element))
        {
            var _parent = _element.GUI_VARS.__parent;
            if (not __GuiExists(_parent))
            {
                //No parent, probably the root node?
                __GuiEnsureTransformAndScrollInner(_transformAndScrollDirtyArray, _element, 0, 0);
            }
            else
            {
                with(_parent)
                {
                    __GuiEnsureTransformAndScrollInner(_transformAndScrollDirtyArray, _element, GUI_VARS.__scrollX, GUI_VARS.__scrollY);
                }
            }
        }
    }
}

function __GuiEnsureTransformAndScrollInner(_transformAndScrollDirtyArray, _element, _offsetX, _offsetY)
{
    with(_element.GUI_VARS)
    {
        var _width  = __solvedWidth;
        var _height = __solvedHeight;
        
        var _ratioW = (_width  / max(1, __layoutWidthPref)); //FIXME - This divisor value should be the *actual* preferred width used in layout calculations
        var _ratioH = (_height / max(1, __layoutHeightPref));
        
        if (__GuiIsInstance(_element))
        {
            var _sprite = _element.sprite_index;
            
            if (__layoutOriginX == undefined) 
            {
                var _originX = sprite_exists(_sprite)? (_ratioW * sprite_get_xoffset(_sprite)) : GUI_FALLBACK_ORIGIN_PERCENTAGE_X;
            }
            else
            {
                var _originX = __layoutOriginPerc? _width*__layoutOriginX : (_ratioW*__layoutOriginX);
            }
            
            if (__layoutOriginY == undefined)
            {
                var _originY = sprite_exists(_sprite)? (_ratioH * sprite_get_yoffset(_sprite)) : GUI_FALLBACK_ORIGIN_PERCENTAGE_Y;
            }
            else
            {
                var _originY = __layoutOriginPerc? _height*_layoutOriginY : (_ratioH*__layoutOriginY);
            }
        }
        else
        {
            if (__layoutOriginX == undefined)
            {
                var _originX = GUI_FALLBACK_ORIGIN_PERCENTAGE_X;
            }
            else
            {
                var _originX = __layoutOriginPerc? _width*__layoutOriginX : (_ratioW*__layoutOriginX);
            }
            
            if (__layoutOriginY == undefined)
            {
                var _originY = GUI_FALLBACK_ORIGIN_PERCENTAGE_Y;
            }
            else
            {
                var _originY = __layoutOriginPerc? _height*__layoutOriginY : (_ratioH*__layoutOriginY);
            }
        }
        
        //Calculate where our center is on the parent
        var _leftWorld   = __solvedLeft + _offsetX;
        var _topWorld    = __solvedTop  + _offsetY;
        var _rightWorld  = _leftWorld + _width;
        var _bottomWorld = _topWorld  + _height;
        
        //Ensure the UI element sits inside the root boundary before we transform
        if (__layoutClampInside)
        {
            var _rootGui    = __layer.__rootElement.GUI_VARS;
            var _rootWidth  = _rootGui.__solvedWidth;
            var _rootHeight = _rootGui.__solvedHeight;
            
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
        
        var _xWorld = _leftWorld + _originX;
        var _yWorld = _topWorld  + _originY;
        
        if (__transformAndScrollDirty)
        {
            __transformAndScrollDirty = false;
            
            var _index = array_get_index(_transformAndScrollDirtyArray, _element);
            if (_index >= 0) array_delete(_transformAndScrollDirtyArray, _index, 1);
            
            if ((__transformOffsetX != 0) || (__transformOffsetY != 0)
             || (__transformScaleX  != 1) || (__transformScaleY  != 1)
             || (__transformAngle   != 0)
             || (__transformOriginX != undefined) || (__transformOriginY != undefined))
            {
                var _originX = _leftWorld + (__transformOriginX ?? _originX);
                var _originY = _topWorld  + (__transformOriginY ?? _originY);
                
                var _cos =  dcos(__transformAngle);
                var _sin = -dsin(__transformAngle);
                
                __transformMatrix = [ __transformScaleX*_cos, __transformScaleX*_sin, 0, 0,
                                     -__transformScaleY*_sin, __transformScaleY*_cos, 0, 0,
                                      0, 0, 1, 0,
                                      _originX - (_originX*__transformScaleX*_cos - _originY*__transformScaleY*_sin), _originY - (_originX*__transformScaleX*_sin + _originY*__transformScaleY*_cos), 0, 1];
            }
            else
            {
                __transformMatrix = undefined;
            }
        }
        
        //Set final variables ready for the reposition user event
        with(_element)
        {
            guiLeft   = _leftWorld;
            guiTop    = _topWorld;
            guiRight  = _rightWorld;
            guiBottom = _bottomWorld;
            guiX      = _xWorld;
            guiY      = _yWorld;
            guiWidth  = _width;
            guiHeight = _height;
        }
        
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
                __GuiEnsureTransformAndScrollInner(_transformAndScrollDirtyArray, _childArray[_i], _offsetX, _offsetY);
                ++_i;
            }
        }
    }
}