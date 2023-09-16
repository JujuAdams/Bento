/// Returns the BentoScript environment being used by the library.
/// 
/// Having a reference to the underlying Bento environment allows you to further customise the
/// code environment that BentoScript uses.

function BentoScriptGetEnvironment()
{
    static _environment = __BentoGlobal().__bentoScriptEnv;
    return _environment;
}