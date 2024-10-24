// Feather disable all

/// Creates a horizontal list layout. Member instances will be arranged in a horizontal line when
/// `GuiLayoutFinish()` is called.
/// 
/// @param parent
/// @param inside
/// @param spacing
/// @param hAlign
/// @param vAlign

function GuiLayoutStartListH(_parent, _inside, _spacing, _hAlign, _vAlign)
{
    var _layout = new __GuiClassLayoutListH(_parent, _inside, _spacing, _hAlign, _vAlign);
    return _layout;
}



/// @param parent
/// @param inside
/// @param spacing
/// @param hAlign
/// @param vAlign

function __GuiClassLayoutListH(_parent, _inside, _spacing, _hAlign, _vAlign) constructor
{
    __parent  = _parent;
    __inside  = _inside;
    __spacing = _spacing;
    __hAlign  = _hAlign;
    __vAlign  = _vAlign;
    
    __width  = 0;
    __height = 0;
    
    __maxWidth  = 0;
    __maxHeight = 0;
    
    __instanceArray = [];
    
    
    
    __Add = function(_instance)
    {
        array_push(__instanceArray, _instance);
        
        __maxWidth  = max(__maxWidth,  _instance.width);
        __maxHeight = max(__maxHeight, _instance.height);
        
        if (array_length(__instanceArray) == 1)
        {
            __width = __maxWidth;
        }
        else
        {
            __width += _instance.width + __spacing;
        }
        
        __height = __maxHeight;
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
        
        var _instanceArray = __instanceArray;
        var _spacing       = __spacing;
        var _vAlign        = __vAlign;
        
        if (array_length(_instanceArray) <= 0) return;
        
        if (__hAlign == fa_center)
        {
            _x -= __width/2;
        }
        else if (__hAlign == fa_right)
        {
            _x -= __width;
        }
    
        var _prev = noone;
        var _i = 0;
        repeat(array_length(_instanceArray))
        {
            with(_instanceArray[_i])
            {
                _x += width/2;
                
                if (_vAlign == fa_left)
                {
                    var _yOffset = height/2;
                }
                else if (_vAlign == fa_center)
                {
                    var _yOffset = 0;
                }
                else if (_vAlign == fa_right)
                {
                    var _yOffset = -height/2;
                }
                
                GuiSetPosition(_x, _y + _yOffset);
                
                if (__behavior == GUI_BEHAVIOR_BUTTON)
                {
                    GuiNavLinkHori(_prev, id);
                    _prev = id;
                }
                
                _x += width/2 + _spacing;
            }
            
            ++_i;
        }
    }
    
    __FinishWithScroll = function(_left, _top, _right, _bottom, _padLeft, _padTop, _padRight, _padBottom)
    {
        if (__hAlign == fa_left)
        {
            var _x = _left;
        }
        else if (__hAlign == fa_center)
        {
            var _x = 0.5*(_left + _right);
        }
        else if (__hAlign == fa_right)
        {
            var _x = _right;
        }
        
        if (__vAlign == fa_top)
        {
            var _y = _top;
        }
        else if (__vAlign == fa_middle)
        {
            var _y = 0.5*(_top + _bottom);
        }
        else if (__vAlign == fa_bottom)
        {
            var _y = _bottom;
        }
        
        __Finish(_x, _y);
        GuiScrollSetupHori(_padLeft, _padRight, __parent);
        GuiScissorSetupExt(_left, _top, _right, _bottom, __parent);
    }
}