// Feather disable all

function __GuiSolverListPositions(_x, _y)
{
    _x += __layoutXOffset;
    _y += __layoutYOffset;
    
    layoutLeft = _x;
    layoutTop  = _y;
    
    var _childArray = __childArray;
    var _childCount = array_length(_childArray);
    
    if (__listAxis == GUI_AXIS_X)
    {
        var _majorPos = layoutLeft + __layoutPadLeft;
        var _minorPos = layoutTop + __layoutPadTop;
        var _gutter   = __layoutGutterX;
        
        var _majorSize = 0;
        var _i = 0;
        repeat(_childCount)
        {
            _majorSize += _childArray[_i].layoutWidth;
            ++_i;
        }
        
        _majorSize += __layoutPadLeft + __layoutPadRight + max(_childCount-1, 0)*__layoutGutterX;
        
        if (__layoutHAlignChildren == fa_center)
        {
            _majorPos += (layoutWidth - _majorSize)/2;
        }
        else if (__layoutHAlignChildren == fa_right)
        {
            _majorPos += layoutWidth - _majorSize;
        }
        
        var _minorAvailable = layoutHeight - (__layoutPadTop + __layoutPadBottom);
        var _minorAlign = __layoutVAlignChildren;
        var _childMinorPos = _minorPos; //Default for fa_top
        
        var _i = 0;
        repeat(_childCount)
        {
            with(_childArray[_i])
            {
                if (_minorAlign == fa_middle)
                {
                    var _childMinorPos = _minorPos + (_minorAvailable - layoutHeight) / 2;
                }
                else if (_minorAlign == fa_bottom)
                {
                    var _childMinorPos = _minorPos + (_minorAvailable - layoutHeight);
                }
                
                __SolverPositions(_majorPos, _childMinorPos, layoutWidth, _minorAvailable);
                _majorPos += layoutWidth + _gutter;
            }
          
            ++_i;
        }
    }
    else
    {
        var _majorPos = layoutTop + __layoutPadTop;
        var _minorPos = layoutLeft + __layoutPadLeft;
        var _gutter   = __layoutGutterY;
        
        var _majorSize = 0;
        var _i = 0;
        repeat(_childCount)
        {
            _majorSize += _childArray[_i].layoutHeight;
            ++_i;
        }
        
        _majorSize += __layoutPadTop + __layoutPadBottom + max(_childCount-1, 0)*__layoutGutterY;
        
        if (__layoutHAlignChildren == fa_middle)
        {
            _majorPos += (layoutHeight - _majorSize)/2;
        }
        else if (__layoutHAlignChildren == fa_bottom)
        {
            _majorPos += layoutHeight - _majorSize;
        }
        
        var _minorAvailable = layoutWidth - (__layoutPadLeft + __layoutPadRight);
        var _minorAlign = __layoutHAlignChildren;
        var _childMinorPos = _minorPos; //Default for fa_left
        
        var _i = 0;
        repeat(_childCount)
        {
            with(_childArray[_i])
            {
                if (_minorAlign == fa_middle)
                {
                    var _childMinorPos = _minorPos + (_minorAvailable - layoutWidth) / 2;
                }
                else if (_minorAlign == fa_bottom)
                {
                    var _childMinorPos = _minorPos + (_minorAvailable - layoutWidth);
                }
                
                __SolverPositions(_childMinorPos, _majorPos, _minorAvailable, layoutHeight);
                _majorPos += layoutHeight + _gutter;
            }
          
            ++_i;
        }
    }
    
}