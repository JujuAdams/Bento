// Feather disable all

/// Returns whether the input mode has been set to `BENTO_MODE_MOUSE`.
/// 
/// @param [environmentName=current]

function BentoUsingMouse(_environmentOrName = undefined)
{
    with(__BentoEnvironmentSeek(_environmentOrName))
    {
        return (__envInputMode == BENTO_MODE_MOUSE);
    }
}