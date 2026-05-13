// Feather disable all

/// @param [environmentOrName=current]

function BentoGetAspectRatio(_environmentOrName = undefined)
{
    static _system = __BentoSystem();
    
    var _environment = __BentoEnvironmentEnsure(_environmentOrName)
    if (_environment == undefined)
    {
        //Guess!
        return (max(1, window_get_width()) / max(1, window_get_height()));
    }
    
    return (_environment.__approxWidth / _environment.__approxHeight);
}