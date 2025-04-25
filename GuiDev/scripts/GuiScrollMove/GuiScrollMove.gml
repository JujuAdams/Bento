// Feather disable all

/// Manually moves the scroll offset.
/// 
/// @param [dX=0]
/// @param [dY=0]
/// @param [scrollSpeed]
/// @param [instance=id]

function GuiScrollMove(_dX = 0, _dY = 0, _scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _instance = id)
{
    var _scroller = __GuiScrollFindParent(_instance);
    if (not instance_exists(_scroller)) return;
    
    with(_scroller)
    {
        var _xScale = layoutWidth / max(1, __gui.__solvedWidth);
        var _yScale = layoutHeight / max(1, __gui.__solvedHeight);
        
        if ((_xScale != 0) && (_yScale != 0))
        {
            var _cos =  dcos(-layoutAngle);
            var _sin = -dsin(-layoutAngle);
            
            //We need to transform the navigation delta into the local coordinate space of the UI element
            var _transformedDX = (_dX*_cos - _dY*_sin) / _xScale;
            var _transformedDY = (_dX*_sin + _dY*_cos) / _yScale;
            
            GuiScrollMoveLocal(_transformedDX, _transformedDY, _scrollSpeed, _scroller);
        }
    }
}