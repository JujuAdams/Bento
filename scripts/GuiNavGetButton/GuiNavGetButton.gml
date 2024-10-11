// Feather disable all

/// @param name

function GuiNavGetButton(_name)
{
    static _buttonMap = __GuiSystem().__buttonMap;
    
    return ((_buttonMap[? _name]) ?? false);
}