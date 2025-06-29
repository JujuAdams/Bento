// Feather disable all

/// Returns whether the clipping region is enabled for an element.
/// 
/// @param [element=self]

function BentoClipGetEnabled(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__scissorEnabled : false;
}