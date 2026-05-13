// Feather disable all

/// Returns whether an element will block scrolling using a drag gesture when held.
/// 
/// @param [element=self]

function BentoGetHoldBlocksDragScroll(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__holdBlocksDragScroll : false;
}