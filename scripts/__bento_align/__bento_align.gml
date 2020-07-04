/// @param alignmentStruct
/// @param target
/// @param offset

function __bento_align(_struct, _target, _offset)
{
    with(_struct)
    {
        target = _target;
        offset = _offset;
    }
    
    var _array = _target.alignment.children;
    var _i = 0;
    repeat(array_length(_array))
    {
        if (_array[_i] == self) exit;
        ++_i;
    }
    
    __bento_array_add(_array, self);
}