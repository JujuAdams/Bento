// Feather disable all

function GuiNavUsingGamepad()
{
    static _system = __GuiSystem();
    
    return (_system.__navMode == GUI_NAV_GAMEPAD);
}