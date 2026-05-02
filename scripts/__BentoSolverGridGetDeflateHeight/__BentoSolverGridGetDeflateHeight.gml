// Feather disable all

function __BentoSolverGridGetDeflateHeight()
{
    var _deflateSize = 0;
    var _minSize = 0;
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    
    var _i = 0;
    repeat(_childCount)
    {
        var _child = _childArray[_i];
        _minSize     = max(_minSize,     _child.__solverMinHeight);
        _deflateSize = max(_deflateSize, _child.__solverDeflateHeight);
        ++_i;
    }
    
    __solverCellMinHeight = _minSize;
    
    _minSize *= __gridMinRows;
    _minSize += __solverPadTop + __solverPadBottom + __layoutGutterY*(__gridMinRows-1);
    
    _deflateSize *= __gridTargetRows;
    _deflateSize += __solverPadTop + __solverPadBottom + __layoutGutterY*(__gridTargetRows-1);
    
    __solverChildrenDeflateHeight = _deflateSize;
    
    __solverMinHeight     = (__layoutHeightResize == BENTO_RESIZE_INFLATE)? __layoutHeightMin : clamp(_minSize, __layoutHeightMin, __layoutHeightMax);
    __solverDeflateHeight = clamp(_deflateSize, __solverMinHeight, __layoutHeightMax);
    __solvedHeight        = clamp((__layoutHeightResize == BENTO_RESIZE_NORMAL)? __layoutHeightPref : _deflateSize, __solverMinHeight, __layoutHeightMax);
}