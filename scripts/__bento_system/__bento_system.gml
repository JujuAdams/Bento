#macro BENTO_VERSION  "0.0.0"
#macro BENTO_DATE     "2020-07-04"

#macro bento_clip    global.__bento_clip
#macro bento_prev    global.__bento_prev

global.__bento_element_count = 0;
bento_prev = undefined;


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