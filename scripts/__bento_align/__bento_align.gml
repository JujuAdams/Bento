/// @param alignmentStruct
/// @param target
/// @param offset

function __bento_align(_struct, _target, _offset)
{
    if (!__bento_check_layout_parenting(self, _target))
    {
        throw "Bento: Layout parenting cycle created (" + string(self) + " targeting " + string(_target) + ")";
        return false;
    }
    
    with(_struct)
    {
        target = _target;
        offset = _offset;
    }
    
    if (instanceof(_target) == "bento_class_element")
    {
        if (__bento_array_find(_target.alignment.children, self) < 0)
        {
            __bento_array_add(_target.alignment.children, self);
        }
    }
}