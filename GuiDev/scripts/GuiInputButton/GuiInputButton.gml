// Feather disable all

/// Sets input values for a named button input. The name should be chosen to reflect the purpose
/// of the input e.g. `"back"` or `"pause"` or `"scroll up"`. Button values can be read later uing
/// the `GuiButtonGet*()` functions. The `value` parameter should be set to the current hold state
/// of the button e.g. `keyboard_check(vk_escape)`.
/// 
/// @param name
/// @param value

function GuiInputButton(_name, _value)
{
    static _buttonInputMap = __GuiSystem().__buttonInputMap;
    static _buttonArray    = __GuiSystem().__buttonArray;
    
    if (not ds_map_exists(_buttonInputMap, _name))
    {
        array_push(_buttonArray, _name);
    }
    
    _buttonInputMap[? _name] = _value;
}