// Feather disable all

// TODO - Should check every environment for a text handler

/// Returns whether the top-most layer for the given environment wants to block keyboard input to
/// other parts of your game. This can happen in the following situations:
/// 
/// - Any environment is receiving text input using `GuiTextOpen()`
/// - The top-most layer is using the keyboard input mode
/// 
/// @param [environment=current]

function GuiGetBlocksKeyboard(_environment = undefined)
{
    static _system = __GuiSystem();
    
    if (_system.__textHandlerEnvironment != undefined) return true;
    
    with(_environment ?? _system.__environmentCurrent)
    {
        if (__layerCurrent.__navMode == GUI_MODE_KEYBOARD) return true;
    }
    
    return false;
}