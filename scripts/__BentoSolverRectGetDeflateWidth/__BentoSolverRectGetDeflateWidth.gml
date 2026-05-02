// Feather disable all

function __BentoSolverRectGetDeflateWidth()
{
    //Initialize with the rectangle's base properties
    var _deflateSize = clamp(__BentoSolvertGetSafeWidth(), __layoutWidthMin, __layoutWidthMax);
    var _minSize = (__layoutWidthMin > 0)? __layoutWidthMin : _deflateSize;
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    if (_childCount > 0)
    {
        var _i = 0;
        repeat(_childCount)
        {
            var _child = _childArray[_i];
            _deflateSize = max(_deflateSize, _child.__solverDeflateWidth);
            _minSize     = max(_minSize,     _child.__solverMinWidth);
            ++_i;
        }
        
        var _extra = __solverPadTop + __solverPadBottom;
        _deflateSize += _extra;
        _minSize     += _extra;
    }
    
    __solverMinWidth     = clamp(_minSize, __layoutWidthMin, __layoutWidthMax);
    __solverDeflateWidth = clamp(_deflateSize, __solverMinWidth, __layoutWidthMax);
    __solvedWidth        = clamp((__layoutWidthResize == BENTO_RESIZE_NORMAL)? __BentoSolvertGetSafeWidth() : _deflateSize, __solverMinWidth, __layoutWidthMax);
}