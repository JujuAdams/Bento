// Feather disable all

/// Destroys all layers for an environment. If no parameters are set, this function will target
/// the currently processing environment.
/// 
/// @param [environmentOrName=current]

function BentoEnvironmentGetTopLayer(_environmentOrName = undefined)
{
    with(__BentoEnvironmentEnsure(_environmentOrName))
    {
        var _i = array_length(__layerArray)-1;
        repeat(_i+1)
        {
            __layerArray[_i].__Destroy();
            --_i;
        }
    }
}