// Feather disable all

function GuiTextStop()
{
    static _system = __GuiTextSystem();
    with(_system)
    {
        if (__handler != undefined)
        {
            __handler.__Terminate(GUI_TEXT_INACTIVE);
        }
    }
}