// Feather disable all

/// Stops all blocking animations on a layer. This function calls `BentoAnimStop()` for all
/// animating elements that are set as blocking. Please see documentation for `BentoAnimStop()`
/// for an explanation of the optional `finalize` parameter. If you have an unblocked callback set
/// up via `BentoLayerSetUnblockCallback()` then that callback will be executed immediately.
/// 
/// @param layerName
/// @param [finalize=true]
/// @param [environmentName=current]

function BentoLayerStopBlockingAnimation(_layerName, _finalize = true, _environmentName = undefined)
{
    with(__BentoLayerFind(_layerName, __BentoEnvironmentEnsure(_environmentName)))
    {
        var _i = array_length(__animPlayingArray)-1;
        repeat(array_length(__animPlayingArray))
        {
            with(__animPlayingArray[_i])
            {
                if (__animBlocking)
                {
                    BentoAnimStop(_finalize, __attachedElement);
                }
            }
            
            --_i;
        }
        
        __CheckUnblocked();
    }
}