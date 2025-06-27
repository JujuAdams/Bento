// Feather disable all

function BentoTextClose()
{
    static _system = __BentoSystem();
    
    with(_system.__textHandlerEnvironment)
    {
        if (__textHandler != undefined)
        {
            __textHandler.__Terminate(GUI_TEXT_INACTIVE);
        }
    }
    
    _system.__textHandlerEnvironment = undefined;
}