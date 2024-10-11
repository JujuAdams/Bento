// Feather disable all

function GuiNavUsingTouch()
{
    static _system = __GuiSystem();
    
    return (_system.__navMode == GUI_NAV_TOUCH);
}