// Feather disable all

/// Returns the current scroll y-offset target.
/// 
/// @param [element=self]

function BentoScrollGetTargetY(_element = self)
{
    if (not BentoExists(_element)) return 0;
    
    return _element.BENTO_VARS.__scrollTargetY;
}