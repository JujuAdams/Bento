function __BentoLayerStackPop()
{
    static _layerStack = __BentoGlobal().__layerStack;
    if (array_length(_layerStack) > 1) array_delete(_layerStack, 0, 1);
}