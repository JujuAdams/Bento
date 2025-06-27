// Feather disable all

/// Returns the name of an element, as set by `BentoNameSet()`.
/// 
/// @param [element=self]

function BentoNameGet(_element = self)
{
    if (not BentoExists(_element)) return undefined;
    
    return _element.BENTO_VARS.__name;
}