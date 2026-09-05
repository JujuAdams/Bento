// Feather disable all

function __BentoSolverGridGetDeflateWidth(_rootWidth)
{
    var _layoutWidthMin = __BentoParsePercentageString(__layoutWidthMin, _rootWidth);
    var _layoutWidthMax = __BentoParsePercentageString(__layoutWidthMax, _rootWidth);
    
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
    _minSize += __solverPadWidth + __layoutGutterX*(__gridMinColumns-1);
    
    _deflateSize *= __gridTargetColumns;
    _deflateSize += __solverPadWidth + __layoutGutterX*(__gridTargetColumns-1);
    
    __solverChildrenDeflateWidth = _deflateSize;
    
    __solverMinWidth     = ((__layoutWidthResize == BENTO_RESIZE_INFLATE)? _layoutWidthMin : clamp(_minSize, _layoutWidthMin, _layoutWidthMax)) + __layoutMarginWidth;
    __solverDeflateWidth = clamp(_deflateSize, __solverMinWidth - __layoutMarginWidth, _layoutWidthMax) + __layoutMarginWidth;
    __solvedWidth        = clamp(((__layoutWidthResize == BENTO_RESIZE_NORMAL)? __BentoSolverGetSafeWidth(_rootWidth) : _deflateSize) + __layoutMarginWidth, __solverMinWidth, _layoutWidthMax + __layoutMarginWidth);
}