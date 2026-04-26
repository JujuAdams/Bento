// Feather disable all

/// Sets the layout configuration for a Bento element using JSON data. The format for the JSON
/// data is explained below. You cannot directly move an element using this function. Instead,
/// please use `BentoSetOffset()`.
/// 
/// @param json
/// @param [element=self]
/// 
/// 
/// 
/// Each layout property is associated with a layout function (`BentoLayoutSetSize()` etc.). There
/// are many layout properties that can be modified using this function:
/// 
/// `.anchor`  executes `BentoLayoutSetAnchor()`
/// `.size`    executes `BentoLayoutSetSize()`
/// `.minSize` executes `BentoLayoutSetMinSize()`
/// `.maxSize` executes `BentoLayoutSetMaxSize()`
/// `.resize`  executes `BentoLayoutSetResize()`
/// `.padding` executes `BentoLayoutSetPaddingExt()`
/// `.gutter`  executes `BentoLayoutSetGutter()`
/// `.list`    executes `BentoLayoutList()`
/// `.grid`    executes `BentoLayoutGrid()`
/// 
/// Example:
/// ```
/// {
///     object: oBentoList,
///     visible: false,
///     layout: {
///         resize: ["deflate", "normal"],
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
///                 resize: ["normal", "inflate"],
///                 size: [30, 30],
///             },
///         },
///         {
///             object: oBentoSprite,
///             vars: {
///                 image_blend: c_blue,
///             },
///             layout: {
///                 resize: ["normal", "inflate"],
///                 size: [30, 30],
///             },
///         },
///     ],
/// }
/// ```
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
///     values must be numbers, or you may use `null` (`undefined`) to indicate that no change should
///     be made to a particular value.
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
///     values must be numbers, or you may use `null` (`undefined`) to indicate that no change should
///     be made to a particular value.
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
///     values must be numbers, or you may use `null` (`undefined`) to indicate that no change should
///     be made to a particular value.
/// 
/// `.resize`
///     Calls the `BentoLayoutSetResize()` function on the created element.
///     
///     Can be a 2-element array:
///         [ <x type>, <y type> ]
///     or a struct:
///         {
///             "x": <x type>,
///             "y": <y type>
///         }
///    or a string or number:
///         <x&y type>
///    
///    If you specify a string or number alone then the same type will be applied to both the x and
///    y axes.
///     
///    Resize types must be one of the following:
///    - "normal"
///    - "deflate"
///    - "inflate"
///    - "aspect" (y-axis only)
///    - 0 (equal to BENTO_RESIZE_NORMAL)
///    - 1 (equal to BENTO_RESIZE_DEFLATE)
///    - 2 (equal to BENTO_RESIZE_INFLATE)
///    - 3 (equal to BENTO_RESIZE_ASPECT, y-axis only)
///    
///    You may also use `null` (`undefined`) to indicate that no change should be made to a particular
///    value.
/// 
/// `.padding`
///     Calls the `BentoLayoutSetPaddingExt()` function on the created element.
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
///     must be numbers, or you may use `null` (`undefined`) to indicate that no change should be made
///     to a particular value.
/// 
/// `.anchor`
///     Calls the `BentoLayoutSetAnchor()` function on the created element.
///     
///     Can be a 2-element array:
///         [ <x anchor>, <y anchor> ]
///     or a struct:
///         {
///             "x": <x anchor>,
///             "y": <y anchor>
///         }
///     
///     Alignment values must be numbers.
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
///     Gutter sizes must be numbers, or you may use `null` (`undefined`) to indicate that no change should be
///     made to a particular value.
/// 
/// `.list`
///     Calls the `BentoLayoutList()` function on the created element.
///     
///     Can be a 3-element array:
///         [ <list axis>, <h align>, <v align> ]
///     or a struct:
///         {
///             "axis": <list axis>,
///             "h": <h align>,
///             "v": <v align>
///         }
///     
///     List axis values must be one of the following:
///     - "x"
///     - "y"
///     - 0 (equal to `BENTO_AXIS_X`)
///     - 1 (equal to `BENTO_AXIS_Y`)
///     
///     Horizontal and vertical alignment values must be a number, typically from `0` to `1`. You may
///     also use `null` (`undefined`) for any value to indicate that no change should be made.
///     
/// `.grid`
///     Calls the `BentoLayoutGrid()` function on the created element.
///     
///     Can be a 2-element array:
///         [ <columns>, <rows> ]
///     or a struct:
///         {
///             "columns": <columns>,
///             "rows": <rows>
///         }
///     
///     Column and row values must be integers, or you may use `null` (`undefined`) to indicate that no change
///     should be made to a particular value.

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
            else if (_name == "anchor")
            {
                __BentoLayoutSetFromJSON_anchor(_element, _value);
            }
            else if (_name == "gutter")
            {
                __BentoLayoutSetFromJSON_gutter(_element, _value);
            }
            else if (_name == "list")
            {
                __BentoLayoutSetFromJSON_list(_element, _value);
            }
            else if (_name == "grid")
            {
                __BentoLayoutSetFromJSON_grid(_element, _value);
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
    else if (is_string(_value) || is_numeric(_value))
    {
        _x = _value;
        _y = _value;
    }
    else if (_value == undefined)
    {
        return;
    }
    else
    {
        __BentoError($".resize layout property must be a 2-element array, a struct, a number, or a string (typeof \"{typeof(_value)}\")");
    }
    
    if (is_numeric(_x))
    {
        if ((_x != BENTO_RESIZE_NORMAL) && (_x != BENTO_RESIZE_DEFLATE) && (_x != BENTO_RESIZE_INFLATE))
        {
            __BentoError($".resize.x layout property must be \"normal\", \"deflate\", \"inflate\", {BENTO_RESIZE_NORMAL}, {BENTO_RESIZE_DEFLATE}, or {BENTO_RESIZE_INFLATE} (value was {_x})");
        }
    }
    else if (is_string(_x))
    {
        if (_x == "normal")
        {
            _x = BENTO_RESIZE_NORMAL;
        }
        else if (_x == "deflate")
        {
            _x = BENTO_RESIZE_DEFLATE;
        }
        else if (_x == "inflate")
        {
            _x = BENTO_RESIZE_INFLATE;
        }
        else
        {
            __BentoError($".resize.x layout property must be \"normal\", \"deflate\", \"inflate\", {BENTO_RESIZE_NORMAL}, {BENTO_RESIZE_DEFLATE}, or {BENTO_RESIZE_INFLATE} (value was {_x})");
        }
    }
    else if (_x != undefined)
    {
        __BentoError($".resize.x layout property must be \"normal\", \"deflate\", \"inflate\", {BENTO_RESIZE_NORMAL}, {BENTO_RESIZE_DEFLATE}, or {BENTO_RESIZE_INFLATE} (value was {_x})");
    }
    
    if (is_numeric(_y))
    {
        if ((_y != BENTO_RESIZE_NORMAL) && (_y != BENTO_RESIZE_DEFLATE) && (_y != BENTO_RESIZE_INFLATE) && (_y != BENTO_RESIZE_ASPECT))
        {
            __BentoError($".resize.y layout property must be \"normal\", \"deflate\", \"inflate\", \"aspect\", {BENTO_RESIZE_NORMAL}, {BENTO_RESIZE_DEFLATE}, {BENTO_RESIZE_INFLATE}, or {BENTO_RESIZE_ASPECT} (value was {_y})");
        }
    }
    else if (is_string(_y))
    {
        if (_y == "normal")
        {
            _y = BENTO_RESIZE_NORMAL;
        }
        else if (_y == "deflate")
        {
            _y = BENTO_RESIZE_DEFLATE;
        }
        else if (_y == "inflate")
        {
            _y = BENTO_RESIZE_INFLATE;
        }
        else if (_y == "aspect")
        {
            _y = BENTO_RESIZE_ASPECT;
        }
        else
        {
            __BentoError($".resize.y layout property must be \"normal\", \"deflate\", \"inflate\", \"aspect\", {BENTO_RESIZE_NORMAL}, {BENTO_RESIZE_DEFLATE}, {BENTO_RESIZE_INFLATE}, or {BENTO_RESIZE_ASPECT} (value was {_y})");
        }
    }
    else if (_y != undefined)
    {
        __BentoError($".resize.y layout property must be \"normal\", \"deflate\", \"inflate\", \"aspect\", {BENTO_RESIZE_NORMAL}, {BENTO_RESIZE_DEFLATE}, {BENTO_RESIZE_INFLATE}, or {BENTO_RESIZE_ASPECT} (value was {_y})");
    }
    
    BentoLayoutSetResize(_x, _y, _element);
}



////////
// .padding
////////
function __BentoLayoutSetFromJSON_padding(_element, _value)
{
    if (is_numeric(_value))
    {
        BentoLayoutSetPaddingExt(_value, _value, _value, _value, _element);
    }
    else if (is_array(_value))
    {
        if (array_length(_value) != 4)
        {
            __BentoError($".padding layout property must have 4 elements if it is an array (length = {array_length(_value)})");
        }
        
        BentoLayoutSetPaddingExt(_value[0], _value[1], _value[2], _value[3], _element);
    }
    else if (is_struct(_value))
    {
        BentoLayoutSetPaddingExt(_value[$ "l"] ?? _value[$ "left"],
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
// .anchor
////////
function __BentoLayoutSetFromJSON_anchor(_element, _value)
{
    var _x = undefined;
    var _y = undefined;
    
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".anchor layout property must have 2 elements if it is an array (length = {array_length(_value)})");
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
        __BentoError($".anchor layout property must be a 2-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    if (not is_numeric(_x))
    {
        __BentoError($".anchor.h layout property must be a number (was \"{typeof(_x)}\")");;
    }
    
    if (not is_numeric(_y))
    {
        __BentoError($".anchor.v layout property must be a number (was \"{typeof(_y)}\")");;
    }
    
    BentoLayoutSetAnchor(_x, _y, _element);
}



////////
// .list
////////
function __BentoLayoutSetFromJSON_list(_element, _value)
{
    var _axis   = undefined;
    var _hAlign = undefined;
    var _vAlign = undefined;
    
    if (is_array(_value))
    {
        if (array_length(_value) != 3)
        {
            __BentoError($".list layout property must have 3 elements if it is an array (length = {array_length(_value)})");
        }
        
        _axis   = _value[0];
        _hAlign = _value[1];
        _vAlign = _value[2];
    }
    else if (is_struct(_value))
    {
        _axis   = _value[$ "axis"];
        _hAlign = _value[$ "h"] ?? _value[$ "x"];
        _vAlign = _value[$ "v"] ?? _value[$ "y"];
    }
    else
    {
        __BentoError($".list layout property must be a 3-element array or a struct (typeof \"{typeof(_value)}\")");
    }
    
    if (is_numeric(_axis))
    {
        if ((_axis != BENTO_AXIS_X) && (_axis != BENTO_AXIS_Y))
        {
            __BentoError($".list.axis layout property must be \"x\", \"y\", {BENTO_AXIS_X}, or {BENTO_AXIS_Y} (value was {_axis})");
        }
    }
    else if (is_string(_axis))
    {
        if (_axis == "x")
        {
            _axis = BENTO_AXIS_X;
        }
        else if (_axis == "y")
        {
            _axis = BENTO_AXIS_Y;
        }
        else
        {
            __BentoError($".list.axis layout property must be \"x\", \"y\", {BENTO_AXIS_X}, or {BENTO_AXIS_Y} (value was {_axis})");
        }
    }
    else
    {
        __BentoError($".list.axis layout property must be \"x\", \"y\", {BENTO_AXIS_X}, or {BENTO_AXIS_Y} (value was {_axis})");
    }
    
    if (not is_numeric(_hAlign))
    {
        __BentoError($".list.h layout property must be a number (typeof \"{typeof(_hAlign)}\")");
    }
    
    if (not is_numeric(_vAlign))
    {
        __BentoError($".list.v layout property must be a number (typeof \"{typeof(_vAlign)}\")");
    }
    
    BentoLayoutList(_axis, _hAlign, _vAlign, _element);
}



////////
// .grid
////////
function __BentoLayoutSetFromJSON_grid(_element, _value)
{
    if (is_array(_value))
    {
        if (array_length(_value) != 2)
        {
            __BentoError($".grid layout property must have two elements if it is an array (length = {array_length(_value)})");
        }
        
        BentoLayoutGrid(_value[0], _value[1], undefined, undefined, undefined, undefined, _element);
    }
    else if (is_struct(_value))
    {
        BentoLayoutGrid(_value[$ "columns"], _value[$ "rows"],
                        undefined, undefined, undefined, undefined,
                        _element);
    }
    else
    {
        __BentoError($".grid layout property must be a two-element array or a struct (typeof \"{typeof(_value)}\")");
    }
}