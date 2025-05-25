// Feather disable all

function __GuiSolverListShrinkWidth()
{
    var _shrinkSize = 0;
    var _minSize = 0;
    
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    if (__listAxis == GUI_AXIS_X)
    {
        //////
        // Major Axis - Add up sizes
        //////
        
        var _i = 0;
        repeat(_childCount)
        {
            var _child = _childArray[_i];
            _shrinkSize += _child.GUI_VARS.__solverShrinkWidth;
            _minSize += _child.GUI_VARS.__solverMinWidth;
            ++_i;
        }
        
        var _extra = __layoutPadLeft + __layoutPadRight + max(_childCount-1, 0)*__layoutGutterX;
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
            _shrinkSize = max(_shrinkSize, _child.GUI_VARS.__solverShrinkWidth);
            _minSize = max(_minSize, _child.GUI_VARS.__solverMinWidth);
            ++_i;
        }
        
        var _extra = __layoutPadLeft + __layoutPadRight;
    }
    
    _shrinkSize += _extra;
    _minSize += _extra;
    
    __solverMinWidth = max(__layoutWidthMin, _minSize);
    __solverShrinkWidth = clamp((__layoutWidthResize == GUI_RESIZE_SHRINK)? _shrinkSize : __layoutWidthPref, __solverMinWidth, __layoutWidthMax);
    __solvedWidth    = __solverShrinkWidth;
}