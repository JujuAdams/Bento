// Feather disable all

function __BentoSolverListGetDeflateHeight()
{
    var _layoutHeightMin = __BentoParsePercentageString(__layoutHeightMin, display_get_gui_height());
    var _layoutHeightMax = __BentoParsePercentageString(__layoutHeightMax, display_get_gui_height());
    
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
    
    __solverMinHeight       = (__layoutHeightResize == BENTO_RESIZE_INFLATE)? _layoutHeightMin : clamp(_minSize, _layoutHeightMin, _layoutHeightMax);
    __solverDeflateHeight   = clamp(_deflateSize, __solverMinHeight, _layoutHeightMax);
    __solvedHeight          = clamp((__layoutHeightResize == BENTO_RESIZE_NORMAL)? __BentoSolvertGetSafeHeight() : _deflateSize, __solverMinHeight, _layoutHeightMax);
    
    //Ensure we can never deflate lower than our fixed size
    if (__layoutWidthResize == BENTO_RESIZE_NORMAL)
    {
        __solverDeflateHeight = max(__solvedHeight, __solverDeflateHeight);
    }
}