// Feather disable all

/// Returns whether the navigation mode has been set to `BENTO_MODE_MOUSE` or `BENTO_MODE_TOUCH`.
/// 
/// @param [layer=current]

function BentoUsingPointer(_layer = undefined)
{
    static _system = __BentoSystem();
    
    _layer ??= _system.__layerCurrent;
    return _layer.__navPointer;
}