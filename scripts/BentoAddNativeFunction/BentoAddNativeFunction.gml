/// Adds a native GML function (is_string, show_debug_message etc.) to BentoScript, allowing it
/// to be executed from external UI files.
/// 
/// @param GMLscript
/// @param [functionName]

function BentoAddNativeFunction(_script, _name = script_get_name(_script))
{
    __BentoGlobal().__bentoScriptEnv.interface.exposeFunction(_name, _script);
}