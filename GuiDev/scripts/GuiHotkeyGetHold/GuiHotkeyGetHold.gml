// Feather disable all

/// Returns whether the named button is being held based on input via `GuiInputHotkey()`.
/// 
/// @param name

function GuiHotkeyGetHold(_name)
{
    with(GUI_ENVIRONMENT)
    {
        if (__hotkeyConsumedMap[? _name] ?? false) return false;
        return (__hotkeyStateMap[? _name] == GUI_HOLD);
    }
}