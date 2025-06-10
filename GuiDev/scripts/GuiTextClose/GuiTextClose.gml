// Feather disable all

/// @param [environment=current]

function GuiTextClose(_environment = undefined)
{
    static _system = __GuiSystem();
    with(_environment ?? _system.__environmentCurrent)
    {
        if (__textHandler != undefined)
        {
            __textHandler.__Terminate(GUI_TEXT_INACTIVE);
        }
    }
}