// Feather disable all

/// Manually moves the scroll offset.
/// 
/// @param [dX=0]
/// @param [dY=0]
/// @param [instance=id]

function GuiScrollMove(_dX = 0, _dY = 0, _instance = id)
{
    var _parent = __GuiScrollFindParent(_instance);
    if (not instance_exists(_parent)) return noone;
    
    with(_parent)
    {
        var _xScale = layoutWidth / max(1, __solvedWidth);
        var _yScale = layoutHeight / max(1, __solvedHeight);
        
        if ((_xScale == 0) || (_yScale == 0)) return _parent;
        
        var _cos =  dcos(-layoutAngle);
        var _sin = -dsin(-layoutAngle);
        
        //We need to transform the navigation delta into the local coordinate space of the UI element
        var _transformedDX = (_dX*_cos - _dY*_sin) / _xScale;
        var _transformedDY = (_dX*_sin + _dY*_cos) / _yScale;
        
        return GuiScrollMoveLocal(_transformedDX, _transformedDY);
    }
}