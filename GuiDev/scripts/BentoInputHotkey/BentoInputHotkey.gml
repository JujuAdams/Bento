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
    with(_system.__environmentCurrent)
    {
        if (not ds_map_exists(__envHotkeyInputMap, _name))
        {
            array_push(__envHotkeyArray, _name);
        }
        
        __envHotkeyInputMap[? _name] = _value;
    }
}