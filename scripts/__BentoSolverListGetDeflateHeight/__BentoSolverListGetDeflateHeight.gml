// Feather disable all

function __BentoSolverListGetDeflateHeight()
{
    var _deflateSize = 0;
    var _minSize = 0;
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    
    if (__listAxis == BENTO_AXIS_Y)
    {
        //////
        // Major Axis - Add up sizes
        //////
        
        var _i = 0;
        repeat(_childCount)
        {
            var _child = _childArray[_i];
            _deflateSize += _child.__solverDeflateHeight;
            _minSize     += _child.__solverMinHeight;
            ++_i;
        }
        
        var _extra = __solverPadTop + __solverPadBottom + max(_childCount-1, 0)*__layoutGutterY;
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
            _deflateSize = max(_deflateSize, _child.__solverDeflateHeight);
            _minSize     = max(_minSize,     _child.__solverMinHeight);
            ++_i;
        }
        
        var _extra = __solverPadTop + __solverPadBottom;
    }
    
    _deflateSize += _extra
    _minSize += _extra;
    
    __solverChildrenDeflateHeight = _deflateSize;
    
    __solverMinHeight       = (__layoutHeightResize == BENTO_RESIZE_INFLATE)? __layoutHeightMin : clamp(_minSize, __layoutHeightMin, __layoutHeightMax);
    __solverDeflateHeight   = clamp(_deflateSize, __solverMinHeight, __layoutHeightMax);
    __solvedHeight          = clamp((__layoutHeightResize == BENTO_RESIZE_NORMAL)? __layoutHeightPref : _deflateSize, __solverMinHeight, __layoutHeightMax);
}