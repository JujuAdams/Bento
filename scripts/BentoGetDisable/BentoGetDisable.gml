// Feather disable all

/// Returns whether an element has been disabled by `BentoSetDisable()`.
/// 
/// @param [element=self]

function BentoGetDisable(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    return _element.BENTO_VARS.__disable;
}