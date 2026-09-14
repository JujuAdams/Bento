// Feather disable all

/// Returns the input mode for an environment, as set by `BentoSetMode()`. This will be one of the
/// following constants:
/// 
/// - `BENTO_MODE_UNKNOWN`
/// - `BENTO_MODE_MOUSE`
/// - `BENTO_MODE_KEYBOARD`
/// - `BENTO_MODE_GAMEPAD`
/// - `BENTO_MODE_TOUCH`
/// 
/// @param [environmentName=current]

function BentoGetMode(_environmentOrName = undefined)
{
    with(__BentoEnvironmentSeek(_environmentOrName))
    {
        return __envInputMode;
    }
}