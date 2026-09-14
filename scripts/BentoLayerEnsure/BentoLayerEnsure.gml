// Feather disable all

/// @param layerName
/// @param [environmentName=current]

function BentoLayerEnsure(_layerName, _environmentName = undefined)
{
    with(__BentoEnvironmentSeek(_environmentName))
    {
        var _layerArray = __layerArray;
        var _i = 0;
        repeat(array_length(_layerArray))
        {
            if (_layerArray[_i].__name == _layerName)
            {
                return _layerArray[_i];
            }
            
            ++_i;
        }
    }
    
    return BentoLayerCreate(_layerName, _environmentName);
}