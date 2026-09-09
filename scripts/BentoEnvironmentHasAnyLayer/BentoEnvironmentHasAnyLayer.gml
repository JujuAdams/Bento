// Feather disable all

/// Returns whether the target environment has any existing layers. If no parameters are set, this
/// function will target the currently processing environment.
/// 
/// @param [environmentOrName=current]

function BentoEnvironmentHasAnyLayer(_environmentOrName = undefined)
{
    static _system = __BentoSystem();
    
    var _environment = __BentoEnvironmentEnsure(_environmentOrName)
    if (_environment == undefined) return;
    
    return (array_length(_environment.__layerArray) > 0);
}