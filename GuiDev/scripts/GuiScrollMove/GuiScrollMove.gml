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
        var _xScale = guiWidth / max(1, GUI_STRUCT.__solvedWidth);
        var _yScale = guiHeight / max(1, GUI_STRUCT.__solvedHeight);
        
        if ((_xScale != 0) && (_yScale != 0))
        {
            var _cos =  dcos(-guiAngle);
            var _sin = -dsin(-guiAngle);
            
            //We need to transform the navigation delta into the local coordinate space of the UI element
            var _transformedDX = (_dX*_cos - _dY*_sin) / _xScale;
            var _transformedDY = (_dX*_sin + _dY*_cos) / _yScale;
            
            GuiScrollMoveLocal(_transformedDX, _transformedDY, _scrollSpeed, _scroller);
        }
    }
}