function __BentoLayerStackPush(_struct)
{
    static _layerStack = __BentoGlobal().__layerStack;
    array_insert(_layerStack, 0, _struct);
}