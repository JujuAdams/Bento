// Feather disable all

/// Creates a GUI instances based on input JSON data. This function can be used to create multiple
/// instances and define multiple properties for those instances. More information on the expected
/// JSON format can be found in the `GUI JSON Format` note.
/// 
/// This function will return the instance that gets created or, if the root node of the JSON is
/// an array, this function will return the first instance that gets created.
/// 
/// @param json
/// @param [parentInstance=id]
/// @param [metadata]

function GuiCreateViaJSON(_json, _parent = id, _metadata = undefined)
{
    var _firstInstance = undefined;
    
    if (is_array(_json))
    {
        var _i = 0;
        repeat(array_length(_json))
        {
            var _instance = __GuiCreateViaJSONInner(_json, _parent, _metadata);
            
            if (_firstInstance == undefined)
            {
                _firstInstance = _instance;
            }
            
            ++_i;
        }
        
        return _firstInstance;
    }
    else
    {
        return __GuiCreateViaJSONInner(_json, _parent, _metadata);
    }
}

function __GuiCreateViaJSONInner(_json, _parent = id, _metadata = undefined)
{
    if (is_array(_json))
    {
        var _i = 0;
        repeat(array_length(_json))
        {
            __GuiCreateViaJSONInner(_json[_i], _parent, _metadata);
            ++_i;
        }
    }
    else if (is_struct(_json))
    {
        //Determine object to create
        //We accept object handles, stringified object handles, and object names
        var _object = _json[$ "object"];
        if (is_string(_object))
        {
            var _convertedObject = asset_get_index(_object);
            
            if (not object_exists(_convertedObject))
            {
                _convertedObject = handle_parse(_object);
            }
        }
        else if (not is_handle(_object))
        {
            __GuiError($"Could not find object \"{object_get_name(_object)}\" (wrong datatype \"{typeof(_object)}\")");
        }
        
        if (not object_exists(_object))
        {
            __GuiError($"Could not find object \"{object_get_name(_object)}\"");
        }
        
        if (not __GuiObjectInheritsFrom(_object, oGuiLibAncestor))
        {
            __GuiError($"Object \"{object_get_name(_object)}\" does not inherit from {object_get_name(oGuiLibAncestor)}");
        }
        
        //Unpack and validate the .vars property
        var _vars = _json[$ "vars"];
        if ((_vars != undefined) && (not is_struct(_vars)))
        {
            __GuiError($".vars property is incorrect datatype, must be a struct (was \"{typeof(_vars)}\")");
        }
        
        //Create the instance itself
        var _instance = GuiCreate(_object, _vars, _parent);
        
        //Apply layout options
        var _layout = _json[$ "layout"];
        if (_layout != undefined)
        {
            if (not is_struct(_layout))
            {
                __GuiError($".layout property is incorrect datatype, must be a struct (was \"{typeof(_layout)}\")");
            }
            else
            {
                var _nameArray = variable_struct_get_names(_layout);
                var _i = 0;
                repeat(array_length(_nameArray))
                {
                    var _name  = _nameArray[_i];
                    var _value = _layout[$ _name];
                    
                    if (_name == "offset")
                    {
                        __GuiLayoutJSON_offset(_instance, _value);
                    }
                    else if (_name == "size")
                    {
                        __GuiLayoutJSON_size(_instance, _value);
                    }
                    else if (_name == "minSize")
                    {
                        __GuiLayoutJSON_minSize(_instance, _value);
                    }
                    else if (_name == "maxSize")
                    {
                        __GuiLayoutJSON_maxSize(_instance, _value);
                    }
                    else if (_name == "resize")
                    {
                        __GuiLayoutJSON_resize(_instance, _value);
                    }
                    else if (_name == "padding")
                    {
                        __GuiLayoutJSON_padding(_instance, _value);
                    }
                    else if (_name == "align")
                    {
                        __GuiLayoutJSON_align(_instance, _value);
                    }
                    else if (_name == "gutter")
                    {
                        if ((not __GuiObjectInheritsFrom(_object, oGuiLibList)) && (not __GuiObjectInheritsFrom(_object, oGuiLibGrid)))
                        {
                            __GuiError($"Cannot use .gutter on an object ({object_get_name(_object)}) that does not inherit from {object_get_name(oGuiLibList)} or {object_get_name(oGuiLibGrid)}");
                        }
                        
                        __GuiLayoutJSON_gutter(_instance, _value);
                    }
                    else if (_name == "listAlign")
                    {
                        if (not __GuiObjectInheritsFrom(_object, oGuiLibList))
                        {
                            __GuiError($"Cannot use .listAlign on an object ({object_get_name(_object)}) that does not inherit from {object_get_name(oGuiLibList)}");
                        }
                        
                        __GuiLayoutJSON_listAlign(_instance, _value);
                    }
                    else if (_name == "listAxis")
                    {
                        if (not __GuiObjectInheritsFrom(_object, oGuiLibList))
                        {
                            __GuiError($"Cannot use .listAxis on an object ({object_get_name(_object)}) that does not inherit from {object_get_name(oGuiLibList)}");
                        }
                        
                        __GuiLayoutJSON_listAxis(_instance, _value);
                    }
                    else if (_name == "gridSize")
                    {
                        if (not __GuiObjectInheritsFrom(_object, oGuiLibGrid))
                        {
                            __GuiError($"Cannot use .gridSize on an object ({object_get_name(_object)}) that does not inherit from {object_get_name(oGuiLibGrid)}");
                        }
                        
                        __GuiLayoutJSON_gridSize(_instance, _value);
                    }
                    else
                    {
                        __GuiError($"Layout property name \"{_name}\" not recognized or not supported");
                    }
                    
                    ++_i;
                }
            }
        }
        
        var _children = _json[$ "children"];
        if (_children != undefined)
        {
            if (is_string(_children))
            {
                var _processor = GUI_JSON_CHILDREN_STRING_PROCESSOR;
                if (is_callable(_processor))
                {
                    _children = _processor(_children, _metadata);
                }
                else
                {
                    __GuiError($".children was provided as a string but `GUI_JSON_CHILDREN_STRING_PROCESSOR` is not a function");
                }
            }
            
            if (is_method(_children))
            {
                _children = _children(_metadata);
                
                if (not is_array(_children))
                {
                    __GuiError($".children method did not return an array (was {typeof(_children)})");
                }
            }
            
            if (not is_array(_children))
            {
                __GuiError($".children property must be an array (was {typeof(_children)})");
            }
            else
            {
                __GuiCreateViaJSONInner(_children, _instance, _metadata);
            }
        }
        
        return _instance;
    }
    else
    {
        __GuiError($"JSON structure must be made from arrays and structs (found datatype \"{typeof(_json)}\")");
    }
}



////////
// .offset
////////
function __GuiLayoutJSON_offset(_instance, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".offset layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        GuiSetLayoutOffset(_value[0], _value[1], _instance);
    }
    else if (is_struct(_value))
    {
        GuiSetLayoutOffset(_value[$ "x"], _value[$ "y"], _instance);
    }
    else
    {
        __GuiError($".offset layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .size
////////
function __GuiLayoutJSON_size(_instance, _value)
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
    
    GuiSetLayoutSize(_width, _height, _instance);
}



////////
// .minSize
////////
function __GuiLayoutJSON_minSize(_instance, _value)
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
    
    GuiSetLayoutMinSize(_width, _height, _instance);
}



////////
// .maxSize
////////
function __GuiLayoutJSON_maxSize(_instance, _value)
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
    
    GuiSetLayoutMaxSize(_width, _height, _instance);
}



////////
// .resize
////////
function __GuiLayoutJSON_resize(_instance, _value)
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
        if ((_x != GUI_RESIZE_STATIC) && (_x != GUI_RESIZE_FIT) && (_x != GUI_RESIZE_GROW))
        {
            __GuiError($".resize.x layout property must be \"static\", \"fit\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_FIT}, or {GUI_RESIZE_GROW} (value was {_x})");
        }
    }
    else if (is_string(_x))
    {
        if (_x == "static")
        {
            _x = GUI_RESIZE_STATIC;
        }
        else if (_x == "fit")
        {
            _x = GUI_RESIZE_FIT;
        }
        else if (_x == "grow")
        {
            _x = GUI_RESIZE_GROW;
        }
        else
        {
            __GuiError($".resize.x layout property must be \"static\", \"fit\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_FIT}, or {GUI_RESIZE_GROW} (value was {_x})");
        }
    }
    else
    {
        __GuiError($".resize.x layout property must be \"static\", \"fit\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_FIT}, or {GUI_RESIZE_GROW} (value was {_x})");
    }
    
    if (is_numeric(_y))
    {
        if ((_y != GUI_RESIZE_STATIC) && (_y != GUI_RESIZE_FIT) && (_y != GUI_RESIZE_GROW))
        {
            __GuiError($".resize.y layout property must be \"static\", \"fit\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_FIT}, or {GUI_RESIZE_GROW} (value was {_y})");
        }
    }
    else if (is_string(_y))
    {
        if (_y == "static")
        {
            _y = GUI_RESIZE_STATIC;
        }
        else if (_y == "fit")
        {
            _y = GUI_RESIZE_FIT;
        }
        else if (_y == "grow")
        {
            _y = GUI_RESIZE_GROW;
        }
        else
        {
            __GuiError($".resize.y layout property must be \"static\", \"fit\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_FIT}, or {GUI_RESIZE_GROW} (value was {_y})");
        }
    }
    else
    {
        __GuiError($".resize.y layout property must be \"static\", \"fit\", \"grow\", {GUI_RESIZE_STATIC}, {GUI_RESIZE_FIT}, or {GUI_RESIZE_GROW} (value was {_y})");
    }
    
    GuiSetLayoutResizeType(_x, _y, _instance);
}



////////
// .padding
////////
function __GuiLayoutJSON_padding(_instance, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 4)
        {
            __GuiError($".padding layout property must have 4 elements if it is an array (length = {array_length(_value)})");
        }
        
        GuiSetLayoutPadding(_value[0], _value[1], _value[2], _value[3], _instance);
    }
    else if (is_struct(_value))
    {
        GuiSetLayoutPadding(_value[$ "l"] ?? _value[$ "left"],
                            _value[$ "t"] ?? _value[$ "top"],
                            _value[$ "r"] ?? _value[$ "right"],
                            _value[$ "b"] ?? _value[$ "bottom"],
                            _instance);
    }
    else
    {
        __GuiError($".padding layout property must be a 4-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .gutter
////////
function __GuiLayoutJSON_gutter(_instance, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".gutter layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        GuiSetLayoutGutter(_value[0], _value[1], _instance);
    }
    else if (is_struct(_value))
    {
        GuiSetLayoutGutter(_value[$ "x"] ?? _value[$ "h"], _value[$ "y"] ?? _value[$ "v"], _instance);
    }
    else
    {
        __GuiError($".gutter layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .align
////////
function __GuiLayoutJSON_align(_instance, _value)
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
    
    if (is_numeric(_h))
    {
        if ((_h != fa_left) && (_h != fa_center) && (_h != fa_right))
        {
            __GuiError($".align.h layout property must be \"left\", \"fit\", \"grow\", {fa_left}, {fa_center}, or {fa_right} (value was {_h})");
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
            __GuiError($".align.h layout property invalid (value was {_h}). Must be one of:\n- \"left\"\n- \"center\"\n- \"right\"\n- {fa_left}\n- {fa_center}\n- {fa_right}");
        }
    }
    else
    {
        __GuiError($".align.h layout property invalid (value was {_h}). Must be one of:\n- \"left\"\n- \"center\"\n- \"right\"\n- {fa_left}\n- {fa_center}\n- {fa_right}");
    }
    
    if (is_numeric(_v))
    {
        if ((_v != fa_top) && (_v != fa_middle) && (_v != fa_bottom))
        {
            __GuiError($".align.y layout property must be \"top\", \"middle\", \"bottom\", {fa_top}, {fa_middle}, or {fa_bottom} (value was {_v})");
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
            __GuiError($".align.v layout property invalid (value was {_v}). Must be one of:\n- \"top\"\n- \"middle\"\n- \"bottom\"\n- {fa_top}\n- {fa_middle}\n- {fa_bottom}");
        }
    }
    else
    {
        __GuiError($".align.v layout property invalid (value was {_v}). Must be one of:\n- \"top\"\n- \"middle\"\n- \"bottom\"\n- {fa_top}\n- {fa_middle}\n- {fa_bottom}");
    }
    
    GuiSetLayoutAlignSelf(_h, _v, _instance);
}



////////
// .listAlign
////////
function __GuiLayoutJSON_listAlign(_instance, _value)
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
            __GuiError($".listAlign.h layout property must be \"left\", \"fit\", \"grow\", {fa_left}, {fa_center}, or {fa_right} (value was {_h})");
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
    
    GuiSetListAlign(_h, _v, _instance);
}



////////
// .listAxis
////////
function __GuiLayoutJSON_listAxis(_instance, _value)
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
    
    GuiSetListAxis(_value, _instance);
}



////////
// .gridSize
////////
function __GuiLayoutJSON_gridSize(_instance, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __GuiError($".gridSize layout property must have two elements if it is an array (length = {array_length(_value)})");
        }
        
        GuiSetGridSize(_value[0], _value[1], _instance);
    }
    else if (is_struct(_value))
    {
        GuiSetGridSize(_value[$ "columns"],
                       _value[$ "rows"   ],
                       _instance);
    }
    else
    {
        __GuiError($".gridSize layout property must be a two-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}