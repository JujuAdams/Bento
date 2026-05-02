// Feather disable all

/// Sets a callback to execute when all blocking animations on a layer have finished playing. The
/// callback will be executed by Bento will two parameter in this order:
/// 
/// - The name of the layer that has been unblocked
/// - The metadata provided when calling `BentoLayerSetUnblockCallback()`
/// 
/// N.B. The callback will **not** be executed if no blocking animations are ever played (and
///      subsequently stopped). If you call this function to set up a callback and no blocking
///      animations are playing, you run the risk of the callback never being executed.
/// 
/// By default, this callback will be unset after it is used once. If you'd like the callback to
/// be called again then please set the `persist` optional argument to `true`. You may unset a
/// callback manually by calling this function and setting the `callback` parameter to `undefined`.
/// 
/// @param layerName
/// @param callback
/// @param [metadata]
/// @param [environmentName=current]

function BentoLayerSetUnblockCallback(_layerName, _callback, _metadata = undefined, _persist = false, _environmentName = undefined)
{
    with(__BentoLayerFind(_layerName, __BentoEnvironmentEnsure(_environmentName)))
    {
        __animUnblockedCallback = _callback;
        __animUnblockedMetadata = _metadata;
        __animUnblockedPersist  = _persist;
    }
}