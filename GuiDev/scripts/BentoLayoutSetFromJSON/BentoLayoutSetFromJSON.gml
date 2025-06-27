// Feather disable all

/// Sets the layout configuration for a Bento element using JSON data. The format for the JSON
/// data is explained below.
/// 
/// @param json
/// @param [element=self]
/// 
/// 
/// 
/// Each layout property is associated with a layout function (`BentoSetOffset()` etc.). There are
/// many layout properties that can be modified using this function:
/// 
/// `.offset`    executes `BentoSetOffset()`
/// `.size`      executes `BentoLayoutSetSize()`
/// `.minSize`   executes `BentoLayoutSetMinSize()`
/// `.maxSize`   executes `BentoLayoutSetMaxSize()`
/// `.resize`    executes `BentoLayoutSetResizeType()`
/// `.padding`   executes `BentoLayoutSetPadding()`
/// `.align`     executes `BentoLayoutSetAlignSelf()`
/// `.gutter`    executes `BentoLayoutSetGutter()`
/// `.list`      executes `BentoLayoutSetList()` //TODO
/// `.grid`      executes `BentoLayoutSetGrid()` //TODO
/// `.listAlign` executes `BentoLayoutSetListAlign()` //TODO - Remove in favour of the above
/// `.listAxis`  executes `BentoLayoutSetListAxis()`  //TODO - Remove in favour of the above
/// `.gridSize`  executes `BentoLayoutSetGridSize()`  //TODO - Remove in favour of the above
/// 
/// Example:
/// ```
/// {
///     object: oBentoList,
///     visible: false,
///     layout: {
///         resize: ["shrink", "static"],
///         size: [100, 70],
///         axis: "x",
///     },
///     children: [
///         {
///             object: oBentoSprite,
///             vars: {
///                 image_blend: c_red,
///             },
///             layout: {
///                 resize: ["static", "expand"],
///                 size: [30, 30],
///             },
///         },
///         {
///             object: oBentoSprite,
///             vars: {
///                 image_blend: c_blue,
///             },
///             layout: {
///                 resize: ["static", "expand"],
///                 size: [30, 30],
///             },
///         },
///     ],
/// }
/// ```
/// 
/// `.offset`
///     Calls the `BentoSetOffset()` function on the created element.
///     
///     Can be a 2-element array:
///         [ <x offset>, <y offset> ]
///     or a struct:
///         {
///             "x": <x offset>,
///             "y": <y offset>
///         }
///     
///     Offset values must be numbers, or you may use `null` to indicate that no change should be made
///     to a particular value.
///     
/// `.size`
///     Calls the `BentoLayoutSetSize()` function on the created element. "Size" means the "preferred
///     size" which is an important detail in the layout algorithm.
///     
///     Can be a 2-element array:
///         [ <width>, <height> ]
///     or a struct:
///         {
///             "w": <width>,
///             "h": <height>
///         }
///     
///     "width" and "x" can be used instead of "w". "height" and "y" can be used instead of "h". Size
///     values must be numbers, or you may use `null` to indicate that no change should be made to a
///     particular value.
///     
/// `.minSize`
///     Calls the `BentoLayoutSetMinSize()` function on the created element.
///     
///     Can be a 2-element array:
///         [ <width>, <height> ]
///     or a struct:
///         {
///             "w": <width>,
///             "h": <height>
///         }
///     
///     "width" and "x" can be used instead of "w". "height" and "y" can be used instead of "h". Size
///     values must be numbers, or you may use `null` to indicate that no change should be made to a
///     particular value.
///     
/// `.maxSize`
///     Calls the `BentoLayoutSetMaxSize()` function on the created element.
///     
///     Can be a 2-element array:
///         [ <width>, <height> ]
///     or a struct:
///         {
///             "w": <width>,
///             "h": <height>
///         }
///     
///     "width" and "x" can be used instead of "w". "height" and "y" can be used instead of "h". Size
///     values must be numbers, or you may use `null` to indicate that no change should be made to a
///     particular value.
/// 
/// `.resize`
///     Calls the `BentoLayoutSetResizeType()` function on the created element.
///     
///     Can be a 2-element array:
///         [ <x type>, <y type> ]
///     or a struct:
///         {
///             "x": <x type>,
///             "y": <y type>
///         }
///     
///     Resize types must be one of the following:
///     - "static"
///     - "shrink"
///     - "expand"
///     - 0 (equal to BENTO_RESIZE_STATIC)
///     - 1 (equal to BENTO_RESIZE_SHRINK)
///     - 2 (equal to BENTO_RESIZE_EXPAND)
///     
///     You may also use `null` to indicate that no change should be made to a particular value.
/// 
/// `.padding`
///     Calls the `BentoLayoutSetPadding()` function on the created element.
///     
///     Can be a 2-element array:
///         [ <left>, <top>, <right>, <bottom> ]
///     or a struct:
///         {
///             "l": <left>,
///             "t": <top>,
///             "r": <right>,
///             "b": <bottom>
///         }
///     
///     "left", "top", "right, "bottom" instead of "l", "t", "r", "b" respectively. Padding values
///     must be numbers, or you may use `null` to indicate that no change should be made to a
///     particular value.
/// 
/// `.align`
///     Calls the `BentoLayoutSetAlignSelf()` function on the created element.
///     
///     Can be a 2-element array:
///         [ <h align>, <v align> ]
///     or a struct:
///         {
///             "h": <h align>,
///             "v": <v align>
///         }
///     
///     "x" and "y" can be used instead of "h" and "v" respectively. Alignment values must be numbers.
/// 
/// `.gutter`
///     Calls the `BentoLayoutSetGutter()` function on the created element. This property can only be
///     used for objects that inherit from `oBentoList` or `oBentoGrid`.
///     
///     Can be a 2-element array:
///         [ <x size>, <y size> ]
///     or a struct:
///         {
///             "x": <x size>,
///             "y": <y size>
///         }
///     
///     Gutter sizes must be numbers, or you may use `null` to indicate that no change should be made
///     to a particular value.
/// 
/// `.listAlign`
///     Calls the `BentoLayoutSetListAlign()` function on the created element. This property can only be used
///     for objects that inherit from `oBentoList`.
///     
///     Can be a 2-element array:
///         [ <h align>, <v align> ]
///     or a struct:
///         {
///             "h": <h align>,
///             "v": <v align>
///         }
///     
///     Horizontal alignment values must be one of the following:
///     - "left"
///     - "center"
///     - "centre"
///     - "right"
///     - 0 (equal to fa_left)
///     - 1 (equal to fa_center)
///     - 2 (equal to fa_right)
///     
///     Vertical alignment values must be one of the following:
///     - "right"
///     - "middle"
///     - "bottom"
///     - 0 (equal to fa_top)
///     - 1 (equal to fa_middle)
///     - 2 (equal to fa_bottom)
///     
///     You may also use `null` for either value to indicate that no change should be made.
/// 
/// `.listAxis`
///     Calls the `BentoLayoutSetListAxis()` function on the created element. This property can only be used
///     for objects that inherit from `oBentoList`.
///     
///     List axis values must be one of the following:
///     - "x"
///     - "y"
///     - 0 (equal to BENTO_AXIS_X)
///     - 1 (equal to BENTO_AXIS_Y)
///     
///     You may also use `null` for either value to indicate that no change should be made.
///     
/// `.gridSize`
///     Calls the `BentoLayoutSetGridSize()` function on the created element. This property can only be used
///     for objects that inherit from `oBentoGrid`.
///     
///     Can be a 2-element array:
///         [ <columns>, <rows> ]
///     or a struct:
///         {
///             "columns": <columns>,
///             "rows": <rows>
///         }
///     
///     Column and row values must be integers, or you may use `null` to indicate that no change should
///     be made to a particular value.

function BentoLayoutSetFromJSON(_json, _element = self)
{
    if (not is_struct(_json))
    {
        __BentoError($"Layout JSON is incorrect datatype, must be a struct (was \"{typeof(_json)}\")");
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
                __BentoLayoutSetFromJSON_clampInside(_element, _value);
            }
            else if (_name == "size")
            {
                __BentoLayoutSetFromJSON_size(_element, _value);
            }
            else if (_name == "minSize")
            {
                __BentoLayoutSetFromJSON_minSize(_element, _value);
            }
            else if (_name == "maxSize")
            {
                __BentoLayoutSetFromJSON_maxSize(_element, _value);
            }
            else if (_name == "resize")
            {
                __BentoLayoutSetFromJSON_resize(_element, _value);
            }
            else if (_name == "padding")
            {
                __BentoLayoutSetFromJSON_padding(_element, _value);
            }
            else if (_name == "alignSelf")
            {
                __BentoLayoutSetFromJSON_alignSelf(_element, _value);
            }
            else if (_name == "gutter")
            {
                //FIXME - Reimplement to include struct elements
                //if ((not __BentoObjectInheritsFrom(object_index, oBentoList)) && (not __BentoObjectInheritsFrom(object_index, oBentoGrid)))
                //{
                //    __BentoError($"Cannot use .gutter on an object ({object_get_name(object_index)}) that does not inherit from {object_get_name(oBentoList)} or {object_get_name(oBentoGrid)}");
                //}
                
                __BentoLayoutSetFromJSON_gutter(_element, _value);
            }
            else if (_name == "listAlign")
            {
                //FIXME - Reimplement to include struct elements
                //if (not __BentoObjectInheritsFrom(object_index, oBentoList))
                //{
                //    __BentoError($"Cannot use .listAlign on an object ({object_get_name(object_index)}) that does not inherit from {object_get_name(oBentoList)}");
                //}
                
                __BentoLayoutSetFromJSON_listAlign(_element, _value);
            }
            else if (_name == "listAxis")
            {
                //FIXME - Reimplement to include struct elements
                //if (not __BentoObjectInheritsFrom(object_index, oBentoList))
                //{
                //    __BentoError($"Cannot use .listAxis on an object ({object_get_name(object_index)}) that does not inherit from {object_get_name(oBentoList)}");
                //}
                
                __BentoLayoutSetFromJSON_listAxis(_element, _value);
            }
            else if (_name == "gridSize")
            {
                //FIXME - Reimplement to include struct elements
                //if (not __BentoObjectInheritsFrom(object_index, oBentoGrid))
                //{
                //    __BentoError($"Cannot use .gridSize on an object ({object_get_name(object_index)}) that does not inherit from {object_get_name(oBentoGrid)}");
                //}
                        
                __BentoLayoutSetFromJSON_gridSize(_element, _value);
            }
            else
            {
                __BentoError($"Layout property name \"{_name}\" not recognized or not supported");
            }
                    
            ++_i;
        }
    }
}



////////
// .clampInside
////////
function __BentoLayoutSetFromJSON_clampInside(_element, _value)
{
    if (is_bool(_value))
    {
        BentoLayoutSetClampInside(_value, _element);
    }
    else
    {
        __BentoError($".offset layout property must be a boolean (typeof \"{typeof(_value)}\")");
    }
}



////////
// .size
////////
function __BentoLayoutSetFromJSON_size(_element, _value)
{
    var _width  = undefined;
    var _height = undefined;
    
    //Collect width and height values
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".size layout property must have 2 elements if it is an array (length = {array_length(_value)})");
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
        __BentoError($".size layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    BentoLayoutSetSize(_width, _height, _element);
}



////////
// .minSize
////////
function __BentoLayoutSetFromJSON_minSize(_element, _value)
{
    var _width  = undefined;
    var _height = undefined;
    
    //Collect width and height values
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".minSize layout property must have 2 elements if it is an array (length = {array_length(_value)})");
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
        __BentoError($".minSize layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    BentoLayoutSetMinSize(_width, _height, _element);
}



////////
// .maxSize
////////
function __BentoLayoutSetFromJSON_maxSize(_element, _value)
{
    var _width  = undefined;
    var _height = undefined;
    
    //Collect width and height values
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".maxSize layout property must have 2 elements if it is an array (length = {array_length(_value)})");
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
        __BentoError($".maxSize layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    BentoLayoutSetMaxSize(_width, _height, _element);
}



////////
// .resize
////////
function __BentoLayoutSetFromJSON_resize(_element, _value)
{
    var _x = undefined;
    var _y = undefined;
    
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".resize layout property must have 2 elements if it is an array (length = {array_length(_value)})");
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
        __BentoError($".resize layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    if (is_numeric(_x))
    {
        if ((_x != BENTO_RESIZE_STATIC) && (_x != BENTO_RESIZE_SHRINK) && (_x != BENTO_RESIZE_EXPAND))
        {
            __BentoError($".resize.x layout property must be \"static\", \"shrink\", \"expand\", {BENTO_RESIZE_STATIC}, {BENTO_RESIZE_SHRINK}, or {BENTO_RESIZE_EXPAND} (value was {_x})");
        }
    }
    else if (is_string(_x))
    {
        if (_x == "static")
        {
            _x = BENTO_RESIZE_STATIC;
        }
        else if (_x == "shrink")
        {
            _x = BENTO_RESIZE_SHRINK;
        }
        else if (_x == "expand")
        {
            _x = BENTO_RESIZE_EXPAND;
        }
        else
        {
            __BentoError($".resize.x layout property must be \"static\", \"shrink\", \"expand\", {BENTO_RESIZE_STATIC}, {BENTO_RESIZE_SHRINK}, or {BENTO_RESIZE_EXPAND} (value was {_x})");
        }
    }
    else
    {
        __BentoError($".resize.x layout property must be \"static\", \"shrink\", \"expand\", {BENTO_RESIZE_STATIC}, {BENTO_RESIZE_SHRINK}, or {BENTO_RESIZE_EXPAND} (value was {_x})");
    }
    
    if (is_numeric(_y))
    {
        if ((_y != BENTO_RESIZE_STATIC) && (_y != BENTO_RESIZE_SHRINK) && (_y != BENTO_RESIZE_EXPAND))
        {
            __BentoError($".resize.y layout property must be \"static\", \"shrink\", \"expand\", {BENTO_RESIZE_STATIC}, {BENTO_RESIZE_SHRINK}, or {BENTO_RESIZE_EXPAND} (value was {_y})");
        }
    }
    else if (is_string(_y))
    {
        if (_y == "static")
        {
            _y = BENTO_RESIZE_STATIC;
        }
        else if (_y == "shrink")
        {
            _y = BENTO_RESIZE_SHRINK;
        }
        else if (_y == "expand")
        {
            _y = BENTO_RESIZE_EXPAND;
        }
        else
        {
            __BentoError($".resize.y layout property must be \"static\", \"shrink\", \"expand\", {BENTO_RESIZE_STATIC}, {BENTO_RESIZE_SHRINK}, or {BENTO_RESIZE_EXPAND} (value was {_y})");
        }
    }
    else
    {
        __BentoError($".resize.y layout property must be \"static\", \"shrink\", \"expand\", {BENTO_RESIZE_STATIC}, {BENTO_RESIZE_SHRINK}, or {BENTO_RESIZE_EXPAND} (value was {_y})");
    }
    
    BentoLayoutSetResizeType(_x, _y, _element);
}



////////
// .padding
////////
function __BentoLayoutSetFromJSON_padding(_element, _value)
{
    if (is_numeric(_value))
    {
        BentoLayoutSetPadding(_value, _value, _value, _value, _element);
    }
    else if (is_array(_value))
    {
        if (array_length(_value) != 4)
        {
            __BentoError($".padding layout property must have 4 elements if it is an array (length = {array_length(_value)})");
        }
        
        BentoLayoutSetPadding(_value[0], _value[1], _value[2], _value[3], _element);
    }
    else if (is_struct(_value))
    {
        BentoLayoutSetPadding(_value[$ "l"] ?? _value[$ "left"],
                            _value[$ "t"] ?? _value[$ "top"],
                            _value[$ "r"] ?? _value[$ "right"],
                            _value[$ "b"] ?? _value[$ "bottom"],
                            _element);
    }
    else
    {
        __BentoError($".padding layout property must be a number, a 4-element array, or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .gutter
////////
function __BentoLayoutSetFromJSON_gutter(_element, _value)
{
    if (is_numeric(_value))
    {
        BentoLayoutSetGutter(_value, _value, _element);
    }
    else if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".gutter layout property must have 2 elements if it is an array (length = {array_length(_value)})");
        }
        
        BentoLayoutSetGutter(_value[0], _value[1], _element);
    }
    else if (is_struct(_value))
    {
        BentoLayoutSetGutter(_value[$ "x"] ?? _value[$ "h"], _value[$ "y"] ?? _value[$ "v"], _element);
    }
    else
    {
        __BentoError($".gutter layout property must be a number, a 2-element array, or a struct (typeof \"{typeof(_value)}\")");
    }
}



////////
// .alignSelf
////////
function __BentoLayoutSetFromJSON_alignSelf(_element, _value)
{
    var _h = undefined;
    var _v = undefined;
    
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".align layout property must have 2 elements if it is an array (length = {array_length(_value)})");
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
        __BentoError($".align layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    if (not is_numeric(_h))
    {
        __BentoError($".align.h layout property must be a number (was \"{typeof(_h)}\")");;
    }
    
    if (not is_numeric(_v))
    {
        __BentoError($".align.v layout property must be a number (was \"{typeof(_v)}\")");;
    }
    
    BentoLayoutSetAlignSelf(_h, _v, _element);
}



////////
// .listAlign
////////
function __BentoLayoutSetFromJSON_listAlign(_element, _value)
{
    var _h = undefined;
    var _v = undefined;
    
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".listAlign layout property must have 2 elements if it is an array (length = {array_length(_value)})");
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
        __BentoError($".listAlign layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    if (is_numeric(_h))
    {
        if ((_h != fa_left) && (_h != fa_center) && (_h != fa_right))
        {
            __BentoError($".listAlign.h layout property must be \"left\", \"shrink\", \"expand\", {fa_left}, {fa_center}, or {fa_right} (value was {_h})");
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
            __BentoError($".listAlign.h layout property invalid (value was {_h}). Must be one of:\n- \"left\"\n- \"center\"\n- \"right\"\n- {fa_left}\n- {fa_center}\n- {fa_right}");
        }
    }
    else
    {
        __BentoError($".listAlign.h layout property invalid (value was {_h}). Must be one of:\n- \"left\"\n- \"center\"\n- \"right\"\n- {fa_left}\n- {fa_center}\n- {fa_right}");
    }
    
    if (is_numeric(_v))
    {
        if ((_v != fa_top) && (_v != fa_middle) && (_v != fa_bottom))
        {
            __BentoError($".listAlign.y layout property must be \"top\", \"middle\", \"bottom\", {fa_top}, {fa_middle}, or {fa_bottom} (value was {_v})");
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
            __BentoError($".listAlign.v layout property invalid (value was {_v}). Must be one of:\n- \"top\"\n- \"middle\"\n- \"bottom\"\n- {fa_top}\n- {fa_middle}\n- {fa_bottom}");
        }
    }
    else
    {
        __BentoError($".listAlign.v layout property invalid (value was {_v}). Must be one of:\n- \"top\"\n- \"middle\"\n- \"bottom\"\n- {fa_top}\n- {fa_middle}\n- {fa_bottom}");
    }
    
    BentoLayoutSetListAlign(_h, _v, _element);
}



////////
// .listAxis
////////
function __BentoLayoutSetFromJSON_listAxis(_element, _value)
{
    if (is_numeric(_value))
    {
        if ((_value != BENTO_AXIS_X) && (_value != BENTO_AXIS_Y))
        {
            __BentoError($".listAxis layout property must be \"x\", \"y\", {BENTO_AXIS_X}, or {BENTO_AXIS_Y} (value was {_value})");
        }
    }
    else if (is_string(_value))
    {
        if (_value == "x")
        {
            _value = BENTO_AXIS_X;
        }
        else if (_value == "y")
        {
            _value = BENTO_AXIS_Y;
        }
        else
        {
            __BentoError($".listAxis layout property must be \"x\", \"y\", {BENTO_AXIS_X}, or {BENTO_AXIS_Y} (value was {_value})");
        }
    }
    else
    {
        __BentoError($".listAxis layout property must be \"x\", \"y\", {BENTO_AXIS_X}, or {BENTO_AXIS_Y} (value was {_value})");
    }
    
    BentoLayoutSetListAxis(_value, _element);
}



////////
// .gridSize
////////
function __BentoLayoutSetFromJSON_gridSize(_element, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".gridSize layout property must have two elements if it is an array (length = {array_length(_value)})");
        }
        
        BentoLayoutSetGridSize(_value[0], _value[1], _element);
    }
    else if (is_struct(_value))
    {
        BentoLayoutSetGridSize(_value[$ "columns"],
                             _value[$ "rows"   ],
                             _element);
    }
    else
    {
        __BentoError($".gridSize layout property must be a two-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}