// Feather disable all

/// Returns whether the named button is being held based on input via `GuiInputHotkey()`.
/// 
/// @param name
/// @param [layer=current]

function GuiHotkeyGetHold(_name, _layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__hotkeyConsumedMap[? _name] ?? false) return false;
        return (__hotkeyStateMap[? _name] == GUI_HOLD);
    }
}