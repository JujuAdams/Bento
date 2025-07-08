// Feather disable all

/// Draws a layer using wireframe graphics.
/// 
/// @param [layerName=top]
/// @param [environmentName=current]

function BentoLayerDrawWireframe(_layerName = undefined, _environmentName = undefined)
{
    if (_layerName == undefined)
    {
        var _environment = __BentoEnvironmentEnsure(_environmentName);
        var _layer = (_environment == undefined)? undefined : _environment.__layerCurrent;
    }
    else
    {
        var _layer = __BentoLayerFind(_layerName, _environmentName);
    }
    
    with(_layer)
    {
        __DrawWireframe();
    }
}