/// Adds a constant to BentScript, allowing it to be used in external UI files.
/// 
/// @param constantName
/// @param value

function BentoAddConstant(_name, _value)
{
    __BentoGlobal().__bentoScriptEnv.interface.exposeConstant(_name, _value);
}