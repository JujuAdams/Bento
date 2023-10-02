/// Executes the event function one step up the box template inheritance chain.
/// 
/// This is effectively JavaScript's "super" but available only for BentoScript event functions.

function BentoCallInherited()
{
    static _global = __BentoGlobal();
    return _global.__currentEvent.__CallInherited(_global.__currentEventScope,
                                                     _global.__currentEventParam0,
                                                     _global.__currentEventParam1);
}