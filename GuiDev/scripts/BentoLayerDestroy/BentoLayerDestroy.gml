// Feather disable all

/// @param [layerOrName=current]

function BentoLayerDestroy(_layerOrName = undefined)
{
    static _system = __BentoSystem();
    
    if (_layerOrName == undefined)
    {
        var _layer = _system.__layerCurrent;
    }
    else if (is_struct(_layerOrName))
    {
        var _layer = _layerOrName;
    }
    
    if (not is_struct(_layer)) return;
    
    _layer.__Destroy();
}