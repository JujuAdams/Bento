// Feather disable all

/// Returns whether the named button is being held based on input via `GuiInputHotkey()`.
/// 
/// @param name
/// @param [environment=current]

function GuiHotkeyGetHold(_name, _environment = undefined)
{
    static _system = __GuiSystem();
    
    with(_environment ?? _system.__environmentCurrent)
    {
        if (__hotkeyConsumedMap[? _name] ?? false) return false;
        return (__hotkeyStateMap[? _name] == GUI_HOLD);
    }
}