// Feather disable all

/// @param mode

function BentoInputSetMode(_mode)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputSetMode(_mode);
}