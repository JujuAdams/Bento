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
        var _environmentOrName = __BentoEnvironmentFind(_environmentOrName);
        if (_environmentOrName != undefined) return _environmentOrName;
    }
    
    return _fallback ?? _system.__environmentCurrent;
}