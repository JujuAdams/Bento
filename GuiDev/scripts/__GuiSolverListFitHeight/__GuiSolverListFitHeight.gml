// Feather disable all

function __GuiSolverListFitHeight()
{
    var _fitSize = 0;
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
            _fitSize += _child.__solverFitHeight;
            _minSize += _child.__solverMinHeight;
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
            _fitSize = max(_fitSize, _child.__solverFitHeight);
            _minSize = max(_minSize, _child.__solverMinHeight);
            ++_i;
        }
        
        var _extra = __layoutPadTop + __layoutPadBottom;
    }
    
    _fitSize += _extra
    _minSize += _extra;
    
    if (__layoutHeightResize == GUI_RESIZE_FIT)
    {
        layoutHeight      = max(_minSize, min(_fitSize, __layoutHeightMax));
        __solverFitHeight = _fitSize;
    }
    else
    {
        layoutHeight      = max(_minSize, __layoutHeightPref);
        __solverFitHeight = layoutHeight;
    }
    
    __solverMinHeight = _minSize;
}