// Feather disable all

/// Creates a vertical list layout. Member instances will be arranged in a vertical line when
/// `GuiLayoutFinish()` is called.
/// 
/// The `spacing` argument controls the distance between member instances. The `hAlign` and
/// `vAlign` arguments controls how the entire group of instances is aligned to the position
/// supplied when calling `GuiLayoutFinish()`.
/// 
/// @param parent
/// @param inside
/// @param spacing
/// @param hAlign
/// @param vAlign

function GuiLayoutStartListV(_parent, _inside, _spacing, _hAlign, _vAlign)
{
    var _layout = new __GuiClassLayoutListV(_parent, _inside, _spacing, _hAlign, _vAlign);
    return _layout;
}



/// @param parent
/// @param inside
/// @param spacing
/// @param hAlign
/// @param vAlign

function __GuiClassLayoutListV(_parent, _inside, _spacing, _hAlign, _vAlign) constructor
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
        
        __maxWidth  = max(__maxWidth,  _instance.sprite_width);
        __maxHeight = max(__maxHeight, _instance.sprite_height);
        
        __width = __maxWidth;
        
        if (array_length(__instanceArray) == 1)
        {
            __height = __maxHeight;
        }
        else
        {
            __height += _instance.sprite_height + __spacing;
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
        
        var _instanceArray = __instanceArray;
        var _spacing       = __spacing;
        var _hAlign        = __hAlign;
        
        if (array_length(_instanceArray) <= 0) return;
        
        if (__vAlign == fa_middle)
        {
            _y -= __height/2;
        }
        else if (__vAlign == fa_bottom)
        {
            _y -= __height;
        }
        
        var _prev = noone;
        var _i = 0;
        repeat(array_length(_instanceArray))
        {
            with(_instanceArray[_i])
            {
                GuiSetPosition(_x, _y, id, _hAlign, fa_top);
                
                if (__behavior == GUI_BEHAVIOR_BUTTON)
                {
                    GuiNavLinkVert(_prev, id);
                    _prev = id;
                }
                
                _y += sprite_height + _spacing;
            }
            
            ++_i;
        }
    }
    
    __FinishWithScroll = function(_padLeft, _padTop, _padRight, _padBottom)
    {
        if (not __parent.__scissorState)
        {
            __GuiError("Scissor region not set up");
        }
        
        if (__hAlign == fa_left)
        {
            var _x = __parent.__scissorLeft;
        }
        else if (__hAlign == fa_center)
        {
            var _x = 0.5*(__parent.__scissorLeft + __parent.__scissorRight);
        }
        else if (__hAlign == fa_right)
        {
            var _x = __parent.__scissorRight;
        }
        
        if (__vAlign == fa_top)
        {
            var _y = __parent.__scissorTop;
        }
        else if (__vAlign == fa_middle)
        {
            var _y = 0.5*(__parent.__scissorTop + __parent.__scissorBottom);
        }
        else if (__vAlign == fa_bottom)
        {
            var _y = __parent.__scissorBottom;
        }
        
        __Finish(_x, _y);
        GuiScrollSetupVert(_padTop, _padBottom, __parent);
    }
}