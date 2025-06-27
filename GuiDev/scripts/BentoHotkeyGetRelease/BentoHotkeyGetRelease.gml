// Feather disable all

/// Returns whether the named button has been released (newly un-held) based on input via
/// `BentoInputHotkey()`.
/// 
/// N.B. Button state is global. After processing button input, you should call `BentoInputConsume()`
///      to ensure button state doesn't leak to other instances.
/// 
/// @param name
/// @param [layer=current]

function BentoHotkeyGetRelease(_name, _layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__hotkeyConsumedMap[? _name] ?? false) return false;
        return (__hotkeyStateMap[? _name] == __GUI_END);
    }
}