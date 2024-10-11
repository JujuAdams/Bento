// Feather disable all

function GuiNavUsingMouse()
{
    static _system = __GuiSystem();
    
    return (_system.__navMode == GUI_NAV_MOUSE);
}