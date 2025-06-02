// Feather disable all

/// Sets the local depth of an instance to be at the top of its siblings.
/// 
/// @param [element=self]
/// @param [delta=1]

function GuiSetDepthTop(_element = self, _delta = 1)
{
    if (not GuiExists(_element)) return;
    
    var _parent = _element.GUI_VARS.__parent;
    if (not GuiExists(_parent)) return;
    
    var _array = _parent.__childArray;
    var _length = array_length(_array);
    
    var _i = 0;
    repeat(_length)
    {
        if (GuiExists(_array[_i]))
        {
            GuiSetDepth(_array[_i].__drawDepth - _delta, _element);
            return;
        }
        
        ++_i;
    }
    
    GuiSetDepth(0, _element);
}