// Feather disable all

/// Sets the local depth of an element to be at the top of its siblings.
/// 
/// @param [element=self]
/// @param [delta=1]

function BentoSetDepthTop(_element = self, _delta = 1)
{
    if (not BentoExists(_element)) return;
    
    var _parent = _element.BENTO_VARS.__parent;
    if (not BentoExists(_parent)) return;
    
    var _array = _parent.BENTO_VARS.__childArray;
    var _length = array_length(_array);
    
    var _i = 0;
    repeat(_length)
    {
        if (BentoExists(_array[_i].__attachedElement))
        {
            BentoSetDepth(_array[_i].__drawDepth - _delta, _element);
            return;
        }
        
        ++_i;
    }
    
    BentoSetDepth(0, _element);
}