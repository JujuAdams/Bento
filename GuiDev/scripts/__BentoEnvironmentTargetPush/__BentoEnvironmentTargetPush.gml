// Feather disable all

function __BentoEnvironmentTargetPush(_environment)
{
    static _system = __BentoSystem();
    static _environmentStack = _system.__environmentStack;
    
    array_push(_environmentStack, _system.__environmentCurrent);
    _system.__environmentCurrent = _environment;
}