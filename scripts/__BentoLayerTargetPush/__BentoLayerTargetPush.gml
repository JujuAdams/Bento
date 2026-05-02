// Feather disable all

/// @param layer

function __BentoLayerTargetPush(_layer)
{
    static _system = __BentoSystem();
    static _layerStack = _system.__layerStack;
    
    array_push(_layerStack, _system.__layerCurrent);
    _system.__layerCurrent = _layer;
}