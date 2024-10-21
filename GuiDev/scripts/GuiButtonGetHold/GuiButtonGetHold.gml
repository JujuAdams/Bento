// Feather disable all

/// Returns whether the named button is being held based on input via `GuiInputButton()`.
/// 
/// @param name

function GuiButtonGetHold(_name)
{
    static _buttonStateMap    = __GuiSystem().__buttonStateMap;
    static _buttonConsumedMap = __GuiSystem().__buttonConsumedMap;
    
    if (_buttonConsumedMap[? _name] ?? false) return false;
    
    return (_buttonStateMap[? _name] == GUI_HOLD);
}