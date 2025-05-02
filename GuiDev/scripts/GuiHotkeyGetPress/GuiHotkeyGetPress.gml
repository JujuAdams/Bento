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
    with(GUI_ENVIRONMENT)
    {
        if (__hotkeyConsumedMap[? _name] ?? false) return false;
        return (__hotkeyStateMap[? _name] == GUI_PRESS);
    }
}