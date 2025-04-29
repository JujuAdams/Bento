// Feather disable allry.

function __GuiEnsureAnimAndScroll()
{
    static _system                  = __GuiSystem();
    static _scrollDirtyArray        = _system.__scrollDirtyArray;
    static _animAndScrollDirtyArray = _system.__animAndScrollDirtyArray;
    
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
                    
                    __GuiMarkAnimAndScrollDirty(_instance)
                }
            }
        }
        
        --_i;
    }
    
    if (array_length(_animAndScrollDirtyArray) <= 0) return;
    
    with(_system)
    {
        __GuiEnsureChildOrder();
        
        //Sort from newest instance to oldest instance. This will usually get the following loop to
        //execute from the most senior node to the most junior leaf.
        array_sort(_animAndScrollDirtyArray, true);
        
        while(array_length(_animAndScrollDirtyArray) > 0)
        {
            var _instance = array_shift(_animAndScrollDirtyArray);
            if (instance_exists(_instance))
            {
                var _parent = _instance.GUI_STRUCT.__parent;
                if (not instance_exists(_parent))
                {
                    //No parent, probably the root node?
                    __GuiEnsureAnimationInner(_instance, 0, 0);
                }
                else
                {
                    with(_parent)
                    {
                        __GuiEnsureAnimationInner(_instance, GUI_STRUCT.__scrollX, GUI_STRUCT.__scrollY);
                    }
                }
            }
        }
    }
}

function __GuiEnsureAnimationInner(_instance, _offsetX, _offsetY)
{
    static _animAndScrollDirtyArray = __GuiSystem().__animAndScrollDirtyArray;
    
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
        
        if (__animAndScrollDirty)
        {
            __animAndScrollDirty = false;
            
            var _index = array_get_index(_animAndScrollDirtyArray, _instance);
            if (_index >= 0) array_delete(_animAndScrollDirtyArray, _index, 1);
            
            if ((__animOffsetX != 0) || (__animOffsetY != 0)
             || (__animScaleX  != 1) || (__animScaleY  != 1)
             || (__animAngle   != 0)
             || (__animOriginX != undefined) || (__animOriginY != undefined))
            {
                var _originX = _leftWorld + (__animOriginX ?? _originX);
                var _originY = _topWorld  + (__animOriginY ?? _originY);
                
                var _cos =  dcos(__animAngle);
                var _sin = -dsin(__animAngle);
                
                __animMatrix = [ __animScaleX*_cos, __animScaleX*_sin, 0, 0,
                                -__animScaleY*_sin, __animScaleY*_cos, 0, 0,
                                 0, 0, 1, 0,
                                 _originX - (_originX*__animScaleX*_cos - _originY*__animScaleY*_sin), _originY - (_originX*__animScaleX*_sin + _originY*__animScaleY*_cos), 0, 1];
            }
            else
            {
                __animMatrix = undefined;
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
                __GuiEnsureAnimationInner(_childArray[_i], _offsetX, _offsetY);
                ++_i;
            }
        }
    }
}