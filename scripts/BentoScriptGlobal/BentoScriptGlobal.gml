/// Returns the global data struct. This is exposed for use in external UI source files.

function BentoScriptGlobal()
{
    static _data = __BentoGlobal().__exposedGlobalStruct;
    return _data;
}