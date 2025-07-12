// Feather disable all

/// Sets the input value for a named hotkey input. The name should be chosen to reflect the purpose
/// of the input e.g. `"back"` or `"pause"` or `"scroll up"`. Hotkey values can be read later using
/// the `BentoHotkeyGet*()` functions. The `value` parameter should be set to the current hold state
/// of the button e.g. `keyboard_check(vk_escape)`.
/// 
/// @param name
/// @param value

function BentoInputHotkey(_name, _value)
{
    static _system = __BentoSystem();
    _system.__environmentCurrent.__envHotkeyInputMap[? _name] = _value;
}