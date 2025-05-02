// Feather disable all

function __GuiSolverGridPositions(_left, _top, _allocatedWidth, _allocatedHeight)
{
    __solvedLeft = _left + __layoutOffsetX + __layoutAlignH*(_allocatedWidth  - __solvedWidth );
    __solvedTop  = _top  + __layoutOffsetY + __layoutAlignV*(_allocatedHeight - __solvedHeight);
    
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    var _availableWidth  = __solvedWidth  - (__layoutPadLeft + __layoutPadRight + max(0, __gridColumns-1)*__layoutGutterX);
    var _availableHeight = __solvedHeight - (__layoutPadTop + __layoutPadBottom + max(0, __gridRows-1)*__layoutGutterY);
    
    var _cellWidth  = floor(_availableWidth / max(1, __gridColumns));
    var _cellHeight = floor(_availableHeight / max(1, __gridRows));
    
    var _gridX = 0;
    
    var _childLeft = __solvedLeft + __layoutPadLeft;
    var _childTop  = __solvedTop  + __layoutPadTop;
    var _startLeft = _childLeft;
    var _i = 0;
    repeat(_childCount)
    {
        _childArray[_i].GUI_VARS.__SolverPositions(_childLeft, _childTop, _cellWidth, _cellHeight);
        
        _childLeft += _cellWidth + __layoutGutterX;
        ++_gridX;
        
        if (_gridX >= __gridColumns)
        {
            _childLeft  = _startLeft;
            _childTop  += _cellHeight + __layoutGutterY;
            
            _gridX = 0;
        }
        
        ++_i;
    }
}