/// @param self
/// @param target

function __bento_check_layout_parenting(_self, _target)
{
    var _array = _self.alignment.children;
    var _i = 0;
    repeat(array_length(_array))
    {
        var _value = _array[_i];
        if (instanceof(_value) == "bento_class_element")
        {
            if (_value == _target) return false;
            if (!__bento_check_layout_parenting(_value, _target)) return false;
        }
        
        ++_i;
    }
    
    return true;
}