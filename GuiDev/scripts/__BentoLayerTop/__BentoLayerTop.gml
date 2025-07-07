// Feather disable all

/// @param [environmentName=current]

function __BentoLayerTop(_environmentName = undefined)
{
    with(__BentoEnvironmentEnsure(_environmentName))
    {
        return array_last(__layerArray);
    }
    
    return undefined;
}