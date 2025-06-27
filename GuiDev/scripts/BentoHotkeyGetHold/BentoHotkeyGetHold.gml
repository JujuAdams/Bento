// Feather disable all

/// Returns whether the named button is being held based on input via `BentoInputHotkey()`.
/// 
/// @param name
/// @param [layer=current]

function BentoHotkeyGetHold(_name, _layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__hotkeyConsumedMap[? _name] ?? false) return false;
        return (__hotkeyStateMap[? _name] == __GUI_ON);
    }
}