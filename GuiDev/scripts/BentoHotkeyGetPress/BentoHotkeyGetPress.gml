// Feather disable all

/// Returns whether the named button has been pressed (newly held) based on input via
/// `BentoInputHotkey()`.
/// 
/// N.B. Button state is global. After processing button input, you should call `BentoInputConsume()`
///      to ensure button state doesn't leak to other instances.
/// 
/// @param name
/// @param [layerOrName=current]

function BentoHotkeyGetPress(_name, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__hotkeyConsumedMap[? _name] ?? false) return false;
        return (__hotkeyStateMap[? _name] == __BENTO_START);
    }
    
    return false;
}