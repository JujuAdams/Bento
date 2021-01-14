#macro BENTO_VERSION  "0.0.0"
#macro BENTO_DATE     "2020-07-04"

#macro bento_prev    ((self == global.__bento_prev)? global.__bento_prev2 : global.__bento_prev)

global.__bento_element_count = 0;
global.__bento_prev          = undefined;
global.__bento_prev2         = undefined;

global.bento_view_width  = display_get_gui_width();
global.bento_view_height = display_get_gui_height();

#region Struct/Array manipulation

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