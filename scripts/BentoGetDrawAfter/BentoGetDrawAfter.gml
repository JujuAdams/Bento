// Feather disable all

/// Returns whether an element has its Draw After user event / callback enabled for use by
/// `BentoSetDrawAfter()`.
/// 
/// @param [element=self]

function BentoGetDrawAfter(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    return _element.BENTO_VARS.__drawAfter;
}