// Feather disable all

/// Returns whether the top-most layer for the given environment wants to block keyboard input to
/// other parts of your game. This can happen in the following situations:
/// 
/// - The top-most layer is using the keyboard input mode
/// - The environment is receiving text input using `GuiTextOpen()`
/// 
/// @param [environment=current]

function GuiGetBlocksKeyboard(_environment = undefined)
{
    static _system = __GuiSystem();
    
    with(_environment ?? _system.__environmentCurrent)
    {
        if (__textHandler != undefined) return false;
        
        with(__layerCurrent)
        {
            if (__navMode == GUI_MODE_KEYBOARD) return true;
        }
    }
    
    return false;
}