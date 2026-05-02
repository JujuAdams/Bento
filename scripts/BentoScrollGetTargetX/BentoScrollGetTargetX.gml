// Feather disable all

/// Returns the current scroll x-offset target.
/// 
/// @param [element=self]

function BentoScrollGetTargetX(_element = self)
{
    if (not BentoExists(_element)) return 0;
    
    return _element.BENTO_VARS.__scrollTargetX;
}