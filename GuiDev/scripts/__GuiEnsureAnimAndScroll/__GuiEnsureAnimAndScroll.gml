// Feather disable allry.

function __GuiEnsureAnimAndScroll()
{
    static _system = __GuiSystem();
    static _animAndScrollDirtyArray = __GuiSystem().__animAndScrollDirtyArray;
    
    if (array_length(_animAndScrollDirtyArray) <= 0) return;
    
    with(_system)
    {
        __GuiEnsureChildOrder();
        
        while(array_length(_animAndScrollDirtyArray) > 0)
        {
            __GuiEnsureAnimationInner(array_pop(_animAndScrollDirtyArray), 0, 0, 1, 1, 0, 1, 0);
        }
    }
}

function __GuiEnsureAnimationInner(_instance, _parentXOffset, _parentYOffset, _parentXScale, _parentYScale, _parentAngle, _parentCos, _parentSin)
{
    static _animAndScrollDirtyArray = __GuiSystem().__animAndScrollDirtyArray;
    
    with(_instance)
    {
        if (__animAndScrollDirty)
        {
            __animAndScrollDirty = false;
            
            var _index = array_get_index(_animAndScrollDirtyArray, id);
            if (_index >= 0) array_delete(_animAndScrollDirtyArray, _index, 1);
        }
        
        var _x0 = _parentXScale*__animXOffset;
        var _y0 = _parentYScale*__animYOffset;
        var _x  = _parentXOffset + _parentCos*_x0 - _parentSin*_y0;
        var _y  = _parentYOffset + _parentSin*_x0 + _parentCos*_y0;
        
        if (__animScaleForce)
        {
            var _xScale = __animXScale;
            var _yScale = __animYScale;
        }
        else
        {
            var _xScale = _parentXScale*__animXScale;
            var _yScale = _parentYScale*__animYScale;
        }
        
        var _angle = __animAngleForce? __animAngle : (_parentAngle + __animAngle);
        
        layoutLeft   = _x + __solvedLeft;
        layoutTop    = _y + __solvedTop;
        layoutWidth  = _xScale*__solvedWidth;
        layoutHeight = _yScale*__solvedHeight;
        layoutAngle  = _angle;
        
        event_user(GUI_USER_EVENT_REPOSITION);
        
        var _childArray = __childArray;
        if (array_length(_childArray) > 0)
        {
            var _cos =  dcos(_angle);
            var _sin = -dsin(_angle);
            
            _x += __scrollX;
            _y += __scrollY;
            
            var _childArray = __childArray;
            var _i = 0;
            repeat(array_length(_childArray))
            {
                __GuiEnsureAnimationInner(_childArray[_i], _x, _y, _xScale, _yScale, _angle, _cos, _sin);
                ++_i;
            }
        }
    }
}