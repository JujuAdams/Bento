// Feather disable all

/// Returns whether an animation is playing for an element. If the element doesn't exist,
/// this function will return `false`.
/// 
/// @param [element=self]

function BentoAnimGetPlaying(_element = self)
{
    return BentoExists(_element)? _element.BENTO_VARS.__animPlaying : false;
}