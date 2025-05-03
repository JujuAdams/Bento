// Feather disable all

/// @param layer

function GuiLayerExists(_layer)
{
    if (_layer == undefined) return false;
    return (array_get_index(_layer.__environment.__layerArray, _layer) >= 0);
}