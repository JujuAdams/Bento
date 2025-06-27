// Feather disable all

/// Sets the local depth for an instance.
/// 
/// @param depth
/// @param [element=self]

function BentoSetDepth(_depth, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_depth == __drawDepth) return;
        __drawDepth = _depth;
        
        __BentoMarkDrawOrderDirty(__parent);
    }
}