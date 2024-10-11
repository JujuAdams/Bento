// Feather disable all

function GuiNavGetMode()
{
    static _system = __GuiSystem();
    
    return _system.__navMode;
}