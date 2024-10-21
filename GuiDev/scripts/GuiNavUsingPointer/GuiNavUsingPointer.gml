// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH`.

function GuiNavUsingPointer()
{
    static _system = __GuiSystem();
    
    return _system.__navPointer;
}