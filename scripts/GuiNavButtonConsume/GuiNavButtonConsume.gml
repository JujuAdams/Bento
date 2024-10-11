// Feather disable all

/// @param button

function GuiNavButtonConsume(_name)
{
    static _buttonMap = __GuiSystem().__buttonMap;
    
    _buttonMap[? _name] = false;
}