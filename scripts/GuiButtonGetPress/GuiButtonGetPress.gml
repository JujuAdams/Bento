// Feather disable all

/// @param name

function GuiButtonGetPress(_name)
{
    static _buttonStateMap    = __GuiSystem().__buttonStateMap;
    static _buttonConsumedMap = __GuiSystem().__buttonConsumedMap;
    
    if (_buttonConsumedMap[? _name] ?? false) return false;
    
    return (_buttonStateMap[? _name] == GUI_PRESS);
}