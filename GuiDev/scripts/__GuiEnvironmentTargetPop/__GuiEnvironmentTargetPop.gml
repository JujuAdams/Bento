// Feather disable all

function __GuiEnvironmentTargetPop()
{
    static _system = __GuiSystem();
    static _environmentStack = _system.__environmentStack;
    
    if (array_length(_environmentStack) <= 0) __GuiError("Environment stack is empty");
    _system.__environmentCurrent = array_pop(_environmentStack);
}