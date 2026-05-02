// Feather disable all

function __BentoEnvironmentTargetPop()
{
    static _system = __BentoSystem();
    static _environmentStack = _system.__environmentStack;
    
    if (array_length(_environmentStack) <= 0) __BentoError("Environment stack is empty");
    _system.__environmentCurrent = array_pop(_environmentStack);
}