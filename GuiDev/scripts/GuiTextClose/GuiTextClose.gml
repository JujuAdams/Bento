// Feather disable all

function GuiTextClose()
{
    static _system = __GuiSystem();
    
    with(_system.__textHandlerEnvironment)
    {
        if (__textHandler != undefined)
        {
            __textHandler.__Terminate(GUI_TEXT_INACTIVE);
        }
    }
    
    _system.__textHandlerEnvironment = undefined;
}