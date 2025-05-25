// Feather disable all

/// @param json
/// @param [element=self]

function GuiLayoutSetFromJSON(_json, _element = self)
{
    if (not is_struct(_json))
    {
        __GuiError($"Layout JSON is incorrect datatype, must be a struct (was \"{typeof(_json)}\")");
    }
    
    with(_element)
    {
        var _nameArray = variable_struct_get_names(_json);
        var _i = 0;
        repeat(array_length(_nameArray))
        {
            var _name  = _nameArray[_i];
            var _value = _json[$ _name];
            
            if (_name == "clampInside")
            {
                __GuiLayoutSetFromJSON_clampInside(_element, _value);
            }
            else if (_name == "offset")
            {
                __GuiLayoutSetFromJSON_offset(_element, _value);
            }
            else if (_name == "size")
            {
                __GuiLayoutSetFromJSON_size(_element, _value);
            }
            else if (_name == "minSize")
            {
                __GuiLayoutSetFromJSON_minSize(_element, _value);
            }
            else if (_name == "maxSize")
            {
                __GuiLayoutSetFromJSON_maxSize(_element, _value);
            }
            else if (_name == "resize")
            {
                __GuiLayoutSetFromJSON_resize(_element, _value);
            }
            else if (_name == "padding")
            {
                __GuiLayoutSetFromJSON_padding(_element, _value);
            }
            else if (_name == "alignSelf")
            {
                __GuiLayoutSetFromJSON_alignSelf(_element, _value);
            }
            else if (_name == "gutter")
            {
                if ((not __GuiObjectInheritsFrom(object_index, oGuiLibList)) && (not __GuiObjectInheritsFrom(object_index, oGuiLibGrid)))
                {
                    __GuiError($"Cannot use .gutter on an object ({object_get_name(object_index)}) that does not inherit from {object_get_name(oGuiLibList)} or {object_get_name(oGuiLibGrid)}");
                }
                
                __GuiLayoutSetFromJSON_gutter(_element, _value);
            }
            else if (_name == "listAlign")
            {
                if (not __GuiObjectInheritsFrom(object_index, oGuiLibList))
                {
                    __GuiError($"Cannot use .listAlign on an object ({object_get_name(object_index)}) that does not inherit from {object_get_name(oGuiLibList)}");
                }
                
                __GuiLayoutSetFromJSON_listAlign(_element, _value);
            }
            else if (_name == "listAxis")
            {
                if (not __GuiObjectInheritsFrom(object_index, oGuiLibList))
                {
                    __GuiError($"Cannot use .listAxis on an object ({object_get_name(object_index)}) that does not inherit from {object_get_name(oGuiLibList)}");
                }
                
                __GuiLayoutSetFromJSON_listAxis(_element, _value);
            }
            else if (_name == "gridSize")
            {
                if (not __GuiObjectInheritsFrom(object_index, oGuiLibGrid))
                {
                    __GuiError($"Cannot use .gridSize on an object ({object_get_name(object_index)}) that does not inherit from {object_get_name(oGuiLibGrid)}");
                }
                        
                __GuiLayoutSetFromJSON_gridSize(_element, _value);
            }
            else
            {
                __GuiError($"Layout property name \"{_name}\" not recognized or not supported");
            }
                    
            ++_i;
        }
    }
}



////////
// .clampInside
////////
function __GuiLayoutSetFromJSON_clampInside(_element, _value)
{
    if (is_bool(_value))
    {
        GuiLayoutSetClampInside(_value, _element);
    }
    else
    {
        __GuiError($".offset layout property must be a boolean (typeof \"{typeof(_value)}\")");
    }
}



////////
// .offset
////////
function __GuiLayoutSetFromJSON_offset(_element, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".offset layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        GuiLayoutSetOffset(_value[0], _value[1], _element);
    }
    else if (is_struct(_value))
    {
        GuiLayoutSetOffset(_value[$ "x"], _value[$ "y"], _element);
    }
    else
    {
        __GuiError($".offset layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .size
////////
function __GuiLayoutSetFromJSON_size(_element, _value)
{
    var _width  = undefined;
    var _height = undefined;
    
    //Collect width and height values
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".size layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        _width  = _value[0];
        _height = _value[1];
    }
    else if (is_struct(_value))
    {
        //Search for some valid number!
        _width  = _value[$ "w"] ?? (_value[$ "width" ] ?? _value[$ "x"]);
        _height = _value[$ "h"] ?? (_value[$ "height"] ?? _value[$ "y"]);
    }
    else
    {
        __GuiError($".size layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    GuiLayoutSetSize(_width, _height, _element);
}



////////
// .minSize
////////
function __GuiLayoutSetFromJSON_minSize(_element, _value)
{
    var _width  = undefined;
    var _height = undefined;
    
    //Collect width and height values
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".minSize layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        _width  = _value[0];
        _height = _value[1];
    }
    else if (is_struct(_value))
    {
        //Search for some valid number!
        _width  = _value[$ "w"] ?? (_value[$ "width" ] ?? _value[$ "x"]);
        _height = _value[$ "h"] ?? (_value[$ "height"] ?? _value[$ "y"]);
    }
    else
    {
        __GuiError($".minSize layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    GuiLayoutSetMinSize(_width, _height, _element);
}



////////
// .maxSize
////////
function __GuiLayoutSetFromJSON_maxSize(_element, _value)
{
    var _width  = undefined;
    var _height = undefined;
    
    //Collect width and height values
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".maxSize layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        _width  = _value[0];
        _height = _value[1];
    }
    else if (is_struct(_value))
    {
        //Search for some valid number!
        _width  = _value[$ "w"] ?? (_value[$ "width" ] ?? _value[$ "x"]);
        _height = _value[$ "h"] ?? (_value[$ "height"] ?? _value[$ "y"]);
    }
    else
    {
        __GuiError($".maxSize layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    GuiLayoutSetMaxSize(_width, _height, _element);
}



////////
// .resize
////////
function __GuiLayoutSetFromJSON_resize(_element, _value)
{
    var _x = undefined;
    var _y = undefined;
    
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".resize layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        _x = _value[0];
        _y = _value[1];
    }
    else if (is_struct(_value))
    {
        _x = _value[$ "x"];
        _y = _value[$ "y"];
    }
    else
    {
        __GuiError($".resize layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    if (is_numeric(_x))
    {
        if ((_x != GUI_RESIZE_STATIC) && (_x != GUI_RESIZE_SHRINK) && (_x != GUI_RESIZE_GROW))
        {
            __GuiError($".resize.x layout property must be \"static\", \"shrink\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_SHRINK}, or {GUI_RESIZE_GROW} (value was {_x})");
        }
    }
    else if (is_string(_x))
    {
        if (_x == "static")
        {
            _x = GUI_RESIZE_STATIC;
        }
        else if (_x == "shrink")
        {
            _x = GUI_RESIZE_SHRINK;
        }
        else if (_x == "grow")
        {
            _x = GUI_RESIZE_GROW;
        }
        else
        {
            __GuiError($".resize.x layout property must be \"static\", \"shrink\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_SHRINK}, or {GUI_RESIZE_GROW} (value was {_x})");
        }
    }
    else
    {
        __GuiError($".resize.x layout property must be \"static\", \"shrink\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_SHRINK}, or {GUI_RESIZE_GROW} (value was {_x})");
    }
    
    if (is_numeric(_y))
    {
        if ((_y != GUI_RESIZE_STATIC) && (_y != GUI_RESIZE_SHRINK) && (_y != GUI_RESIZE_GROW))
        {
            __GuiError($".resize.y layout property must be \"static\", \"shrink\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_SHRINK}, or {GUI_RESIZE_GROW} (value was {_y})");
        }
    }
    else if (is_string(_y))
    {
        if (_y == "static")
        {
            _y = GUI_RESIZE_STATIC;
        }
        else if (_y == "shrink")
        {
            _y = GUI_RESIZE_SHRINK;
        }
        else if (_y == "grow")
        {
            _y = GUI_RESIZE_GROW;
        }
        else
        {
            __GuiError($".resize.y layout property must be \"static\", \"shrink\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_SHRINK}, or {GUI_RESIZE_GROW} (value was {_y})");
        }
    }
    else
    {
        __GuiError($".resize.y layout property must be \"static\", \"shrink\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_SHRINK}, or {GUI_RESIZE_GROW} (value was {_y})");
    }
    
    GuiLayoutSetResizeType(_x, _y, _element);
}



////////
// .padding
////////
function __GuiLayoutSetFromJSON_padding(_element, _value)
{
    if (is_numeric(_value))
    {
        GuiLayoutSetPadding(_value, _value, _value, _value, _element);
    }
    else if (is_array(_value))
    {
        if (array_length(_value) != 4)
        {
            __GuiError($".padding layout property must have 4 elements if it is an array (length = {array_length(_value)})");
        }
        
        GuiLayoutSetPadding(_value[0], _value[1], _value[2], _value[3], _element);
    }
    else if (is_struct(_value))
    {
        GuiLayoutSetPadding(_value[$ "l"] ?? _value[$ "left"],
                            _value[$ "t"] ?? _value[$ "top"],
                            _value[$ "r"] ?? _value[$ "right"],
                            _value[$ "b"] ?? _value[$ "bottom"],
                            _element);
    }
    else
    {
        __GuiError($".padding layout property must be a number, a 4-element array, or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .gutter
////////
function __GuiLayoutSetFromJSON_gutter(_element, _value)
{
    if (is_numeric(_value))
    {
        GuiLayoutSetGutter(_value, _value, _element);
    }
    else if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".gutter layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        GuiLayoutSetGutter(_value[0], _value[1], _element);
    }
    else if (is_struct(_value))
    {
        GuiLayoutSetGutter(_value[$ "x"] ?? _value[$ "h"], _value[$ "y"] ?? _value[$ "v"], _element);
    }
    else
    {
        __GuiError($".gutter layout property must be a number, a 2-element array, or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .alignSelf
////////
function __GuiLayoutSetFromJSON_alignSelf(_element, _value)
{
    var _h = undefined;
    var _v = undefined;
    
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".align layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        _h = _value[0];
        _v = _value[1];
    }
    else if (is_struct(_value))
    {
        _h = _value[$ "h"] ?? _value[$ "x"];
        _v = _value[$ "v"] ?? _value[$ "y"];
    }
    else
    {
        __GuiError($".align layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    if (not is_numeric(_h))
    {
        __GuiError($".align.h layout property must be a number (was \"{typeof(_h)}\")");;
    }
    
    if (not is_numeric(_v))
    {
        __GuiError($".align.v layout property must be a number (was \"{typeof(_v)}\")");;
    }
    
    GuiLayoutSetAlignSelf(_h, _v, _element);
}



////////
// .listAlign
////////
function __GuiLayoutSetFromJSON_listAlign(_element, _value)
{
    var _h = undefined;
    var _v = undefined;
    
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".listAlign layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        _h = _value[0];
        _v = _value[1];
    }
    else if (is_struct(_value))
    {
        _h = _value[$ "h"] ?? _value[$ "x"];
        _v = _value[$ "v"] ?? _value[$ "y"];
    }
    else
    {
        __GuiError($".listAlign layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    if (is_numeric(_h))
    {
        if ((_h != fa_left) && (_h != fa_center) && (_h != fa_right))
        {
            __GuiError($".listAlign.h layout property must be \"left\", \"shrink\", \"grow\", {fa_left}, {fa_center}, or {fa_right} (value was {_h})");
        }
    }
    else if (is_string(_h))
    {
        if (_h == "left")
        {
            _h = fa_left;
        }
        else if ((_h == "center") || (_h == "centre"))
        {
            _h = fa_center;
        }
        else if (_h == "right")
        {
            _h = fa_right;
        }
        else
        {
            __GuiError($".listAlign.h layout property invalid (value was {_h}). Must be one of:\n- \"left\"\n- \"center\"\n- \"right\"\n- {fa_left}\n- {fa_center}\n- {fa_right}");
        }
    }
    else
    {
        __GuiError($".listAlign.h layout property invalid (value was {_h}). Must be one of:\n- \"left\"\n- \"center\"\n- \"right\"\n- {fa_left}\n- {fa_center}\n- {fa_right}");
    }
    
    if (is_numeric(_v))
    {
        if ((_v != fa_top) && (_v != fa_middle) && (_v != fa_bottom))
        {
            __GuiError($".listAlign.y layout property must be \"top\", \"middle\", \"bottom\", {fa_top}, {fa_middle}, or {fa_bottom} (value was {_v})");
        }
    }
    else if (is_string(_v))
    {
        if (_v == "top")
        {
            _v = fa_top;
        }
        else if (_v == "middle")
        {
            _v = fa_middle;
        }
        else if (_v == "bottom")
        {
            _v = fa_bottom;
        }
        else
        {
            __GuiError($".listAlign.v layout property invalid (value was {_v}). Must be one of:\n- \"top\"\n- \"middle\"\n- \"bottom\"\n- {fa_top}\n- {fa_middle}\n- {fa_bottom}");
        }
    }
    else
    {
        __GuiError($".listAlign.v layout property invalid (value was {_v}). Must be one of:\n- \"top\"\n- \"middle\"\n- \"bottom\"\n- {fa_top}\n- {fa_middle}\n- {fa_bottom}");
    }
    
    GuiLayoutSetListAlign(_h, _v, _element);
}



////////
// .listAxis
////////
function __GuiLayoutSetFromJSON_listAxis(_element, _value)
{
    if (is_numeric(_value))
    {
        if ((_value != GUI_AXIS_X) && (_value != GUI_AXIS_Y))
        {
            __GuiError($".listAxis layout property must be \"x\", \"y\", {GUI_AXIS_X}, or {GUI_AXIS_Y} (value was {_value})");
        }
    }
    else if (is_string(_value))
    {
        if (_value == "x")
        {
            _value = GUI_AXIS_X;
        }
        else if (_value == "y")
        {
            _value = GUI_AXIS_Y;
        }
        else
        {
            __GuiError($".listAxis layout property must be \"x\", \"y\", {GUI_AXIS_X}, or {GUI_AXIS_Y} (value was {_value})");
        }
    }
    else
    {
        __GuiError($".listAxis layout property must be \"x\", \"y\", {GUI_AXIS_X}, or {GUI_AXIS_Y} (value was {_value})");
    }
    
    GuiLayoutSetListAxis(_value, _element);
}



////////
// .gridSize
////////
function __GuiLayoutSetFromJSON_gridSize(_element, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".gridSize layout property must have two elements if it is an array (length = {array_length(_value)})");
        }
        
        GuiLayoutSetGridSize(_value[0], _value[1], _element);
    }
    else if (is_struct(_value))
    {
        GuiLayoutSetGridSize(_value[$ "columns"],
                       _value[$ "rows"   ],
                       _element);
    }
    else
    {
        __GuiError($".gridSize layout property must be a two-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}