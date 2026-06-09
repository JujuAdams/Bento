// Feather disable all

/// Returns the top layer for an environment. If no parameters are set, this function will target
/// the currently processing environment.
/// 
/// @param [environmentOrName=current]

function BentoEnvironmentGetTopLayer(_environmentOrName = undefined)
{
    static _system = __BentoSystem();
    
    var _environment = __BentoEnvironmentEnsure(_environmentOrName)
    if (_environment == undefined) return;
    
    return array_last(_environment.__layerArray);
}