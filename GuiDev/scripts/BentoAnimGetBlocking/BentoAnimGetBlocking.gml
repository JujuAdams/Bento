// Feather disable all

/// Returns whether an animating element is set up to block user input. If the specified element
/// doesn't exist or isn't animating, this function will return `false`.
/// 
/// @param [element=self]

function BentoAnimGetBlocking(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    with(_element.BENTO_VARS)
    {
        return __animPlaying && __animBlocking;
    }
}