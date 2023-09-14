/// Adds a custom function to BentScript, allowing it to be executed from external UI files.
/// 
/// @param functionName
/// @param function

function BentoAddFunction(_name, _function)
{
    __BentoGlobal().__bentoScriptEnv.interface.exposeFunction(_name, _function);
}