function BentoCallInherited()
{
    static _global = __BentoGlobal();
    return _global.__currentCallback.__CallInherited(_global.__currentCallbackScope,
                                                     _global.__currentCallbackParam0,
                                                     _global.__currentCallbackParam1);
}