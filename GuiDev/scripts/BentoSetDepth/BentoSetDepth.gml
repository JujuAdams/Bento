// Feather disable all

/// Sets the local draw depth for an element. This only applies within Bento and within the draw
/// order for the element's parent.
/// 
/// @param depth
/// @param [element=self]

function BentoSetDepth(_depth, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (_depth == __drawDepth) return;
        __drawDepth = _depth;
        
        __BentoMarkDrawOrderDirty(__parent);
    }
}