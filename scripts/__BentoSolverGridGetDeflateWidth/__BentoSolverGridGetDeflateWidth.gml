// Feather disable all

function __BentoSolverGridGetDeflateWidth()
{
    var _deflateSize = 0;
    var _minSize = 0;
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    
    var _i = 0;
    repeat(_childCount)
    {
        var _child = _childArray[_i];
        _minSize     = max(_minSize,     _child.__solverMinWidth);
        _deflateSize = max(_deflateSize, _child.__solverDeflateWidth);
        ++_i;
    }
    
    __solverCellMinWidth = _minSize;
    
    _minSize *= __gridMinColumns;
    _minSize += __solverPadLeft + __solverPadRight + __layoutGutterX*(__gridMinColumns-1);
    
    _deflateSize *= __gridTargetColumns;
    _deflateSize += __solverPadLeft + __solverPadRight + __layoutGutterX*(__gridTargetColumns-1);
    
    __solverChildrenDeflateWidth = _deflateSize;
    
    __solverMinWidth     = (__layoutWidthResize == BENTO_RESIZE_INFLATE)? __layoutWidthMin : clamp(_minSize, __layoutWidthMin, __layoutWidthMax);
    __solverDeflateWidth = clamp(_deflateSize, __solverMinWidth, __layoutWidthMax);
    __solvedWidth        = clamp((__layoutWidthResize == BENTO_RESIZE_NORMAL)? __layoutWidthPref : _deflateSize, __solverMinWidth, __layoutWidthMax);
}