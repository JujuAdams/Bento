// Feather disable all

/// @param [environmentOrName=current]

function BentoGetPortrait(_environmentOrName = undefined)
{
    static _system = __BentoSystem();
    
    var _environment = __BentoEnvironmentEnsure(_environmentOrName)
    if (_environment == undefined)
    {
        //Guess!
        return (window_get_width() < window_get_height());
    }
    
    return ((_environment.__approxWidth / _environment.__approxHeight) < 1);
}