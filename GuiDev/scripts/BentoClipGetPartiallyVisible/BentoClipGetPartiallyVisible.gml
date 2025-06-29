// Feather disable all

/// Returns whether an element is partially visible through any clipping regions.
/// 
/// @param [element=self]

function BentoClipGetPartiallyVisible(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    return (_element.BENTO_VARS.__scissorVisibility != BENTO_VISIBLE_NONE);
}