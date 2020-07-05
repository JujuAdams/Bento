/// @param array
/// @param index

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
