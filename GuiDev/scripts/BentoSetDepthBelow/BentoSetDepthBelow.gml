// Feather disable all

/// Sets the local depth of an element to be below (numerically greater than) a sibling element.
/// 
/// @param sibling
/// @param [element=self]
/// @param [delta=1]

function BentoSetDepthBelow(_sibling, _element = self, _delta = 1)
{
    if (not BentoExists(_element)) return;
    
    var _parent = _element.BENTO_VARS.__parent;
    if (not BentoExists(_parent)) return;
    
    BentoSetDepth(BentoExists(_sibling)? (_sibling.__drawDepth + _delta) : 0, _element);
}