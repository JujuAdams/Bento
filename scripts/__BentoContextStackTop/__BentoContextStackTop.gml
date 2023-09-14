function __BentoContextStackTop()
{
    static _contextStack = __BentoGlobal().__contextStack;
    return _contextStack[0];
}