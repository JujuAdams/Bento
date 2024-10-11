// Feather disable all

/// @param instance
/// @param [delta=1]

function GuiSetPriorityTop(_instance, _delta = 1)
{
    if (not instance_exists(_instance)) return;
    
    var _parent = _instance.__parent;
    if (not instance_exists(_parent)) return;
    
    var _array = (_instance.__inside? _parent.__childInsideArray : _parent.__childOutsideArray);
    var _length = array_length(_array);
    
    var _i = 0;
    repeat(_length)
    {
        if (instance_exists(_array[_i]))
        {
            GuiSetPriority(_instance, _array[_i].priority + _delta);
            return;
        }
        
        ++_i;
    }
    
    GuiSetPriority(_instance, 0);
}