// Feather disable all

function BentoInputGetMode()
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputGetMode();
}