// Feather disable all

/// Returns the name of an element, as set by `BentoNameSet()`.
/// 
/// @param [element=self]

function BentoNameGet(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__name : undefined;
}