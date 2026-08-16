// Feather disable all

function __BentoSolverListGetDeflateWidth(_rootWidth)
{
    var _layoutWidthMin = __BentoParsePercentageString(__layoutWidthMin, _rootWidth);
    var _layoutWidthMax = __BentoParsePercentageString(__layoutWidthMax, _rootWidth);
    
    var _deflateSize = 0;
    var _minSize = 0;
    
    var _childArray = __layoutChildArray;
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
            _deflateSize += _child.__solverDeflateWidth;
            _minSize     += _child.__solverMinWidth;
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
            _deflateSize = max(_deflateSize, _child.__solverDeflateWidth);
            _minSize     = max(_minSize,     _child.__solverMinWidth);
            ++_i;
        }
        
        var _extra = __solverPadLeft + __solverPadRight;
    }
    
    _deflateSize += _extra;
    _minSize += _extra;
    
    __solverChildrenDeflateWidth = _deflateSize;
    
    __solverMinWidth     = ((__layoutWidthResize == BENTO_RESIZE_INFLATE)? _layoutWidthMin : clamp(_minSize, _layoutWidthMin, _layoutWidthMax)) + __layoutMarginWidth;
    __solverDeflateWidth = clamp(_deflateSize, __solverMinWidth, _layoutWidthMax) +  + __layoutMarginWidth;
    __solvedWidth        = clamp(((__layoutWidthResize == BENTO_RESIZE_NORMAL)? __BentoSolvertGetSafeWidth(_rootWidth) : _deflateSize) +  + __layoutMarginWidth, __solverMinWidth, _layoutWidthMax +  + __layoutMarginWidth);
    
    //Ensure we can never deflate lower than our fixed size
    if (__layoutWidthResize == BENTO_RESIZE_NORMAL)
    {
        __solverDeflateWidth = max(__solvedWidth, __solverDeflateWidth);
    }
}