// Feather disable all

/// @param layerName
/// @param [environmentName=current]

function BentoLayerCreate(_layerName, _environmentName = undefined)
{
    static _system = __BentoSystem();
    
    with(__BentoEnvironmentEnsure(_environmentName))
    {
        if (BentoLayerExists(_layerName, self))
        {
            __BentoError($"Layer called \"{_layerName}\" already exists (environment \"{__name}\")");
        }
        
        var _layer = new __BentoClassLayer(self, _layerName);
        array_push(__layerArray, _layer);
        
        return _layer;
    }
    
    return undefined;
}