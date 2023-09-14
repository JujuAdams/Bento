function __BentoContextStackPop()
{
    static _contextStack = __BentoGlobal().__contextStack;
    if (array_length(_contextStack) > 1) array_delete(_contextStack, 0, 1);
}