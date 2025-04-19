// Feather disable all

function __GuiSolverGridPositions(_x, _y)
{
    _x += __layoutXOffset;
    _y += __layoutYOffset;
    
    layoutLeft = _x;
    layoutTop  = _y;
    
    event_user(GUI_USER_EVENT_REPOSITION);
    
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    var _availableWidth  = layoutWidth  - (__layoutPadLeft + __layoutPadRight + max(0, __gridColumns-1)*__layoutGutterX);
    var _availableHeight = layoutHeight - (__layoutPadTop + __layoutPadBottom + max(0, __gridRows-1)*__layoutGutterY);
    
    var _cellWidth  = floor(_availableWidth / max(1, __gridColumns));
    var _cellHeight = floor(_availableHeight / max(1, __gridRows));
    
    var _gridX = 0;
    
    var _xChild = layoutLeft + __layoutPadLeft;
    var _yChild = layoutTop + __layoutPadTop;
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