function __BentoContextStackPush(_struct)
{
    static _contextStack = __BentoGlobal().__contextStack;
    array_insert(_contextStack, 0, _struct);
}