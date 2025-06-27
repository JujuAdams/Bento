// Feather disable all

/// Returns the current navigation mode, as set by `BentoSetMode()`. This will be one of the
/// following constants:
/// 
/// - `BENTO_MODE_UNKNOWN`
/// - `BENTO_MODE_MOUSE`
/// - `BENTO_MODE_KEYBOARD`
/// - `BENTO_MODE_GAMEPAD`
/// - `BENTO_MODE_TOUCH`
/// 
/// @param [layer=current]

function BentoGetMode(_layer = undefined)
{
    static _system = __BentoSystem();
    
    _layer ??= _system.__layerCurrent;
    return _layer.__navMode;
}