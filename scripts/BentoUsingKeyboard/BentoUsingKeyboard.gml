// Feather disable all

/// Returns whether the input mode has been set to `BENTO_MODE_KEYBOARD`.
/// 
/// @param [environmentName=current]

function BentoUsingKeyboard(_environmentOrName = undefined)
{
    with(__BentoEnvironmentSeek(_environmentOrName))
    {
        return (__envInputMode == BENTO_MODE_KEYBOARD);
    }
}