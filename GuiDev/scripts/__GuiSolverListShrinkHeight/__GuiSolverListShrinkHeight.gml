// Feather disable all

function __GuiSolverListShrinkHeight()
{
    var _shrinkSize = 0;
    var _minSize = 0;
    
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    if (__listAxis == GUI_AXIS_Y)
    {
        //////
        // Major Axis - Add up sizes
        //////
        
        var _i = 0;
        repeat(_childCount)
        {
            var _child = _childArray[_i];
            _shrinkSize += _child.GUI_VARS.__solverShrinkHeight;
            _minSize += _child.GUI_VARS.__solverMinHeight;
            ++_i;
        }
        
        var _extra = __layoutPadTop + __layoutPadBottom + max(_childCount-1, 0)*__layoutGutterY;
    }
    else
    {
        //////
        // Minor Axis - Choose the maximum size
        //////
        
        var _i = 0;
        repeat(_childCount)
        {
            var _child = _childArray[_i];
            _shrinkSize = max(_shrinkSize, _child.GUI_VARS.__solverShrinkHeight);
            _minSize = max(_minSize, _child.GUI_VARS.__solverMinHeight);
            ++_i;
        }
        
        var _extra = __layoutPadTop + __layoutPadBottom;
    }
    
    _shrinkSize += _extra
    _minSize += _extra;
    
    __solverMinHeight    = max(__layoutHeightMin, _minSize);
    __solverShrinkHeight = clamp((__layoutHeightResize == GUI_RESIZE_SHRINK)? _shrinkSize : __solverPrefHeight, __solverMinHeight, __layoutHeightMax);
    __solvedHeight       = __solverShrinkHeight;
}