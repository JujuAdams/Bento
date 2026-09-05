// Feather disable all

function __BentoSolverRectGetDeflateWidth(_rootWidth)
{
    var _layoutWidthMin = __BentoParsePercentageString(__layoutWidthMin, _rootWidth);
    var _layoutWidthMax = __BentoParsePercentageString(__layoutWidthMax, _rootWidth);
    
    //Initialize with the rectangle's base properties
    var _deflateSize = clamp(__BentoSolverGetSafeWidth(_rootWidth), _layoutWidthMin, _layoutWidthMax);
    var _minSize = (_layoutWidthMin > 0)? _layoutWidthMin : _deflateSize;
    
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
        
        _deflateSize += __solverPadWidth;
        _minSize     += __solverPadWidth;
    }
    
    __solverMinWidth     = clamp(_minSize, _layoutWidthMin, _layoutWidthMax) + __layoutMarginWidth;
    __solverDeflateWidth = clamp(_deflateSize, __solverMinWidth - __layoutMarginWidth, _layoutWidthMax) + __layoutMarginWidth;
    __solvedWidth        = clamp((__layoutWidthResize == BENTO_RESIZE_NORMAL)? __BentoSolverGetSafeWidth(_rootWidth) : _deflateSize, __solverMinWidth - __layoutMarginWidth, _layoutWidthMax) + __layoutMarginWidth;
}