// Feather disable all

/// Returns whether an element is enclosed by its parent (or another ancestor element in the tree).
/// If the element doesn't exist, this function will return `false`.
/// 
/// @param [element=self]

function BentoGetEnclosed(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__enclosed : false;
}