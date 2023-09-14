function BentoInputSetPointerSpeed(_speed)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputSetPointerSpeed(_speed);
}