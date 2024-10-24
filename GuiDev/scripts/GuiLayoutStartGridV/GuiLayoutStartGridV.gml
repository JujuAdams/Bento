// Feather disable all


/// Creates a grid layout with member instances arranged in columns when `GuiLayoutFinish()` is
/// called.
/// 
/// @param parent
/// @param inside
/// @param spacing
/// @param cellWidth
/// @param cellHeight
/// @param countPerColumn

function GuiLayoutStartGridV(_parent, _inside, _spacing, _cellWidth, _cellHeight, _countPerColumn)
{
    var _layout = new __GuiClassLayoutGridV(_parent, _inside, _spacing, _cellWidth, _cellHeight, _countPerColumn);
    return _layout;
}



/// @param parent
/// @param inside
/// @param spacing
/// @param hAlign
/// @param vAlign

function __GuiClassLayoutGridV(_parent, _inside, _spacing, _cellWidth, _cellHeight, _countPerColumn) constructor
{
    __parent         = _parent;
    __inside         = _inside;
    __spacing        = _spacing;
    __cellWidth      = _cellWidth;
    __cellHeight     = _cellHeight;
    __countPerColumn = _countPerColumn;
    
    __width  = 0;
    __height = 0;
    
    __maxWidth  = 0;
    __maxHeight = 0;
    
    __instanceArray = [];
    
    
    
    __Add = function(_instance)
    {
        var _count = array_length(__instanceArray);
        var _cellX = _count mod __countPerColumn;
        var _cellY = _count div __countPerColumn;
        
        array_push(__instanceArray, _instance);
        
        __maxWidth  = max(__maxWidth,  _instance.width);
        __maxHeight = max(__maxHeight, _instance.height);
        
        if (_cellX == 0)
        {
            if (_cellY == 0)
            {
                __width  = __cellWidth;
                __height = __cellHeight;
            }
            else
            {
                __height = __cellHeight*_cellY + __spacing*(_cellY - 1);
            }
        }
        else
        {
            __width  = __cellWidth*_cellX + __spacing*(_cellX - 1);
        }
    }
    
    __RecalculateBounds = function()
    {
        __GuiLayoutRecalculateBounds();
    }
    
    __Finish = function(_x, _y)
    {
        if (__inside && __parent.__scrollEnabled)
        {
            _x += __parent.__scrollX - __parent.__scrollMaxX;
            _y += __parent.__scrollY - __parent.__scrollMaxY;
        }
        
        var _instanceArray  = __instanceArray;
        var _spacing        = __spacing;
        var _cellWidth      = __cellWidth;
        var _cellHeight     = __cellHeight;
        var _countPerColumn = __countPerColumn;
        
        var _memberX = _x + 0.5*_cellWidth;
        var _memberY = _y + 0.5*_cellHeight;
        
        var _cellY = 0;
        var _i = 0;
        repeat(array_length(_instanceArray))
        {
            GuiSetPosition(_memberX, _memberY, _instanceArray[_i]);
            
            ++_cellY;
            if (_cellY >= _countPerColumn)
            {
                _cellY = 0;
                
                _memberX += _spacing + _cellWidth;
                _memberY  = _y + 0.5*_cellHeight;
            }
            else
            {
                _memberY += _spacing + _cellHeight;
            }
            
            ++_i;
        }
    }
    
    __FinishWithScroll = function(_left, _top, _right, _bottom, _padLeft, _padTop, _padRight, _padBottom)
    {
        __Finish(_left, _top);
        GuiScrollSetupVert(_padTop, _padBottom, __parent);
        GuiScissorSetupExt(_left, _top, _right, _bottom, __parent);
    }
}