// Feather disable all

/// Returns whether the named button is being held based on input via `GuiInputHotkey()`.
/// 
/// @param name

function GuiHotkeyGetHold(_name)
{
    static _hotkeyStateMap    = __GuiSystem().__hotkeyStateMap;
    static _hotkeyConsumedMap = __GuiSystem().__hotkeyConsumedMap;
    
    if (_hotkeyConsumedMap[? _name] ?? false) return false;
    
    return (_hotkeyStateMap[? _name] == GUI_HOLD);
}