// Feather disable all

function BentoLayerGetHovered(_layerName = undefined, _environmentName = undefined)
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
        return __hoverElement;
    }
    
    return BENTO_NO_ELEMENT;
}