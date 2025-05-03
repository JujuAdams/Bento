// Feather disable all

/// @param layer

function GuiLayerDestroy(_layer)
{
    if (_layer == undefined) return;
    _layer.__Destroy();
}