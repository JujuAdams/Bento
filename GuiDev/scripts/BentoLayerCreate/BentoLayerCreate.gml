// Feather disable all

/// Creates a layer in the specified environment. You must provide a unique name for the layer
/// that no other layer in the same environment shares (other layers in other environments may use
/// the same name however). The most recently created layer in an environment will receive input
/// and other, older, layers will not receive input. However, all layers will still be processed by
/// `BentoSystemStep()` and drawn by `BentoSystemDraw()` with the oldest layers being drawn first
/// underneath newer layers.
/// 
/// The most common use case for layers is to create modals to confirm destructive actions, such as
/// quitting the game or confirming savedata to load.
/// 
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