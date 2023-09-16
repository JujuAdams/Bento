/// Returns the current input mode.

function BentoInputGetMode()
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputGetMode();
}