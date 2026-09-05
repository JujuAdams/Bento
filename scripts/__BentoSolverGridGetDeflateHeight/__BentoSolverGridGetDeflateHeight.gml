// Feather disable all

function __BentoSolverGridGetDeflateHeight(_rootHeight)
{
    var _layoutHeightMin = __BentoParsePercentageString(__layoutHeightMin, _rootHeight);
    var _layoutHeightMax = __BentoParsePercentageString(__layoutHeightMax, _rootHeight);
    
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
    _minSize += __solverPadHeight + __layoutGutterY*(__gridMinRows-1);
    
    _deflateSize *= __gridTargetRows;
    _deflateSize += __solverPadHeight + __layoutGutterY*(__gridTargetRows-1);
    
    __solverChildrenDeflateHeight = _deflateSize;
    
    __solverMinHeight     = ((__layoutHeightResize == BENTO_RESIZE_INFLATE)? _layoutHeightMin : clamp(_minSize, _layoutHeightMin, _layoutHeightMax)) + __layoutMarginHeight;
    __solverDeflateHeight = clamp(_deflateSize, __solverMinHeight - __layoutMarginHeight, _layoutHeightMax) + __layoutMarginHeight;
    __solvedHeight        = clamp(((__layoutHeightResize == BENTO_RESIZE_NORMAL)? __BentoSolvertGetSafeHeight(_rootHeight) : _deflateSize) + __layoutMarginHeight, __solverMinHeight, _layoutHeightMax + __layoutMarginHeight);
}