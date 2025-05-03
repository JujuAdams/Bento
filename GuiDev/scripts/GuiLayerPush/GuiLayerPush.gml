// Feather disable all

/// @param layer

function GuiLayerPush(_layer)
{
    static _system = __GuiSystem();
    static _layerStack = _system.__layerStack;
    
    array_push(_layerStack, _system.__layerCurrent);
    _system.__layerCurrent = _layer;
}