// Feather disable all

/// Returns the local depth for an element.
/// 
/// @param [element=self]

function BentoGetDepth(_element = self)
{
    if (not BentoExists(_element)) return 0;
    
    return _element.BENTO_VARS.__drawDepth;
}