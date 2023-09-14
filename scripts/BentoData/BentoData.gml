/// Returns the global data struct. This is exposed for use in external UI source files.

function BentoData()
{
    static _data = __BentoGlobal().__dataStruct;
    return _data;
}