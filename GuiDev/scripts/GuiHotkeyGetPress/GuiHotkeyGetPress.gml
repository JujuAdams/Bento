// Feather disable all

/// Returns whether the named button has been pressed (newly held) based on input via
/// `GuiInputHotkey()`.
/// 
/// N.B. Button state is global. After processing button input, you should call `GuiNavConsume()`
///      to ensure button state doesn't leak to other instances.
/// 
/// @param name

function GuiHotkeyGetPress(_name)
{
    static _hotkeyStateMap    = __GuiSystem().__hotkeyStateMap;
    static _hotkeyConsumedMap = __GuiSystem().__hotkeyConsumedMap;
    
    if (_hotkeyConsumedMap[? _name] ?? false) return false;
    
    return (_hotkeyStateMap[? _name] == GUI_PRESS);
}