// Feather disable all

function __BentoSolverTableGetDeflateHeight(_rootHeight)
{
    var _layoutHeightMin = __BentoParsePercentageString(__layoutHeightMin, _rootHeight);
    var _layoutHeightMax = __BentoParsePercentageString(__layoutHeightMax, _rootHeight);
    
    var _childArray   = __layoutChildArray;
    var _childCount   = array_length(_childArray);
    var _tableColumns = __tableColumns;
    var _tableRows    = ceil(_childCount / _tableColumns);
    
    //Make arrays for each row
    //TODO - Can these be allocated when setting the table layout ruleset?
    __layoutTableMinHeight     = array_create(_tableRows, 0);
    __layoutTableDeflateHeight = array_create(_tableRows, 0);
    __layoutTableSolvedHeight  = array_create(_tableRows, 0);
    
    //Choose the maximum size per row
    var _i = 0;
    repeat(_childCount)
    {
        var _child = _childArray[_i];
        
        var _row = _i div _tableColumns;
        __layoutTableDeflateHeight[@ _row] = max(__layoutTableDeflateHeight[_row], _child.__solverDeflateHeight);
        __layoutTableMinHeight[@     _row] = max(__layoutTableMinHeight[    _row], _child.__solverMinHeight    );
        
        ++_i;
    }
    
    array_copy(__layoutTableSolvedHeight, 0, __layoutTableDeflateHeight, 0, _tableRows);
    
    //Sum the heights of the rows to give the overall height of the table
    var _deflateSize = 0;
    var _minSize = 0;
    
    var _i = 0;
    repeat(_tableRows)
    {
        _deflateSize += __layoutTableDeflateHeight[_i];
        _minSize += __layoutTableMinHeight[_i];
        
        ++_i;
    }
    
    //Add gutters and padding
    var _extra = max(_tableColumns-1, 0)*__layoutGutterY + __solverPadHeight; //TODO - Should padding be around each element?
    _deflateSize += _extra;
    _minSize     += _extra;
    
    __solverChildrenDeflateHeight = _deflateSize;
    
    __solverMinHeight       = clamp(_minSize, _layoutHeightMin, _layoutHeightMax) + __layoutMarginHeight;
    __solverDeflateHeight   = clamp(_deflateSize, __solverMinHeight - __layoutMarginHeight, _layoutHeightMax) + __layoutMarginHeight;
    __solvedHeight          = clamp(((__layoutHeightResize == BENTO_RESIZE_NORMAL)? __BentoSolvertGetSafeHeight(_rootHeight, _deflateSize) : _deflateSize) + __layoutMarginHeight, __solverMinHeight, _layoutHeightMax + __layoutMarginHeight);
    
    //Ensure we can never deflate lower than our fixed size
    if (__layoutWidthResize == BENTO_RESIZE_NORMAL)
    {
        __solverDeflateHeight = max(__solvedHeight, __solverDeflateHeight);
    }
}