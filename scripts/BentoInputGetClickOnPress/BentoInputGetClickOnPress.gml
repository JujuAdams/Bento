/// Returns the current click-on-press mode.

function BentoInputGetClickOnPress()
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputGetClickOnPress();
}