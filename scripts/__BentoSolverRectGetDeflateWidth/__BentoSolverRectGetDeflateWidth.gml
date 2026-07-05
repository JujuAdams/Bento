// Feather disable all

function __BentoSolverRectGetDeflateWidth()
{
    var _layoutWidthMin = __BentoParsePercentageString(__layoutWidthMin, display_get_gui_width());
    var _layoutWidthMax = __BentoParsePercentageString(__layoutWidthMax, display_get_gui_width());
    
    //Initialize with the rectangle's base properties
    var _deflateSize = clamp(__BentoSolvertGetSafeWidth(), _layoutWidthMin, _layoutWidthMax);
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
        
        var _extra = __solverPadTop + __solverPadBottom;
        _deflateSize += _extra;
        _minSize     += _extra;
    }
    
    __solverMinWidth     = clamp(_minSize, _layoutWidthMin, _layoutWidthMax);
    __solverDeflateWidth = clamp(_deflateSize, __solverMinWidth, _layoutWidthMax);
    __solvedWidth        = clamp((__layoutWidthResize == BENTO_RESIZE_NORMAL)? __BentoSolvertGetSafeWidth() : _deflateSize, __solverMinWidth, _layoutWidthMax);
}