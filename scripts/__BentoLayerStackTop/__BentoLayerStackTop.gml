function __BentoLayerStackTop()
{
    static _layerStack = __BentoGlobal().__layerStack;
    return (array_length(_layerStack) <= 0)? undefined : _layerStack[0];
}