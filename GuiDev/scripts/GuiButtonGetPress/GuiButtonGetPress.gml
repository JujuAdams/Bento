// Feather disable all

/// Returns whether the named button has been pressed (newly held) based on input via
/// `GuiInputButton()`.
/// 
/// N.B. Button state is global. After processing button input, you should call `GuiNavConsume()`
///      to ensure button state doesn't leak to other instances.
/// 
/// @param name

function GuiButtonGetPress(_name)
{
    static _buttonStateMap    = __GuiSystem().__buttonStateMap;
    static _buttonConsumedMap = __GuiSystem().__buttonConsumedMap;
    
    if (_buttonConsumedMap[? _name] ?? false) return false;
    
    return (_buttonStateMap[? _name] == GUI_PRESS);
}