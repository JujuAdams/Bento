// Feather disable all

/// @param environmentOrName
/// @param [fallback=current]

function __BentoEnvironmentEnsure(_environmentOrName, _fallback = undefined)
{
    static _system = __BentoSystem();
    
    if (is_struct(_environmentOrName))
    {
        return _environmentOrName;
    }
    
    if (is_string(_environmentOrName))
    {
        var _environment = __BentoEnvironmentFind(_environmentOrName);
        if (_environment != undefined) return _environment;
    }
    
    return _fallback ?? _system.__environmentCurrent;
}