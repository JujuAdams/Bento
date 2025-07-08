// Feather disable all

function __BentoSolverListGetShrinkWidth()
{
    var _shrinkSize = 0;
    var _minSize = 0;
    
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    if (__listAxis == BENTO_AXIS_X)
    {
        //////
        // Major Axis - Add up sizes
        //////
        
        var _i = 0;
        repeat(_childCount)
        {
            var _child = _childArray[_i];
            _shrinkSize += _child.BENTO_VARS.__solverShrinkWidth;
            _minSize    += _child.BENTO_VARS.__solverMinWidth;
            ++_i;
        }
        
        var _extra = __solverPadLeft + __solverPadRight + max(_childCount-1, 0)*__layoutGutterX;
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
            _shrinkSize = max(_shrinkSize, _child.BENTO_VARS.__solverShrinkWidth);
            _minSize    = max(_minSize,    _child.BENTO_VARS.__solverMinWidth);
            ++_i;
        }
        
        var _extra = __solverPadLeft + __solverPadRight;
    }
    
    _shrinkSize += _extra;
    _minSize += _extra;
    
    __solverMinWidth    = max(__layoutWidthMin, _minSize);
    __solverShrinkWidth = clamp(_shrinkSize, __solverMinWidth, __layoutWidthMax);
    __solvedWidth       = clamp((__layoutWidthResize == BENTO_RESIZE_STATIC)? __layoutWidthPref : _shrinkSize, __solverMinWidth, __layoutWidthMax);
}