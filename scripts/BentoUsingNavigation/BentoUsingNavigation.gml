// Feather disable all

/// Returns whether the input mode has been set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD`.
/// 
/// @param [environmentName=current]

function BentoUsingNavigation(_environmentOrName = undefined)
{
    with(__BentoEnvironmentSeek(_environmentOrName))
    {
        return ((__envInputMode == BENTO_MODE_KEYBOARD) || (__envInputMode == BENTO_MODE_GAMEPAD));
    }
}