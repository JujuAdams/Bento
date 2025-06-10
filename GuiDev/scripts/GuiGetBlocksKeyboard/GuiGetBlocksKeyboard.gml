// Feather disable all

/// Returns whether the top-most layer for the given environment wants to block keyboard input to
/// other parts of your game. This can happen in the following situations:
/// 
/// - The top-most layer is using the keyboard input mode
/// - Any UI element (in any environment) has been focused for text input using `GuiFocusTextOpen()`
/// 
/// @param [environment=current]

function GuiGetBlocksKeyboard(_environment = undefined)
{
    static _system = __GuiSystem();
    
    if (_system.__textHandler != undefined) return true;
    
    with(_environment ?? _system.__environmentCurrent)
    {
        with(__layerCurrent)
        {
            if (__navMode == GUI_MODE_KEYBOARD) return true;
        }
    }
    
    return false;
}