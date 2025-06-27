// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_MODE_MOUSE` or `GUI_MODE_TOUCH`.
/// 
/// @param [layer=current]

function BentoUsingPointer(_layer = undefined)
{
    static _system = __BentoSystem();
    
    _layer ??= _system.__layerCurrent;
    return _layer.__navPointer;
}