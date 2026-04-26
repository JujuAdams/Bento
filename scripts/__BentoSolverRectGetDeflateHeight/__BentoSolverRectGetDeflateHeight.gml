// Feather disable all

function __BentoSolverRectGetDeflateHeight()
{
    //Initialize with the rectangle's base properties
    var _deflateSize = clamp(__BentoSolvertGetSafeHeight(), __layoutHeightMin, __layoutHeightMax);
    var _minSize = (__layoutHeightMin > 0)? __layoutHeightMin : _deflateSize;
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    if (_childCount > 0)
    {
        var _i = 0;
        repeat(_childCount)
        {
            var _child = _childArray[_i];
            _deflateSize = max(_deflateSize, _child.__solverDeflateHeight);
            _minSize     = max(_minSize,     _child.__solverMinHeight);
            ++_i;
        }
        
        var _extra = __solverPadTop + __solverPadBottom;
        _deflateSize += _extra;
        _minSize     += _extra;
    }
    
    __solverMinHeight     = clamp(_minSize, __layoutHeightMin, __layoutHeightMax);
    __solverDeflateHeight = clamp(_deflateSize, __solverMinHeight, __layoutHeightMax);
    __solvedHeight        = clamp((__layoutHeightResize == BENTO_RESIZE_NORMAL)? __BentoSolvertGetSafeHeight() : _deflateSize, __solverMinHeight, __layoutHeightMax);
}