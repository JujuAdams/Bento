/// Sets the click-on-press mode.
/// 
/// @param state

function BentoInputSetClickOnPress(_state)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputSetClickOnPress(_state);
}