// Feather disable all

/// Sets a symmetric margin around an element. Positive margin values will position the element away from 
/// the edge of its parent.
/// 
/// @param size
/// @param [element=self]

function BentoLayoutSetMargin(_size, _element = self)
{
    return BentoLayoutSetMarginExt(_size, _size, _size, _size, _element);
}