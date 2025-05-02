// Feather disable all

/// Must be called in the scope of `__GuiClassEnvironment`.

function __GuiEnsureTransformAndScroll()
{
    var _scrollDirtyArray = __scrollDirtyArray;
    var _i = array_length(_scrollDirtyArray)-1;
    repeat(array_length(_scrollDirtyArray))
    {
        var _instance = _scrollDirtyArray[_i];
        if (not instance_exists(_instance))
        {
            array_delete(_scrollDirtyArray, _i, 1);
        }
        else
        {
            with(_instance.GUI_STRUCT)
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
                    
                    __GuiMarkTransformAndScrollDirty(_instance)
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
        var _instance = array_shift(_transformAndScrollDirtyArray);
        if (instance_exists(_instance))
        {
            var _parent = _instance.GUI_STRUCT.__parent;
            if (not instance_exists(_parent))
            {
                //No parent, probably the root node?
                __GuiEnsureTransformAndScrollInner(_transformAndScrollDirtyArray, _instance, 0, 0);
            }
            else
            {
                with(_parent)
                {
                    __GuiEnsureTransformAndScrollInner(_transformAndScrollDirtyArray, _instance, GUI_STRUCT.__scrollX, GUI_STRUCT.__scrollY);
                }
            }
        }
    }
}

function __GuiEnsureTransformAndScrollInner(_transformAndScrollDirtyArray, _instance, _offsetX, _offsetY)
{
    with(_instance.GUI_STRUCT)
    {
        var _width  = __solvedWidth;
        var _height = __solvedHeight;
        
        var _sprite = _instance.sprite_index;
        var _originX = _width*(sprite_exists(_sprite)? (sprite_get_xoffset(_sprite) / sprite_get_width(_sprite)) : GUI_FALLBACK_ORIGIN_X);
        var _originY = _height*(sprite_exists(_sprite)? (sprite_get_yoffset(_sprite) / sprite_get_height(_sprite)) : GUI_FALLBACK_ORIGIN_Y);
        
        //Calculate where our center is on the parent
        var _leftWorld   = __solvedLeft + _offsetX;
        var _topWorld    = __solvedTop  + _offsetY;
        var _rightWorld  = _leftWorld + _width;
        var _bottomWorld = _topWorld  + _height;
        
        //Ensure the UI element sits inside the root boundary before we transform
        if (__layoutClampInside)
        {
            var _rootGui    = GUI_ROOT.GUI_STRUCT;
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
            
            var _index = array_get_index(_transformAndScrollDirtyArray, _instance);
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
        with(_instance)
        {
            guiLeft   = _leftWorld;
            guiTop    = _topWorld;
            guiRight  = _rightWorld;
            guiBottom = _bottomWorld;
            guiX      = _xWorld;
            guiY      = _yWorld;
            guiWidth  = _width;
            guiHeight = _height;
            
            event_user(GUI_USER_EVENT_REPOSITION);
        }
        
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