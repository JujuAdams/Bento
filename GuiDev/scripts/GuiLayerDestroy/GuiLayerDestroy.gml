// Feather disable all

/// @param [layerOrName=current]

function GuiLayerDestroy(_layerOrName = undefined)
{
    static _system = __GuiSystem();
    
    if (is_undefined(_layerOrName))
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