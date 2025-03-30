// Feather disable all

function __GuiGetDatafilesPath()
{
    static _result = (function()
    {
        return GUI_RUNNING_FROM_IDE? __GuiSanitizeFilename(filename_dir(GM_project_filename) + "/datafiles/") : "";
    })();
    
    return _result;
}