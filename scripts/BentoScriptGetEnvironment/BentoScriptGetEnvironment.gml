/// Returns the Catpseak environment being used by the library.

function BentoScriptGetEnvironment()
{
    static _environment = __BentoGlobal().__bentoScriptEnv;
    return _environment;
}