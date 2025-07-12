// Feather disable all

/// Starts playing an animation using a custom method (function). You can use this function to
/// perform an animation operations that you'd like. If you'd like this to be a blocking
/// animation then please set the optional `blocking` parameter to `true`. By default, however,
/// animations played using this function are non-blocking.
/// 
/// N.B. Only one animation per element can play at a time. This function will immediately stop
///      any animation playing on the element.
/// 
/// The `duration` and `delay` parameters are measured in frames. The `delay` parameter may be used
/// to defer execution of an animation which is helpful when triggering multiple animations at the
/// same time that you wish to be staggered.
/// 
/// The method that you provide to this function will be called whenever Bento needs to update the
/// animation state. This is:
/// 
/// 1. Immediately when  `BentoAnimPlayMethod()` is called
/// 2. Every frame that the animation time is incremented, including during the delay phase
/// 3. When the animation naturally elapses
/// 4. When `BentoAnimStop()` is called
/// 
/// The method will be called with three arguments which are, in order:
/// 
/// - The element being animated
/// - The time parameter (from `0` to `1`)
/// - The metadata that you provided when starting the animation with `BentoAnimPlayMethod()`
/// 
/// The scope of the method is not otherwise modified and will persist.
/// 
/// @param duration
/// @param delay
/// @param method
/// @param [metadata]
/// @param [blocking=false]
/// @param [element=self]

function BentoAnimPlayCustom(_duration, _delay, _method, _metadata = undefined, _blocking = false, _element = self)
{
    with(__BentoGetVars(_element))
    {
        BentoAnimStop(true, __attachedElement);
        
        __animPlaying  = true;
        __animBlocking = _blocking;
        __animDuration = max(1, _duration);
        __animDelay    = max(0, _delay);
        __animMethod   = _method;
        __animMetadata = _metadata
        __animElapsed  = 0;
        
        with(__layer)
        {
            if (not ds_map_exists(__animPlayingMap, other))
            {
                array_push(__animPlayingArray, other);
            }
            
            __animPlayingMap[? other] = true;
            
            if (_blocking)
            {
                __animAnyBlocking = true;
                __animBlockingMap[? other] = true;
            }
        }
        
        __animMethod(__attachedElement, 0, __animMetadata);
    }
}