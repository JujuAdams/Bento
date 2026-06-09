// Feather disable all

/// Returns whether the top-most layer for the given environment wants to block keyboard input to
/// other parts of your game. This can happen in the following situations:
/// 
/// - Any environment is receiving text input using `BentoTextOpen()`
/// - The top-most layer is using the keyboard input mode
/// 
/// @param [environmentName=current]

function BentoGetBlocksKeyboard(_environmentName = undefined)
{
    static _system = __BentoSystem();
    
    if (_system.__textHandlerEnvironment != undefined) return true;
    
    with(__BentoEnvironmentEnsure(_environmentName))
    {
        if (__layerCurrent.__inputMode == BENTO_MODE_KEYBOARD) return true;
    }
    
    return false;
}