// Feather disable all

/// Returns whether the named button has been pressed (newly held) based on input via
/// `GuiInputHotkey()`.
/// 
/// N.B. Button state is global. After processing button input, you should call `GuiNavConsume()`
///      to ensure button state doesn't leak to other instances.
/// 
/// @param name
/// @param [environment=current]

function GuiHotkeyGetPress(_name, _environment = undefined)
{
    static _system = __GuiSystem();
    
    with(_environment ?? _system.__environmentCurrent)
    {
        if (__hotkeyConsumedMap[? _name] ?? false) return false;
        return (__hotkeyStateMap[? _name] == GUI_PRESS);
    }
}