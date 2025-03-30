// Feather disable all

function __GuiSolverGridResizeHeight()
{
    var _childArray   = __childArray;
    var _childCount = array_length(_childArray);
    
    var _available = layoutHeight - (__layoutPadTop + __layoutPadBottom + max(0, __gridRows-1)*__layoutGutterY);
    var _cellSize = floor(_available / max(1, __gridRows));
    
    if (_available > 0)
    {
        var _i = 0;
        repeat(_childCount)
        {
            with( _childArray[_i])
            {
                if (__layoutHeightResize == GUI_RESIZE_FIT)
                {
                    layoutHeight = clamp(min(layoutHeight, _cellSize), __layoutHeightMin, __layoutHeightMax);
                }
                else if (__layoutHeightResize == GUI_RESIZE_GROW)
                {
                    layoutHeight = clamp(_cellSize, __layoutHeightMin, __layoutHeightMax);
                }
            }
            
            ++_i;
        }
    }
}