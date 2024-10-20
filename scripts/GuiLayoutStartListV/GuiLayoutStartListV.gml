// Feather disable all

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
        
        __maxWidth  = max(__maxWidth,  _instance.width);
        __maxHeight = max(__maxHeight, _instance.height);
        
        __width = __maxWidth;
        
        if (array_length(__instanceArray) == 1)
        {
            __height = __maxHeight;
        }
        else
        {
            __height += _instance.height + __spacing;
        }
    }
    
    __Finish = function(_x, _y)
    {
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
                _y += height/2;
                
                if (_hAlign == fa_left)
                {
                    var _xOffset = width/2;
                }
                else if (_hAlign == fa_center)
                {
                    var _xOffset = 0;
                }
                else if (_hAlign == fa_right)
                {
                    var _xOffset = -width/2;
                }
                
                GuiSetPosition(_x + _xOffset, _y);
                xstart = x;
                ystart = y;
                
                if (__behavior == GUI_BEHAVIOR_BUTTON)
                {
                    GuiNavLinkVert(_prev, id);
                    _prev = id;
                }
                
                _y += height/2 + _spacing;
            }
            
            ++_i;
        }
    }
}