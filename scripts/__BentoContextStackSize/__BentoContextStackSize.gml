function __BentoContextStackSize()
{
    static _contextStack = __BentoGlobal().__contextStack;
    return array_length(_contextStack);
}