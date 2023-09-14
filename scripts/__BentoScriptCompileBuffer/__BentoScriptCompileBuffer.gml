function __BentoScriptCompileBuffer(_buffer, _offset = undefined, _size = undefined)
{
    return __BentoScript.compileGML(__BentoScript.parse(_buffer, _offset, _size));
}