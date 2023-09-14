function BentoInputPointer(_x, _y)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputPointer(_x, _y);
}