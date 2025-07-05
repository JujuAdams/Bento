// Feather disable all

/// Returns a number between `0` and `1` that represents how much of an animation has elapsed. A
/// value of `1` indicates that the animation has completely finished. A value of `0` indicates
/// that an animation is yet to begin or that the aniation is still in the delay phase.
/// 
/// If the specified element doesn't exist, this function will return `1`. If the element isn't
/// animating, this function will return `1`.
/// 
/// @param [element=self]

function BentoAnimGetParam(_element = self)
{
    if (not BentoExists(_element)) return 1;
    
    with(_element.BENTO_VARS)
    {
        if (not __animPlaying) return 1;
        
        return clamp((__animElapsed - __animDelay) / __animDuration, 0, 1);
    }
}