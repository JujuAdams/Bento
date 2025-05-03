// Feather disable all

/// @param environment

function GuiEnvironmentPush(_environment)
{
    static _system = __GuiSystem();
    static _environmentStack = _system.__environmentStack;
    
    array_push(_environmentStack, _system.__environmentCurrent);
    _system.__environmentCurrent = _environment;
    
    GuiLayerPush(_environment.__layerCurrent);
}