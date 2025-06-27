// Feather disable all

function __BentoSolverListPositions(_left, _top, _allocatedWidth, _allocatedHeight)
{
    __solvedLeft = _left + __layoutAlignH*(_allocatedWidth  - __solvedWidth );
    __solvedTop  = _top  + __layoutAlignV*(_allocatedHeight - __solvedHeight);
    
    if (GUI_FLOOR_LAYOUT_POSITIONS)
    {
        __solvedLeft   = floor(__solvedLeft);
        __solvedTop    = floor(__solvedTop);
        __solvedWidth  = floor(__solvedWidth);
        __solvedHeight = floor(__solvedHeight);
    }
    
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    if (__listAxis == GUI_AXIS_X)
    {
        var _majorPos = __solvedLeft + __solverPadLeft;
        var _minorPos = __solvedTop  + __solverPadTop;
        var _gutter   = __layoutGutterX;
        
        var _majorSize = 0;
        var _i = 0;
        repeat(_childCount)
        {
            _majorSize += _childArray[_i].GUI_VARS.__solvedWidth;
            ++_i;
        }
        
        _majorSize += __solverPadLeft + __solverPadRight + max(_childCount-1, 0)*__layoutGutterX;
        
        if (__layoutHAlignChildren == fa_center)
        {
            _majorPos += (__solvedWidth - _majorSize)/2;
        }
        else if (__layoutHAlignChildren == fa_right)
        {
            _majorPos += __solvedWidth - _majorSize;
        }
        
        var _minorAvailable = __solvedHeight - (__solverPadTop + __solverPadBottom);
        var _minorAlign = __layoutVAlignChildren;
        var _childMinorPos = _minorPos; //Default for fa_top
        
        var _i = 0;
        repeat(_childCount)
        {
            with(_childArray[_i].GUI_VARS)
            {
                if (_minorAlign == fa_middle)
                {
                    var _childMinorPos = _minorPos + (_minorAvailable - __solvedHeight) / 2;
                }
                else if (_minorAlign == fa_bottom)
                {
                    var _childMinorPos = _minorPos + (_minorAvailable - __solvedHeight);
                }
                
                __SolverPositions(_majorPos, _childMinorPos, __solvedWidth, _minorAvailable);
                _majorPos += __solvedWidth + _gutter;
            }
          
            ++_i;
        }
    }
    else
    {
        var _majorPos = __solvedTop  + __solverPadTop;
        var _minorPos = __solvedLeft + __solverPadLeft;
        var _gutter   = __layoutGutterY;
        
        var _majorSize = 0;
        var _i = 0;
        repeat(_childCount)
        {
            _majorSize += _childArray[_i].GUI_VARS.__solvedHeight;
            ++_i;
        }
        
        _majorSize += __solverPadTop + __solverPadBottom + max(_childCount-1, 0)*__layoutGutterY;
        
        if (__layoutVAlignChildren == fa_middle)
        {
            _majorPos += (__solvedHeight - _majorSize)/2;
        }
        else if (__layoutVAlignChildren == fa_bottom)
        {
            _majorPos += __solvedHeight - _majorSize;
        }
        
        var _minorAvailable = __solvedWidth - (__solverPadLeft + __solverPadRight);
        var _minorAlign = __layoutHAlignChildren;
        var _childMinorPos = _minorPos; //Default for fa_left
        
        var _i = 0;
        repeat(_childCount)
        {
            with(_childArray[_i].GUI_VARS)
            {
                if (_minorAlign == fa_center)
                {
                    var _childMinorPos = _minorPos + (_minorAvailable - __solvedWidth) / 2;
                }
                else if (_minorAlign == fa_right)
                {
                    var _childMinorPos = _minorPos + (_minorAvailable - __solvedWidth);
                }
                
                __SolverPositions(_childMinorPos, _majorPos, _minorAvailable, __solvedHeight);
                _majorPos += __solvedHeight + _gutter;
            }
          
            ++_i;
        }
    }
    
}