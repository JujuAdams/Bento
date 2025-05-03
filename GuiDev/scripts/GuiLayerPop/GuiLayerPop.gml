// Feather disable all

function GuiLayerPop()
{
    static _system = __GuiSystem();
    static _layerStack = _system.__layerStack;
    
    if (array_length(_layerStack) <= 0)
    {
        __GuiError("Layer stack is empty");
    }
    
    _system.__layerCurrent = array_pop(_layerStack);
}