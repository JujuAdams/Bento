// Feather disable all

function __BentoGetDatafilesPath()
{
    static _result = (function()
    {
        return BENTO_RUNNING_FROM_IDE? __BentoSanitizeFilename(filename_dir(GM_project_filename) + "/datafiles/") : "";
    })();
    
    return _result;
}