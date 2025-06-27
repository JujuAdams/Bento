// Feather disable all

/// Returns whether the navigation mode has been set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD`.
/// 
/// @param [layer=current]

function BentoUsingDirectional(_layer = undefined)
{
    static _system = __BentoSystem();
    
    _layer ??= _system.__layerCurrent;
    return _layer.__navDirectional;
}