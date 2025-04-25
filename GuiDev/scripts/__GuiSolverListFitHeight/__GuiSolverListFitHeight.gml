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
            _fitSize += _child.__gui.__solverFitHeight;
            _minSize += _child.__gui.__solverMinHeight;
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
            _fitSize = max(_fitSize, _child.__gui.__solverFitHeight);
            _minSize = max(_minSize, _child.__gui.__solverMinHeight);
            ++_i;
        }
        
        var _extra = __layoutPadTop + __layoutPadBottom;
    }
    
    _fitSize += _extra
    _minSize += _extra;
    
    __solvedHeight = clamp(max(_minSize, (__layoutHeightResize == GUI_RESIZE_FIT)? _fitSize : __layoutHeightPref),
                           __layoutHeightMin, __layoutHeightMax);
    
    __solverFitHeight = _fitSize;
    __solverMinHeight = _minSize;
}