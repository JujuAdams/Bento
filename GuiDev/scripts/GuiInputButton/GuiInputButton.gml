// Feather disable all

/// Sets input values for a named button input. The name should be chosen to reflect the purpose
/// of the input e.g. `"back"` or `"pause"` or `"scroll up"`. Button values can be read later uing
/// the `GuiButtonGet*()` functions. The `value` parameter should be set to the current hold state
/// of the button e.g. `keyboard_check(vk_escape)`.
/// 
/// @param name
/// @param value

function GuiInputHotkey(_name, _value)
{
    static _system = __GuiSystem();
    with(_system)
    {
        if (not ds_map_exists(__globalHotkeyInputMap, _name))
        {
            array_push(__globalHotkeyArray, _name);
        }
        
        __globalHotkeyInputMap[? _name] = _value;
    }
}