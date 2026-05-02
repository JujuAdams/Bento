// Feather disable all

/// Sets the padding inside an element. Positive padding values will position children away from
/// the edges of the element.
/// 
/// @param size
/// @param [element=self]

function BentoLayoutSetPadding(_size, _element = self)
{
    return BentoLayoutSetPaddingExt(_size, _size, _size, _size, _element);
}