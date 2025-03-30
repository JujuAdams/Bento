// Feather disable allry.

function __GuiEnsureAnimation()
{
    static _system = __GuiSystem();
    if (not _system.__animationDirty) return;
    
    with(_system)
    {
        __animationDirty = false;
        
        __GuiEnsureCorrectChildOrder();
        __GuiEnsureAnimationInner(GUI_ROOT, 0, 0, 1, 1, 0);
    }
}

function __GuiEnsureAnimationInner(_instance, _parentXOffset, _parentYOffset, _parentXScale, _parentYScale, _parentAngle)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        var _layoutWidth  = is_infinity(layoutWidth)? room_width : layoutWidth;
        var _layoutHeight = is_infinity(layoutHeight)? room_height : layoutHeight;
        
        var _dX  = _parentXScale*__animXOffset;
        var _dY  = _parentYScale*__animYOffset;
        var _cos =  dcos(_parentAngle);
        var _sin = -dsin(_parentAngle);
        var _x   = _parentXOffset + _cos*_dX - _sin*_dY;
        var _y   = _parentYOffset + _sin*_dX + _cos*_dX;
        
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
        
        image_xscale = _xScale * _layoutWidth/sprite_get_width(sprite_index);
        image_yscale = _yScale * _layoutHeight/sprite_get_height(sprite_index);
        x            = _x + layoutLeft + image_xscale*sprite_get_xoffset(sprite_index);
        y            = _y + layoutTop + image_yscale*sprite_get_yoffset(sprite_index);
        image_angle  = __animAngleForce? __animAngle : _parentAngle + __animAngle;
        
        var _childArray = __childArray;
        if (array_length(_childArray) > 0)
        {
            _x += __scrollX;
            _y += __scrollY;
            var _angle = image_angle;
            
            var _childArray = __childArray;
            var _i = 0;
            repeat(array_length(_childArray))
            {
                __GuiEnsureAnimationInner(_childArray[_i], _x, _y, _xScale, _yScale, _angle);
                ++_i;
            }
        }
    }
}