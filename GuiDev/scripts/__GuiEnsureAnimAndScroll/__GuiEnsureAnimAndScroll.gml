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
            with(_instance.__gui)
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
                var _parent = _instance.__gui.__parent;
                if (not instance_exists(_parent))
                {
                    //No parent, probably the root node?
                    __GuiEnsureAnimationInner(_instance, 0, 0, 1, 1, 0, 0, 0);
                }
                else
                {
                    with(_parent)
                    {
                        __GuiEnsureAnimationInner(_instance,
                                                  guiX, guiY,
                                                  guiWidth / max(1, __gui.__solvedWidth), guiHeight / max(1, __gui.__solvedHeight), guiAngle,
                                                  __GuiEnsureAnimationGetOriginX(_parent) - __gui.__scrollX, __GuiEnsureAnimationGetOriginY(_parent) - __gui.__scrollY);
                    }
                }
            }
        }
    }
}

function __GuiEnsureAnimationInner(_instance, _parentX, _parentY, _parentXScale, _parentYScale, _parentAngle, _parentOriginX, _parentOriginY)
{
    static _animAndScrollDirtyArray = __GuiSystem().__animAndScrollDirtyArray;
    
    with(_instance.__gui)
    {
        if (__animAndScrollDirty)
        {
            __animAndScrollDirty = false;
            
            var _index = array_get_index(_animAndScrollDirtyArray, _instance);
            if (_index >= 0) array_delete(_animAndScrollDirtyArray, _index, 1);
        }
        
        var _xOrigin = __GuiEnsureAnimationGetOriginX(_instance);
        var _yOrigin = __GuiEnsureAnimationGetOriginY(_instance);
        
        //Calculate where our center is on the parent
        var _xCenterLocal = __solvedLeftLocal + __animOffsetX + _xOrigin - _parentOriginX;
        var _yCenterLocal = __solvedTopLocal  + __animOffsetY + _yOrigin - _parentOriginY;
        
        //Transform our central point based on the parent's transform
        //TODO - Optimize
        var _cos =  dcos(_parentAngle);
        var _sin = -dsin(_parentAngle);
        
        var _x = _cos*_parentXScale*_xCenterLocal - _sin*_parentYScale*_yCenterLocal;
        var _y = _sin*_parentXScale*_xCenterLocal + _cos*_parentYScale*_yCenterLocal;
        
        _x += _parentX;
        _y += _parentY;
        
        //Calculate our own scaling factor and angle
        if (__animScaleForce)
        {
            var _xScale = __animScaleX;
            var _yScale = __animScaleY;
        }
        else
        {
            var _xScale = __animScaleX*_parentXScale;
            var _yScale = __animScaleY*_parentYScale;
        }
        
        var _angle = __animAngleForce? __animAngle : (__animAngle + _parentAngle);
        
        //Set final variables ready for the reposition user event
        with(_instance)
        {
            guiX      = _x;
            guiY      = _y;
            guiWidth  = _xScale*other.__solvedWidth;
            guiHeight = _yScale*other.__solvedHeight;
            guiAngle  = _angle;
            
            event_user(GUI_USER_EVENT_REPOSITION);
        }
        
        //Pass values on to our children
        var _childArray = __childArray;
        if (array_length(_childArray) > 0)
        {
            _xOrigin -= __scrollX;
            _yOrigin -= __scrollY;
            
            var _childArray = __childArray;
            var _i = 0;
            repeat(array_length(_childArray))
            {
                __GuiEnsureAnimationInner(_childArray[_i], _x, _y, _xScale, _yScale, _angle, _xOrigin, _yOrigin);
                ++_i;
            }
        }
    }
}

function __GuiEnsureAnimationGetOriginX(_instance)
{
    with(_instance)
    {
        var _originProportion = __gui.__animOriginX;
        
        if (_originProportion != undefined)
        {
            return _originProportion*__gui.__solvedWidth;
        }
        
        if (sprite_exists(sprite_index))
        {
            return (sprite_get_xoffset(sprite_index) / sprite_get_width(sprite_index))*__gui.__solvedWidth;
        }
        else
        {
            return GUI_FALLBACK_ORIGIN_X*__gui.__solvedWidth;
        }
    }
}

function __GuiEnsureAnimationGetOriginY(_instance)
{
    with(_instance)
    {
        var _originProportion = __gui.__animOriginY;
        
        if (_originProportion != undefined)
        {
            return _originProportion*__gui.__solvedHeight;
        }
        
        if (sprite_exists(sprite_index))
        {
            return (sprite_get_yoffset(sprite_index) / sprite_get_height(sprite_index))*__gui.__solvedHeight;
        }
        else
        {
            return GUI_FALLBACK_ORIGIN_Y*__gui.__solvedHeight;
        }
    }
}