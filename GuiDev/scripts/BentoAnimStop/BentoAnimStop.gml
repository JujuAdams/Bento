// Feather disable all

/// Immediately stops an animation. By default, this function will "finalize" the animation. This
/// means that the element will immediately apply any final values from the animation. If you've
/// started an animation with `BentoAnimPlayBuildOut()` then finalizing will also destroy the
/// element. If you're using `BentoAnimPlayMethod()` then finalizing the animation will result in
/// the callback method being called immediately with a parameter of `1`. If you set the `finalize`
/// parameter to `false` then the animation will stop with no further values being set nor will it
/// destroy the element if a build-out animtion is playing.
/// 
/// @param [finalize=true]
/// @param [element=self]

function BentoAnimStop(_finalize = true, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__animPlaying)
        {
            if (_finalize)
            {
                __animMethod(1, __animMetadata);
            }
           
            __animPlaying  = false;
            __animElapsed  = 0;
            __animDuration = 0;
            __animDelay    = 0;
            __animMethod   = undefined;
            __animMetadata = undefined;
        }
        
        with(__layer)
        {
            ds_map_delete(__animatingMap, self);
            
            var _index = array_get_index(__animatingArray, self);
            if (_index >= 0) array_delete(__animatingArray, _index, 1);
        }
    }
}