// Feather disable all

/// Sets the priority of an instance to be at the bottom of its siblings.
/// 
/// @param [element=self]
/// @param [delta=1]

function GuiSetPriorityBottom(_element = self, _delta = 1)
{
    if (not GUI_EXISTS(_element)) return;
    
    var _parent = _element.GUI_VARS.__parent;
    if (not GUI_EXISTS(_parent)) return;
    
    var _array = _parent.__childArray;
    var _length = array_length(_array);
    
    var _i = 0;
    repeat(_length)
    {
        if (GUI_EXISTS(_array[_i]))
        {
            GuiSetPriority(_array[_i].__priority - _delta, _element);
            return;
        }
        
        ++_i;
    }
    
    GuiSetPriority(0, _element);
}