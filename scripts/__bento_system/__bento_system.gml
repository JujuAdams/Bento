#macro BENTO_VERSION  "0.0.0"
#macro BENTO_DATE     "2020-04-14"

#macro BENTO_ALIGN_LEFT     "left"
#macro BENTO_ALIGN_TOP      "top"
#macro BENTO_ALIGN_RIGHT    "right"
#macro BENTO_ALIGN_BOTTOM   "bottom"
#macro BENTO_ALIGN_CENTER   "center"
#macro BENTO_ALIGN_CENTRE   "centre"
#macro BENTO_ALIGN_MIDDLE   "middle"
#macro BENTO_ALIGN_EVEN     "even"
#macro BENTO_ALIGN_BETWEEN  "between"
#macro BENTO_ALIGN_AROUND   "around"
#macro BENTO_ALIGN_STRETCH  "stretch"
#macro BENTO_STRETCH        "stretch"

#macro bento_clip    global.__bento_clip

global.__bento_element_count = 0;

/// @function __bento_call_method(function)
/// @param function
/// @param [argument]
function __bento_call_method()
{
    var _function = argument[0];
    var _argument = (argument_count > 1)? argument[1] : undefined;
    
    var _self = self;
    
    if (_function == undefined)
    {
        return undefined;
    }
    else if (is_method(_function))
    {
        if (method_get_self(_function) != _self) _function = method(_self, _function);
        return _function(_argument);
    }
    else
    {
        return script_execute(_function, _argument);
    }
}

/// @function __bento_mouse_event(event)
/// @param event
function __bento_mouse_event(_event)
{
    __bento_call_method(properties.internal_mouse_event, _event);
    __bento_call_method(variable_struct_get(callback, "mouse_" + _event));
    __bento_call_method(callback.mouse_event, _event);
}

function __bento_resolve_width()
{
    if (instanceof(parent) != "bento_element_class") return properties.width;
    return __bento_width_perc(parent.properties.bbox_content, properties.width);
}

function __bento_resolve_height()
{
    if (instanceof(parent) != "bento_element_class") return properties.height;
    return __bento_height_perc(parent.properties.bbox_content, properties.height);
}

/// @param boundingBoxStruct
/// @param value
function __bento_width_perc(_bbox, _value)
{
    if (is_real(_value) || is_int32(_value) || is_int64(_value) || is_bool(_value)) return _value;
    
    var _out = 0;
    if (is_string(_value))
    {
        var _length = string_length(_value);
        if (string_char_at(_value, _length) == "%")
        {
            try
            {
                _out = real(string_copy(_value, 1, _length-1))/100;
            }
            catch(_error)
            {
                return 0;
            }
            
            if (is_struct(_bbox))
            {
                return _out*(_bbox.r - _bbox.l);
            }
            else
            {
                return _out*_bbox;
            }
        }
    }
        
    return 0;
}

/// @param boundingBoxStruct
/// @param value
function __bento_height_perc(_bbox, _value)
{
    if (is_real(_value) || is_int32(_value) || is_int64(_value) || is_bool(_value)) return _value;
    
    var _out = 0;
    if (is_string(_value))
    {
        var _length = string_length(_value);
        if (string_char_at(_value, _length) == "%")
        {
            try
            {
                _out = real(string_copy(_value, 1, _length-1))/100;
            }
            catch(_error)
            {
                return 0;
            }
            
            if (is_struct(_bbox))
            {
                return _out*(_bbox.b - _bbox.t);
            }
            else
            {
                return _out*_bbox;
            }
        }
    }
        
    return 0;
}



#region Struct/Array manipulation

function __bento_array_add(_array, _value)
{
    _array[@ array_length(_array)] = _value;
}

function __bento_array_delete(_array, _index)
{
    var _max = array_length(_array)-1;
    var _new = array_create(_max);
    
    if (_index == 0)
    {
        array_copy(_new, 0, _array, 1, _max);
    }
    else if (_index == _max)
    {
        array_copy(_new, 0, _array, 0, _max);
    }
    else
    {
        array_copy(_new, 0, _array, 0, _index);
        array_copy(_new, _index, _array, _index + 1, _max - _index);
    }
    
    return _new;
}

function __bento_deep_copy(_value)
{
    if (is_struct(_value))
    {
        return __bento_deep_copy_struct(_value);
    }
    else if (is_array(_value))
    {
        return __bento_deep_copy_array(_value);
    }
    else
    {
        return _value;
    }
}

function __bento_deep_copy_struct(_struct)
{
    var _new_struct = {};
    
    var _names_array = variable_struct_get_names(_struct);
    var _i = 0;
    repeat(array_length(_names_array))
    {
        var _name = _names_array[_i];
        variable_struct_set(_new_struct, _name, __bento_deep_copy(variable_struct_get(_struct, _name)));
        ++_i;
    }
    
    return _new_struct;
}

function __bento_deep_copy_array(_array)
{
    var _new_array = [];
    
    var _i = 0;
    repeat(array_length(_array))
    {
        _new_array[@ _i] = __bento_deep_copy(_array[_i]);
        ++_i;
    }
    
    return _new_array;
}

#endregion



#region Clipping

global.__bento_uniform_clip = shader_get_uniform(__shd_bento_clip, "u_vClip");

global.__bento_clip_drawing = false;
bento_clip = {
    l : -999999,
    t : -999999,
    r :  999999,
    b :  999999,
}

global.__bento_stack_clip_l = ds_stack_create();
global.__bento_stack_clip_t = ds_stack_create();
global.__bento_stack_clip_r = ds_stack_create();
global.__bento_stack_clip_b = ds_stack_create();

/// @function __bento_clip_set(left, top, right, bottom)
/// @param left
/// @param top
/// @param right
/// @param bottom
function __bento_clip_set(_left, _top, _right, _bottom)
{
    if (global.__bento_clip_drawing) shader_set_uniform_f(global.__bento_uniform_clip, _left, _top, _right, _bottom);
    
    bento_clip.l = _left;
    bento_clip.t = _top;
    bento_clip.r = _right;
    bento_clip.b = _bottom;
}

/// @function __bento_clip_push(bboxStruct, [newFrame])
/// @param bboxStruct
/// @param [newFrame]
function __bento_clip_push()
{
    var _bbox      = argument[0];
    var _new_frame = (argument_count > 1)? argument[1] : false;
    
    if (_new_frame)
    {
        var _l = _bbox.l;
        var _t = _bbox.t;
        var _r = _bbox.r;
        var _b = _bbox.b;
    }
    else
    {
        var _l = max(bento_clip.l, _bbox.l);
        var _t = max(bento_clip.t, _bbox.t);
        var _r = min(bento_clip.r, _bbox.r);
        var _b = min(bento_clip.b, _bbox.b);
    }
    
    ds_stack_push(global.__bento_stack_clip_l, _l);
    ds_stack_push(global.__bento_stack_clip_t, _t);
    ds_stack_push(global.__bento_stack_clip_r, _r);
    ds_stack_push(global.__bento_stack_clip_b, _b);
    
    __bento_clip_set(_l, _t, _r, _b);
}

function __bento_clip_pop()
{
    ds_stack_pop(global.__bento_stack_clip_l);
    ds_stack_pop(global.__bento_stack_clip_t);
    ds_stack_pop(global.__bento_stack_clip_r);
    ds_stack_pop(global.__bento_stack_clip_b);
    
    var _l = ds_stack_top(global.__bento_stack_clip_l);
    var _t = ds_stack_top(global.__bento_stack_clip_t);
    var _r = ds_stack_top(global.__bento_stack_clip_r);
    var _b = ds_stack_top(global.__bento_stack_clip_b);
    
    __bento_clip_set(_l, _t, _r, _b);
}

/// @function __bento_clip_reset(left, top, right, bottom)
/// @param left
/// @param top
/// @param right
/// @param bottom
function __bento_clip_reset(_left, _top, _right, _bottom)
{
    ds_stack_clear(global.__bento_stack_clip_l);
    ds_stack_clear(global.__bento_stack_clip_t);
    ds_stack_clear(global.__bento_stack_clip_r);
    ds_stack_clear(global.__bento_stack_clip_b);
    
    ds_stack_push(global.__bento_stack_clip_l, _left  );
    ds_stack_push(global.__bento_stack_clip_t, _top   );
    ds_stack_push(global.__bento_stack_clip_r, _right );
    ds_stack_push(global.__bento_stack_clip_b, _bottom);
    
    __bento_clip_set(_left, _top, _right, _bottom);
}

#endregion