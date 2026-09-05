// Feather disable all

function __BentoSolverTableGetDeflateWidth(_rootWidth)
{
    var _layoutWidthMin = __BentoParsePercentageString(__layoutWidthMin, _rootWidth);
    var _layoutWidthMax = __BentoParsePercentageString(__layoutWidthMax, _rootWidth);
    
    var _childArray   = __layoutChildArray;
    var _childCount   = array_length(_childArray);
    var _tableColumns = __tableColumns;
    
    //Make arrays for each column
    //TODO - Can these be allocated when setting the table layout ruleset?
    __layoutTableMinWidth     = array_create(_tableColumns, 0);
    __layoutTableDeflateWidth = array_create(_tableColumns, 0);
    __layoutTableSolvedWidth  = array_create(_tableColumns, 0);
    
    //Choose the maximum size per column
    var _i = 0;
    repeat(_childCount)
    {
        var _child = _childArray[_i];
        
        var _column = _i mod _tableColumns;
        __layoutTableDeflateWidth[@ _column] = max(__layoutTableDeflateWidth[_column], _child.__solverDeflateWidth);
        __layoutTableMinWidth[@     _column] = max(__layoutTableMinWidth[    _column], _child.__solverMinWidth    );
        
        ++_i;
    }
    
    array_copy(__layoutTableSolvedWidth, 0, __layoutTableDeflateWidth, 0, _tableColumns);
    
    //Sum the widths of the columns to give the overall width of the table
    var _deflateSize = 0;
    var _minSize = 0;
    
    var _i = 0;
    repeat(_tableColumns)
    {
        _deflateSize += __layoutTableDeflateWidth[_i];
        _minSize += __layoutTableMinWidth[_i];
        
        ++_i;
    }
    
    //Add gutters and padding
    var _extra = max(_tableColumns-1, 0)*__layoutGutterX + __solverPadWidth; //TODO - Should padding be around each element?
    _deflateSize += _extra;
    _minSize     += _extra;
    
    __solverChildrenDeflateWidth = _deflateSize;
    
    __solverMinWidth     = clamp(_minSize, _layoutWidthMin, _layoutWidthMax) + __layoutMarginWidth;
    __solverDeflateWidth = clamp(_deflateSize, __solverMinWidth - __layoutMarginWidth, _layoutWidthMax) + __layoutMarginWidth;
    __solvedWidth        = clamp(((__layoutWidthResize == BENTO_RESIZE_NORMAL)? __BentoSolvertGetSafeWidth(_rootWidth, _deflateSize) : _deflateSize) + __layoutMarginWidth, __solverMinWidth, _layoutWidthMax + __layoutMarginWidth);
    
    //Ensure we can never deflate lower than our fixed size
    if (__layoutWidthResize == BENTO_RESIZE_NORMAL)
    {
        __solverDeflateWidth = max(__solvedWidth, __solverDeflateWidth);
    }
}