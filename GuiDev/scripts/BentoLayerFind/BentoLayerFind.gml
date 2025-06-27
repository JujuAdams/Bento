// Feather disable all

/// @param name
/// @param [environment=current]

function BentoLayerFind(_name, _environment = undefined)
{
    static _system = __BentoSystem();
    with(_environment ?? _system.__environmentCurrent)
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