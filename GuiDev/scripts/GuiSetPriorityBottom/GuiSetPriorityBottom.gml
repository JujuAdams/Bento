// Feather disable all

/// Sets the priority of an instance to be at the bottom of its siblings.
/// 
/// @param [instance=id]
/// @param [delta=1]

function GuiSetPriorityBottom(_instance = id, _delta = 1)
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
            GuiSetPriority(_array[_i].priority - _delta, _instance);
            return;
        }
        
        ++_i;
    }
    
    GuiSetPriority(0, _instance);
}