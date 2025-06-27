// Feather disable all

/// @param environment

function BentoEnvironmentTargetPush(_environment)
{
    static _system = __BentoSystem();
    static _environmentStack = _system.__environmentStack;
    
    array_push(_environmentStack, _system.__environmentCurrent);
    _system.__environmentCurrent = _environment;
}