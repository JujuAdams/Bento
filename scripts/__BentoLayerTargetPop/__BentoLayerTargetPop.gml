// Feather disable all

function __BentoLayerTargetPop()
{
    static _system = __BentoSystem();
    static _layerStack = _system.__layerStack;
    
    if (array_length(_layerStack) <= 0)
    {
        __BentoError("Layer stack is empty");
    }
    
    _system.__layerCurrent = array_pop(_layerStack);
}