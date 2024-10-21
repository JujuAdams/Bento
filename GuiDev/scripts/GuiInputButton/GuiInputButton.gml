// Feather disable all

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