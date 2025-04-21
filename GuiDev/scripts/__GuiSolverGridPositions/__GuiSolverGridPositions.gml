// Feather disable all

function __GuiSolverGridPositions(_x, _y)
{
    _x += __layoutXOffset;
    _y += __layoutYOffset;
    
    __solvedLeft = _x;
    __solvedTop  = _y;
    
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    var _availableWidth  = __solvedWidth  - (__layoutPadLeft + __layoutPadRight + max(0, __gridColumns-1)*__layoutGutterX);
    var _availableHeight = __solvedHeight - (__layoutPadTop + __layoutPadBottom + max(0, __gridRows-1)*__layoutGutterY);
    
    var _cellWidth  = floor(_availableWidth / max(1, __gridColumns));
    var _cellHeight = floor(_availableHeight / max(1, __gridRows));
    
    var _gridX = 0;
    
    var _xChild = __solvedLeft + __layoutPadLeft;
    var _yChild = __solvedTop  + __layoutPadTop;
    var _xStart = _xChild;
    var _i = 0;
    repeat(_childCount)
    {
        _childArray[_i].__SolverPositions(_xChild, _yChild, _cellWidth, _cellHeight);
        
        _xChild += _cellWidth + __layoutGutterX;
        ++_gridX;
        
        if (_gridX >= __gridColumns)
        {
            _xChild  = _xStart;
            _yChild += _cellHeight + __layoutGutterY;
            
            _gridX = 0;
        }
        
        ++_i;
    }
}