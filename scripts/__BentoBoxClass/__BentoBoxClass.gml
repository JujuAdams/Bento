function __BentoBoxClass() constructor
{
    __parent = undefined;
    
    __left      = undefined;
    __top       = undefined;
    __right     = undefined;
    __bottom    = undefined;
    __rawWidth  = undefined;
    __rawHeight = undefined;
    
    __declRefresh = true;
    __declLeft   = undefined;
    __declTop    = undefined;
    __declRight  = undefined;
    __declBottom = undefined;
    __declX      = undefined;
    __declY      = undefined;
    __declWidth  = undefined;
    __declHeight = undefined;
    
    __doFlow         = false;
    columnMaxCount   = undefined;
    rowMaxCount      = undefined;
    columnSize       = undefined;
    rowSize          = undefined;
    columnGutterSize = 0;
    rowGutterSize    = 0;
    direction        = BENTO_FLOW_DIRECTION.X;
    overflow         = BENTO_OVERFLOW.IGNORE;
    clipMode         = BENTO_DEFAULT_CLIP_MODE;
    
    flowChildren = [];
    __isFlowChild  = false;
    flowX        = undefined;
    flowY        = undefined;
    flowIndex    = undefined;
    
    children = [];
    
    __eventsArray = array_create(BENTO_EVENT.__SIZE);
    var _i = 0;
    repeat(BENTO_EVENT.__SIZE)
    {
        __eventsArray[@ _i] = [];
        ++_i;
    }
    
    
    
    #region Position Setters
    
    static SetLTRB = function(_left, _top, _right, _bottom)
    {
        SetLeft(_left);
        SetTop(_top);
        SetRight(_right);
        SetBottom(_bottom);
    }
    
    static SetXYWH = function(_x, _y, _width, _height)
    {
        SetX(_x);
        SetY(_y);
        SetWidth(_width);
        SetHeight(_height);
    }
    
    static SetPosition = function(_left, _top, _right, _bottom, _x, _y, _width, _height)
    {
        SetLeft(_left);
        SetTop(_top);
        SetRight(_right);
        SetBottom(_bottom);
        SetX(_x);
        SetY(_y);
        SetWidth(_width);
        SetHeight(_height);
    }
    
    static SetLeft = function(_value)
    {
        if (__declLeft != _value)
        {
            __declRefresh = true;
            __declLeft = _value;
        }
        
        return self;
    }
    
    static SetTop = function(_value)
    {
        if (__declTop != _value)
        {
            __declRefresh = true;
            __declTop = _value;
        }
        
        return self;
    }
    
    static SetRight = function(_value)
    {
        if (__declRight != _value)
        {
            __declRefresh = true;
            __declRight = _value;
        }
        
        return self;
    }
    
    static SetBottom = function(_value)
    {
        if (__declBottom  != _value)
        {
            __declRefresh = true;
            __declBottom  = _value;
        }
        
        return self;
    }
    
    static SetX = function(_value)
    {
        if (__declX != _value)
        {
            __declRefresh = true;
            __declX = _value;
        }
        
        return self;
    }
    
    static SetY = function(_value)
    {
        if (__declY != _value)
        {
            __declRefresh = true;
            __declY = _value;
        }
        
        return self;
    }
    
    static SetWidth = function(_value)
    {
        if (__declWidth != _value)
        {
            __declRefresh = true;
            __declWidth = _value;
        }
        
        return self;
    }
    
    static SetHeight = function(_value)
    {
        if (__declHeight != _value)
        {
            __declRefresh = true;
            __declHeight = _value;
        }
        
        return self;
    }
    
    #endregion
    
    
    
    #region Position Getters
    
    static GetLeft = function()
    {
        __RefreshPosition();
        return __left;
    }
    
    static GetTop = function()
    {
        __RefreshPosition();
        return __top;
    }
    
    static GetRight = function()
    {
        __RefreshPosition();
        return __right;
    }
    
    static GetBottom = function()
    {
        __RefreshPosition();
        return __bottom;
    }
    
    static GetX = function()
    {
        __RefreshPosition();
        if ((__left == undefined) || (__right == undefined)) return undefined;
        return 0.5*(__left + __right);
    }
    
    static GetY = function()
    {
        __RefreshPosition();
        if ((__top == undefined) || (__bottom == undefined)) return undefined;
        return 0.5*(__top + __bottom);
    }
    
    static GetWidth = function()
    {
        __RefreshPosition();
        if ((__left == undefined) || (__right == undefined)) return undefined;
        return __right - __left;
    }
    
    static GetHeight = function()
    {
        __RefreshPosition();
        if ((__top == undefined) || (__bottom == undefined)) return undefined;
        return __bottom - __top;
    }
    
    #endregion
    
    
    
    static GetIsFlowChild = function()
    {
        return __isFlowChild;
    }
    
    static EventAdd = function(_eventType, _function)
    {
        var _array = __eventsArray[_eventType];
        array_push(_array, _function);
    }
    
    static Step = function()
    {
        __RefreshPosition();
        
        __ExecuteEvent(BENTO_EVENT.STEP);
        
        var _i = 0;
        repeat(array_length(children))
        {
            children[_i].Step();
            ++_i;
        }
    }
    
    static Draw = function()
    {
        __RefreshPosition();
        
        __ExecuteEvent(BENTO_EVENT.DRAW, __left, __top, __right, __bottom);
        
        var _i = 0;
        repeat(array_length(children))
        {
            children[_i].Draw();
            ++_i;
        }
    }
    
    static UpdatePosition = function()
    {
        __RefreshPosition();
        
        if (__doFlow)
        {
            #region Flow Calculation
            
            var _childrenCount = array_length(flowChildren);
            if (_childrenCount >= 1)
            {
                var _maxWidth    = (__rawWidth     == undefined)? infinity : __rawWidth;
                var _maxHeight   = (__rawHeight    == undefined)? infinity : __rawHeight;
                var _maxColCount = (columnMaxCount == undefined)? infinity : columnMaxCount;
                var _maxRowCount = (rowMaxCount    == undefined)? infinity : rowMaxCount;
                
                if (columnMaxCount == undefined)
                {
                    if (is_array(columnSize)) __BentoError("Variable columnSize must not be an array if columnMaxCount is undefined");
                    var _colWidthArray = array_create(_childrenCount, columnSize);
                }
                else
                {
                    if (is_array(columnSize))
                    {
                        if (columnMaxCount > array_length(columnSize)) __BentoError("Length of array columnSize (", array_length(columnSize), ") must be greater than or equal to columnMaxCount (", columnMaxCount, ")");
                        
                        var _colWidthArray = array_create(columnMaxCount);
                        array_copy(_colWidthArray, 0, columnSize, 0, columnMaxCount);
                    }
                    else
                    {
                        var _colWidthArray = array_create(columnMaxCount, columnSize);
                    }
                }
                
                if (rowMaxCount == undefined)
                {
                    if (is_array(columnSize)) __BentoError("Variable rowSize must not be an array if rowMaxCount is undefined");
                    var _rowHeightArray = array_create(_childrenCount, rowSize);
                }
                else
                {
                    if (is_array(rowSize))
                    {
                        if (rowMaxCount > array_length(rowSize)) __BentoError("Length of array rowSize (", array_length(rowSize), ") must be greater than or equal to rowMaxCount (", rowMaxCount, ")");
                        
                        var _rowHeightArray = array_create(rowMaxCount);
                        array_copy(_rowHeightArray, 0, rowSize, 0, rowMaxCount);
                    }
                    else
                    {
                        var _rowHeightArray = array_create(rowMaxCount, rowSize);
                    }
                }
                
                var _colAutoArray = array_create(array_length(_colWidthArray ), false);
                var _rowAutoArray = array_create(array_length(_rowHeightArray), false);
                
                var _i = 0;
                repeat(array_length(_colAutoArray))
                {
                    if (_colWidthArray[_i] == undefined)
                    {
                        _colWidthArray[@ _i] = 0;
                        _colAutoArray[@  _i] = true;
                    }
                    
                    ++_i;
                }
                
                var _i = 0;
                repeat(array_length(_rowAutoArray))
                {
                    if (_rowHeightArray[_i] == undefined)
                    {
                        _rowHeightArray[@ _i] = 0;
                        _rowAutoArray[@   _i] = true;
                    }
                    
                    ++_i;
                }
                    
                
                
                var _gridTopArray = [];
                
                var _x         = 0;
                var _y         = 0;
                var _flowX     = 0;
                var _flowY     = 0;
                var _flowIndex = 0;
                
                if (direction == BENTO_FLOW_DIRECTION.X)
                {
                    repeat(_childrenCount)
                    {
                        var _child = flowChildren[_flowIndex];
                        with(_child)
                        {
                            var _width  = __UpdateRawWidth();
                            var _height = __UpdateRawHeight();
                        }
                        
                        if ((_flowX < _maxColCount) && (_width != undefined) && (_x + _width < _maxWidth))
                        {
                            with(_child)
                            {
                                flowX     = _flowX;
                                flowY     = _flowY;
                                flowIndex = _flowIndex;
                            }
                            
                            if (_colAutoArray[_flowX])
                            {
                                if (is_numeric(_width) && (_width > _colWidthArray[_flowX])) _colWidthArray[@ _flowX] = _width;
                            }
                            
                            _x += columnGutterSize;
                            _flowX++;
                        }
                        else
                        {
                            _x = 0;
                            _flowX = 0;
                            
                            if ((_flowY < _maxRowCount) && (_height != undefined) && (_y + _height < _maxHeight))
                            {
                                with(_child)
                                {
                                    flowX     = _flowX;
                                    flowY     = _flowY;
                                    flowIndex = _flowIndex;
                                }
                                
                                if (_rowAutoArray[_flowY])
                                {
                                    if (is_numeric(_height) && (_height > _rowHeightArray[_flowY])) _rowHeightArray[@ _flowY] = _height;
                                }
                                
                                _y += rowGutterSize;
                                _flowY++;
                            }
                            else
                            {
                                //TODO - Overflow!
                                break;
                            }
                        }
                        
                        ++_flowIndex;
                    }
                }
                else if (direction == BENTO_FLOW_DIRECTION.Y)
                {
                    
                }
                else
                {
                    __BentoError("Flow direction not recognised. Please use the BENTO_FLOW_DIRECTION enum");
                }
            }
            
            #endregion
        }
        
        var _i = 0;
        repeat(array_length(children))
        {
            children[_i].UpdatePosition();
            ++_i;
        }
    }
    
    
    
    #region Definition Functions
    
    static ChildFree = function()
    {
        var _child = new __BentoBoxClass();
        _child.__parent = weak_ref_create(self);
        array_push(children, _child);
        return _child;
    }
    
    static Child = function()
    {
        var _child = ChildFree();
        _child.__isFlowChild = true;
        array_push(flowChildren, _child);
        return _child;
    }
    
    static Grid = function()
    {
        __doFlow = true;
    }
    
    static ListX = function()
    {
        Grid();
        direction = BENTO_FLOW_DIRECTION.X;
        rowMaxCount = 1;
    }
    
    static ListY = function()
    {
        Grid();
        direction = BENTO_FLOW_DIRECTION.Y;
        columnMaxCount = 1;
    }
    
    #endregion
    
    
    
    #region Internal
    
    static __ExecuteEvent = function(_eventType, _arg0, _arg1, _arg2, _arg3)
    {
        var _array = __eventsArray[_eventType];
        var _i = 0;
        repeat(array_length(_array))
        {
            _array[_i](_arg0, _arg1, _arg2, _arg3);
            ++_i;
        }
    }
    
    static __UpdateRawWidth = function()
    {
        if (__declRefresh)
        {
            __rawWidth = undefined;
            var _declX     = __BentoResolveValue(__declX);
            var _declWidth = __BentoResolveValue(__declWidth);
            
            if (is_numeric(_declWidth))
            {
                __rawWidth = _declWidth;
            }
            else if (is_numeric(__left))
            {
                if (is_numeric(_declX)) __rawWidth = 2*(_declX - __left);
                if (is_numeric(__right)) __rawWidth = __right - __left;
            }
            else if (is_numeric(_declX))
            {
                if (is_numeric(__right)) __rawWidth = 2*(__right - _declX);
            }
        }
        
        return __rawWidth;
    }
    
    static __UpdateRawHeight = function()
    {
        if (__declRefresh)
        {
            __rawHeight = undefined;
            var _declY      = __BentoResolveValue(__declY);
            var _declHeight = __BentoResolveValue(__declHeight);
            
            if (is_numeric(_declHeight))
            {
                __rawHeight = _declHeight;
            }
            else if (is_numeric(__top))
            {
                if (is_numeric(_declY)) __rawHeight = 2*(_declY - __top);
                if (is_numeric(__bottom)) __rawHeight = __bottom - __top;
            }
            else if (is_numeric(_declY))
            {
                if (is_numeric(__bottom)) __rawHeight = 2*(__bottom - _declY);
            }
        }
        
        return __rawHeight;
    }
    
    static __RefreshPosition = function(_force)
    {
        if (__declRefresh || _force)
        {
            __left   = __BentoResolveValue(__declLeft);
            __top    = __BentoResolveValue(__declTop);
            __right  = __BentoResolveValue(__declRight);
            __bottom = __BentoResolveValue(__declBottom);
            
            __UpdateRawWidth();
            __UpdateRawHeight();
            
            
            
            if (is_numeric(__rawWidth))
            {
                if (is_numeric(__left))
                {
                    if (!is_numeric(__right)) __right = __left + __rawWidth;
                }
                else if (is_numeric(__right))
                {
                    __left = __right - __rawWidth;
                }
                else
                {
                    var _declX = __BentoResolveValue(__declX);
                    if (is_numeric(_declX))
                    {
                        __left  = _declX - 0.5*__rawWidth;
                        __right = _declX + 0.5*__rawWidth;
                    }
                }
            }
            
            
            
            if (is_numeric(__rawHeight))
            {
                if (is_numeric(__top))
                {
                    if (!is_numeric(__bottom)) __bottom = __top + __rawHeight;
                }
                else if (is_numeric(__bottom))
                {
                    __top = __bottom - __rawHeight;
                }
                else
                {
                    var _declY = __BentoResolveValue(__declY);
                    if (is_numeric(_declY))
                    {
                        __top    = _declY - 0.5*__rawHeight;
                        __bottom = _declY + 0.5*__rawHeight;
                    }
                }
            }
            
            
            
            if (__parent != undefined)
            {
                if (!weak_ref_alive(__parent)) exit;
                
                var _parent = __parent.ref;
                with(_parent) __RefreshPosition();
                
                //FIXME - Placeholder
                if (is_numeric(__left  )) __left   += _parent.__left;
                if (is_numeric(__top   )) __top    += _parent.__top;
                if (is_numeric(__right )) __right  += _parent.__left;
                if (is_numeric(__bottom)) __bottom += _parent.__top;
            }
            
            
            
            __declRefresh = false;
        }
    }
    
    #endregion
}