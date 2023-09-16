/// Executes the callback function one step up the box template inheritance chain.
/// 
/// This is effectively JavaScript's "super" but available only for BentoScript callback functions.

function BentoCallInherited()
{
    static _global = __BentoGlobal();
    return _global.__currentCallback.__CallInherited(_global.__currentCallbackScope,
                                                     _global.__currentCallbackParam0,
                                                     _global.__currentCallbackParam1);
}