/// Updates Bento logic, including user input.

function BentoStep()
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__Step();
}