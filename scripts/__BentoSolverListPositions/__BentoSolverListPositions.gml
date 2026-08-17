// Feather disable all

function __BentoSolverListPositions(_left, _top, _allocatedWidth, _allocatedHeight, _rightToLeftRootWidth)
{
    __BentoScrollLimitsMarkSelfDirty();
    
    __solvedLeft = _left + __layoutAnchorX*(_allocatedWidth  - __solvedWidth ) + __layoutMarginLeft;
    __solvedTop  = _top  + __layoutAnchorY*(_allocatedHeight - __solvedHeight) + __layoutMarginTop;
    __solvedWidth  -= __layoutMarginWidth;
    __solvedHeight -= __layoutMarginHeight;
    
    if (BENTO_FLOOR_LAYOUT_POSITIONS)
    {
        __solvedLeft   = floor(__solvedLeft);
        __solvedTop    = floor(__solvedTop);
        __solvedWidth  = floor(__solvedWidth);
        __solvedHeight = floor(__solvedHeight);
    }
    
    var _childArray = __layoutChildArray;
    var _childCount = array_length(_childArray);
    
    if (__listAxis == BENTO_AXIS_X)
    {
        var _majorSize = 0;
        var _i = 0;
        repeat(_childCount)
        {
            _majorSize += _childArray[_i].__solvedWidth;
            ++_i;
        }
        
        _majorSize += __solverPadWidth + max(_childCount-1, 0)*__layoutGutterX;
        
        var _majorPos = __solvedLeft + __solverPadLeft;
        var _minorPos = __solvedTop  + __solverPadTop;
        var _gutter   = __layoutGutterX;
        
        _majorPos += __layoutHAlignChildren*(__solvedWidth - _majorSize);
        
        var _minorAvailable = __solvedHeight - __solverPadHeight;
        var _minorAlign = __layoutVAlignChildren;
        var _i = 0;
        repeat(_childCount)
        {
            with(_childArray[_i])
            {
                var _childMinorPos = _minorPos + _minorAlign*(_minorAvailable - __solvedHeight);
                __SolverFinalPositions(_majorPos, _childMinorPos, __solvedWidth, _minorAvailable, _rightToLeftRootWidth);
                _majorPos += __solvedWidth + __layoutMarginWidth + _gutter;
            }
          
            ++_i;
        }
    }
    else
    {
        var _majorSize = 0;
        var _i = 0;
        repeat(_childCount)
        {
            _majorSize += _childArray[_i].__solvedHeight;
            ++_i;
        }
        
        _majorSize += __solverPadHeight + max(_childCount-1, 0)*__layoutGutterY;
        
        var _majorPos = __solvedTop  + __solverPadTop;
        var _minorPos = __solvedLeft + __solverPadLeft;
        var _gutter   = __layoutGutterY;
        
        _majorPos += __layoutVAlignChildren*(__solvedHeight - _majorSize);
        
        var _minorAvailable = __solvedWidth - __solverPadWidth;
        var _minorAlign = __layoutHAlignChildren;
        var _i = 0;
        repeat(_childCount)
        {
            with(_childArray[_i])
            {
                var _childMinorPos = _minorPos + _minorAlign*(_minorAvailable - __solvedWidth);
                __SolverFinalPositions(_childMinorPos, _majorPos, _minorAvailable, __solvedHeight, _rightToLeftRootWidth);
                _majorPos += __solvedHeight + __layoutMarginHeight + _gutter;
            }
          
            ++_i;
        }
    }
    
    //Reset the temporary layout array
    array_resize(__layoutChildArray, 0);
    
    //Flip the x-axis position if we're using a right-to-left layout
    if (_rightToLeftRootWidth != undefined)
    {
        __solvedLeft = _rightToLeftRootWidth - (__solvedLeft + __solvedWidth);
    }
}