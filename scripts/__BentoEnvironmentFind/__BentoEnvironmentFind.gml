// Feather disable all

/// @param name

function __BentoEnvironmentFind(_name)
{
    static _system = __BentoSystem();
    with(_system)
    {
        var _array = __environmentArray;
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