// Feather disable all

/// Sets the priority of an instance to be at the bottom of its siblings.
/// 
/// @param [instance=self]
/// @param [delta=1]

function GuiSetPriorityBottom(_instance = self, _delta = 1)
{
    if (not GUI_EXISTS(_instance)) return;
    
    var _parent = _instance.GUI_VARS.__parent;
    if (not GUI_EXISTS(_parent)) return;
    
    var _array = _parent.__childArray;
    var _length = array_length(_array);
    
    var _i = 0;
    repeat(_length)
    {
        if (GUI_EXISTS(_array[_i]))
        {
            GuiSetPriority(_array[_i].__priority - _delta, _instance);
            return;
        }
        
        ++_i;
    }
    
    GuiSetPriority(0, _instance);
}