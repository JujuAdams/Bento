// Feather disable all

/// @param name
/// @param [environment=current]

function GuiLayerCreate(_name, _environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    with(_environment)
    {
        if (GuiLayerExists(_name, self))
        {
            __GuiError($"Layer called \"{_name}\" already exist (environment \"{__name}\")");
        }
        
        var _layer = new __GuiClassLayer(self, _name);
        array_push(__layerArray, _layer);
        
        return _layer;
    }
    
    return undefined;
}