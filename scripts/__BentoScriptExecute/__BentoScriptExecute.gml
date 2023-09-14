function __BentoScriptExecute(_string)
{
    return __BentoScriptCompileString(_string)();
}