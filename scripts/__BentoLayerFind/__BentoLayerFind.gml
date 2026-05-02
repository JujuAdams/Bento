// Feather disable all

/// @param name
/// @param [environmentName=current]

function __BentoLayerFind(_name, _environmentName = undefined)
{
    with(__BentoEnvironmentEnsure(_environmentName))
    {
        var _array = __layerArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            if (_array[_i].__name == _name)
            {
                return _array[_i];
            }
            
            ++_i;
        }
    }
    
    return undefined;
}