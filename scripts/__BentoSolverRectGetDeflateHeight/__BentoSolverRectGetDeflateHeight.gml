// Feather disable all

function __BentoSolverRectGetDeflateHeight(_rootHeight)
{
    var _layoutHeightMin = __BentoParsePercentageString(__layoutHeightMin, _rootHeight);
    var _layoutHeightMax = __BentoParsePercentageString(__layoutHeightMax, _rootHeight);
    
    //Initialize with the rectangle's base properties
    var _deflateSize = clamp(__BentoSolvertGetSafeHeight(_rootHeight), _layoutHeightMin, _layoutHeightMax);
    var _minSize = (_layoutHeightMin > 0)? _layoutHeightMin : _deflateSize;
    
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
        
        _deflateSize += __solverPadHeight;
        _minSize     += __solverPadHeight;
    }
    
    __solverMinHeight     = clamp(_minSize, _layoutHeightMin, _layoutHeightMax) + __layoutMarginHeight;
    __solverDeflateHeight = clamp(_deflateSize, __solverMinHeight, _layoutHeightMax) + __layoutMarginHeight;
    __solvedHeight        = clamp(((__layoutHeightResize == BENTO_RESIZE_NORMAL)? __BentoSolvertGetSafeHeight(_rootHeight) : _deflateSize) + __layoutMarginHeight, __solverMinHeight, _layoutHeightMax + __layoutMarginHeight);
}