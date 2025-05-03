// Feather disable all

/// @param name
/// @param [environment=current]

function GuiEnvironmentExistsByName(_name, _environment = undefined)
{
    static _system = __GuiSystem();
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