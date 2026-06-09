// Feather disable all

/// Sets whether a layer should be drawn when backgrounded. If a layer on top then it is always
/// drawn.
/// 
/// @param state
/// @param [layerOrName=current]

function BentoLayerSetDrawWhenBackgrounded(_state, _layerOrName = undefined, _environmentOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName, _environmentOrName, noone))
    {
        __drawWhenBackgrounded = _state;
    }
}