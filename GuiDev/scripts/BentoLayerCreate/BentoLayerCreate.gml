// Feather disable all

/// @param name
/// @param [environment=current]

function BentoLayerCreate(_name, _environment = undefined)
{
    static _system = __BentoSystem();
    
    _environment ??= _system.__environmentCurrent;
    with(_environment)
    {
        if (BentoLayerExists(_name, self))
        {
            __BentoError($"Layer called \"{_name}\" already exist (environment \"{__name}\")");
        }
        
        var _layer = new __BentoClassLayer(self, _name);
        array_push(__layerArray, _layer);
        
        return _layer;
    }
    
    return undefined;
}