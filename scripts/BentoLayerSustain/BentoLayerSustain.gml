/// Sustains the layer with the given name. This function should be called every frame to prevent
/// a volatile layer from being destroyed.
/// 
/// @param name

function BentoLayerSustain(_name)
{
    return BentoHostCurrent().__LayerSustain(_name);
}