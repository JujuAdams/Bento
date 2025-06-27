// Feather disable all

/// Returns the layer struct that an element is placed on.
/// 
/// @param [element=self]

function BentoGetLayer(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__layer : undefined;
}