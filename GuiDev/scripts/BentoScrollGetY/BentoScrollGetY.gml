// Feather disable all

/// Returns the current scroll y-offset.
/// 
/// @param [element=self]

function BentoScrollGetY(_element = self)
{
    if (not BentoExists(_element)) return 0;
    
    return _element.BENTO_VARS.__scrollY;
}