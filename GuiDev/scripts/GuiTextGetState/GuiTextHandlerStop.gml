// Feather disable all

function GuiTextHandlerStop()
{
    static _system = __GuiTextSystem();
    with(_system)
    {
        if (__handler != undefined)
        {
            __handler.__Stop();
        }
    }
}