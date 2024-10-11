// Feather disable all

/// @param name
/// @param value

function GuiNavButton(_name, _value)
{
    static _buttonMap = __GuiSystem().__buttonMap;
    
    _buttonMap[? _name] = _value;
}