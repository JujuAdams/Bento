// Feather disable all

function __GuiSolverListFitWidth()
{
    var _fitSize = 0;
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
            _fitSize += _child.GUI_STRUCT.__solverFitWidth;
            _minSize += _child.GUI_STRUCT.__solverMinWidth;
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
            _fitSize = max(_fitSize, _child.GUI_STRUCT.__solverFitWidth);
            _minSize = max(_minSize, _child.GUI_STRUCT.__solverMinWidth);
            ++_i;
        }
        
        var _extra = __layoutPadLeft + __layoutPadRight;
    }
    
    _fitSize += _extra;
    _minSize += _extra;
    
    __solverMinWidth = max(__layoutWidthMin, _minSize);
    __solverFitWidth = clamp((__layoutWidthResize == GUI_RESIZE_FIT)? _fitSize : __layoutWidthPref, __solverMinWidth, __layoutWidthMax);
    __solvedWidth    = __solverFitWidth;
}